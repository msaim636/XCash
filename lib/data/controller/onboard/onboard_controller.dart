import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/my_images.dart';
import 'package:xcash_app/data/model/general_setting/general_setting_response_model.dart';
class OnboardController extends GetxController {
  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  List<String> onboardTitleList = [
    'Effortlessly Manage Your Finances with XCash User App',
    'XCash User App: Transfer, Request, Exchange Money Easily',
    'Add, Transfer, and Manage Funds Seamlessly with XCash',
  ];


  List<String> onboardSubtitleList = [
    'Effortlessly manage your finances with the intuitive and powerful XCash user app.',
    'The XCash User App lets you transfer, request, and exchange money easily and efficiently.',
    'Effortlessly add, transfer, and manage funds with XCash for seamless financial transactions!',
  ];

  List<String> onboardImageList = [
    MyImages.onboardFirstImage,
    MyImages.onboardSecondImage,
    MyImages.onboardThirdImage,
  ];

  bool isLoading = true;

  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();

  List<String> onBoardImage = [];
}
