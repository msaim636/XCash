import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:xcash_app/core/route/route.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/core/utils/url_container.dart';
import 'package:xcash_app/data/model/global/response_model/response_model.dart';
import 'package:xcash_app/data/model/qr_code/qr_code_response_model.dart';
import 'package:xcash_app/data/model/qr_code/qr_code_scan_response_model.dart';
import 'package:xcash_app/data/repo/qr_code/qr_code_repo.dart';
import 'package:xcash_app/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:http/http.dart' as http;

class QrCodeController extends GetxController {
  QrCodeRepo qrCodeRepo;
  QrCodeController({required this.qrCodeRepo});

  bool isLoading = true;
  QrCodeResponseModel model = QrCodeResponseModel();

  String qrCode = "";
  String username = '';

  Future<void> loadData() async {
    username = qrCodeRepo.apiClient.getCurrencyOrUsername(isCurrency: false);
    isLoading = true;
    update();

    ResponseModel responseModel = await qrCodeRepo.getQrData();
    if (responseModel.statusCode == 200) {
      model = QrCodeResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status.toString().toLowerCase() == "success") {
        qrCode = model.data?.qrCode ?? "";
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  String downloadUrl = "";
  String _localPath = '';
  String downloadFileName = "";
  bool downloadLoading = false;
  Future<void> downloadImage() async {
    downloadLoading = true;
    update();
    final headers = {
      'Authorization': "Bearer ${qrCodeRepo.apiClient.token}",
      'content-type': 'image/png',
    };

    String url = "${UrlContainer.baseUrl}${UrlContainer.qrCodeImageDownload}";
    http.Response response = await http.post(Uri.parse(url), body: null, headers: headers);
    // print("this is response body>>>${response.body}");
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      String extension = "png";

      await saveAndOpenFile(bytes, '${MyStrings.appName}_${DateTime.now().millisecondsSinceEpoch}.$extension', extension);

      // print('response body: ${response.bodyBytes}');
    } else {
      downloadLoading = false;
      update();
      CustomSnackBar.error(errorList: [MyStrings.downloadFileNotFound]);
    }
    return;
  }

  bool isSubmitLoading = false;
  int selectedIndex = -1;

  Future<void> saveAndOpenFile(List<int> bytes, String fileName, String extension) async {
    Directory? downloadsDirectory;

    if (Platform.isAndroid) {
      var status = await Permission.storage.request();

      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }

    if (downloadsDirectory != null) {
      final downloadPath = '${downloadsDirectory.path}/$fileName';
      final file = File(downloadPath);
      await file.writeAsBytes(bytes);
      CustomSnackBar.success(successList: ['File saved at: $downloadPath']);
      // print('File saved at: $downloadPath');
      await openFile(downloadPath, extension);
    } else {
      CustomSnackBar.error(errorList: [MyStrings.downloadDirNotFound]);
    }
    downloadLoading = false;
    update();
  }

  Future<void> openFile(String path, String extension) async {
    final file = File(path);
    if (await file.exists()) {
      final result = await OpenFile.open(path);
      if (result.type != ResultType.done) {
        if (result.type == ResultType.noAppToOpen) {
          CustomSnackBar.error(errorList: [MyStrings.noDocOpenerApp, 'File saved at: $path']);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [MyStrings.fileNotFound]);
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        return directory.path;
      } else {
        return (await getExternalStorageDirectory())?.path ?? "";
      }
    } else if (Platform.isIOS) {
      return (await getApplicationDocumentsDirectory()).path;
    } else {
      return null;
    }
  }

  Future<void> shareImage() async {
    try {
      final box = Get.context?.findRenderObject() as RenderBox?;
      if (box != null) {
        // print("This is QR code: $qrCode");
        await Share.share(
          qrCode,
          subject: MyStrings.share.tr,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        );
      } else {
        // print("RenderBox is null");
      }
    } catch (e) {
      // print("Error sharing QR code: $e");
    }
  }

  bool isScannerLoading = false;
  Future<bool> submitQrData(String scannedData) async {
    isScannerLoading = true;
    update();

    bool requestStatus = false;

    ResponseModel responseModel = await qrCodeRepo.qrCodeScan(scannedData);
    if (responseModel.statusCode == 200) {
      QrCodeScanResponseModel scanModel = QrCodeScanResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (scanModel.status.toString().toLowerCase() == "success") {
        String userType = scanModel.data?.userType ?? "";
        String userName = scanModel.data?.userData?.username ?? "";
        if (userType.toLowerCase() == 'agent') {
          Get.offAndToNamed(RouteHelper.moneyOutScreen, arguments: userName);
        } else if (userType.toLowerCase() == 'merchant') {
          Get.offAndToNamed(RouteHelper.makePaymentScreen, arguments: userName);
        } else if (userType.toLowerCase() == 'user') {
          Get.offAndToNamed(RouteHelper.transferMoneyScreen, arguments: userName);
        } else {
          Get.back();
          CustomSnackBar.error(errorList: [MyStrings.invalidUserType]);
        }
      } else {
        requestStatus = false;
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      requestStatus = false;
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isScannerLoading = false;
    update();

    return requestStatus;
  }
}
