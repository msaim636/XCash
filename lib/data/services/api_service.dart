import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcash_app/core/helper/shared_preference_helper.dart';
import 'package:xcash_app/core/route/route.dart';
import 'package:xcash_app/core/utils/method.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/data/model/authorization/authorization_response_model.dart';
import 'package:xcash_app/data/model/general_setting/general_setting_response_model.dart';
import 'package:xcash_app/data/model/general_setting/module_settings_response_model.dart';
import 'package:xcash_app/data/model/global/response_model/response_model.dart';


class ApiClient extends GetxService{

  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});
  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
    List<File>? files,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {

        if (files != null && files.isNotEmpty) {
          var request = http.MultipartRequest('POST', url);
          if (passHeader) {
            initToken();
              request.headers.addAll({
                "Accept": "application/json",
                "Authorization": "$tokenType $token"
              });
          }
          if (params != null) {
            request.fields.addAll(params.map((key, value) => MapEntry(key, value.toString())));
          }
          for (var file in files) {
            request.files.add(http.MultipartFile('attachments[]', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
          }

          // print(request.files.length);
          // print(request.files.toString());

          var streamedResponse = await request.send();
          response = await http.Response.fromStream(streamedResponse);
        }

        if (passHeader) {
          initToken();

          response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(url, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.get(
            url,
          );
        }
      }

      // print('url--------------${uri.toString()}');
      // print('params-----------${params.toString()}');
      // print('status-----------${response.statusCode}');
      // print('body-------------${response.body.toString()}');
      // print('token------------$token');

      if (response.statusCode == 200) {
        try {
          AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          
          if (model.remark == 'profile_incomplete') {
            Get.toNamed(RouteHelper.profileCompleteScreen);
          } else if (model.remark == 'kyc_verification') {
            Get.offAndToNamed(RouteHelper.kycScreen);
          } else if (model.remark == 'unauthenticated') {
            sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.loginScreen);
          } else if (model.remark == "unverified") {
            checkAndGotoNextStep(model);
          }
        } catch (e) {
          e.toString();
        }

        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(false, MyStrings.unAuthorized.tr, 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, MyStrings.serverError.tr, 500, response.body);
      } else {
        return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  String token='';
  String tokenType='';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
      sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType =
      sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }
    void checkAndGotoNextStep(AuthorizationResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;

    bool isProfileCompleteEnable = responseModel.data?.user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(
        RouteHelper.twoFactorScreen,
      );
    } else {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    }
  }

  storeGeneralSetting(GeneralSettingResponseModel model){
    String json=jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingResponseModel getGSData(){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
    return model;
  }
   storeAppOpeningStatus(bool status) {
    sharedPreferences.setBool(SharedPreferenceHelper.appOpeningStatus, status);
  }
    bool getFirstTimeAppOpeningStatus() {
    bool status = sharedPreferences.getBool(SharedPreferenceHelper.appOpeningStatus) ?? false;
    return status;
  }
    String getSocialCredentialsRedirectUrl() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
    String redirect = model.data?.socialLoginRedirect ?? "";
    return redirect;
  }

   SocialiteCredentials getSocialCredentialsConfigData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
    SocialiteCredentials social = model.data?.generalSetting?.socialiteCredentials ?? SocialiteCredentials();
    return social;
  }

  bool getSocialCredentialsEnabledAll() {
    return getSocialCredentialsConfigData().google?.status == '1' && getSocialCredentialsConfigData().linkedin?.status == '1' && getSocialCredentialsConfigData().facebook?.status == '1';
  }

  bool isSocialAnyOfSocialLoginOptionEnable() {
    return getSocialCredentialsConfigData().google?.status == '1' ||  getSocialCredentialsConfigData().linkedin?.status == '1' || getSocialCredentialsConfigData().facebook?.status == '1';
  }


  String getCurrencyOrUsername({bool isCurrency = true,bool isSymbol = false}){

    if(isCurrency){

      String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
      GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
      String currency = isSymbol?model.data?.generalSetting?.curSym??'':model.data?.generalSetting?.curText??'';
      return currency;

    } else{

      String username = sharedPreferences.getString(SharedPreferenceHelper.userNameKey)??'';
      return username;

    }

  }

  bool getPasswordStrengthStatus(){
      String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
      GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
      bool checkPasswordStrength = model.data?.generalSetting?.securePassword.toString() == '0' ? false : true;
      return checkPasswordStrength;
  }

  String getTemplateName (){
      String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
      GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
      String templateName = model.data?.generalSetting?.activeTemplate??'';
      return templateName;
  }

  storeModuleSetting(ModuleSettingsResponseModel model){
    String json=jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.moduleSettingKey, json);
    getModuleSettingsData();
  }

  ModuleSettingsResponseModel getModuleSettingsData(){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.moduleSettingKey)??'';
    ModuleSettingsResponseModel model=ModuleSettingsResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
    return model;
  }




  bool getModuleStatus(String key) {

    String pre= sharedPreferences.getString(SharedPreferenceHelper.moduleSettingKey)??'';
    ModuleSettingsResponseModel model= ModuleSettingsResponseModel.fromJson(jsonDecode(pre.isEmpty ? '{}' : pre));
    List<User>?userModule = model.data?.moduleSetting?.user;

    var addMoneyModule           = userModule?.where((element) => element.slug == key).first;
    bool status                  = addMoneyModule!=null && addMoneyModule.status == '0'?false:true;

    return status;
  }


}