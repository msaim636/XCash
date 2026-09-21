import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/style.dart';
import 'package:xcash_app/data/controller/onboard/onboard_controller.dart';
import 'package:xcash_app/view/screens/onboard/widget/circular_button_with_indicator.dart';
import 'package:xcash_app/view/screens/onboard/widget/onboard_content.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/services/api_service.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    // final controller = Get.put(OnboardController());
    Get.put(ApiClient(sharedPreferences: Get.find()));
    final controller = Get.put(OnboardController());
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ApiClient>().storeAppOpeningStatus(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<OnboardController>(
      builder: (controller) => Container(
          color: MyColor.primaryColor,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: MyColor.colorWhite,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.currentIndex == controller.onboardTitleList.length - 1
                    ? const SizedBox.shrink()
                    : SafeArea(
                        child: Container(
                          margin: EdgeInsets.only(top: size.height * .02, right: size.width * .06),
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(RouteHelper.loginScreen);
                            },
                            child: Text(MyStrings.skip.tr, style: semiBoldLarge.copyWith(color: MyColor.colorBlack)),
                          ),
                        ),
                      ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.controller,
                    itemCount: controller.onboardTitleList.length,
                    onPageChanged: (int index) {
                      setState(() {
                        controller.currentIndex = index;
                      });
                    },
                    itemBuilder: (_, index) {
                     
                      return OnboardContent(
                        controller: controller,
                        title: controller.onboardTitleList[index].toString(),
                        subTitle: controller.onboardSubtitleList[index].toString(),
                        index: index,
                        image: controller.onboardImageList[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.space10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardTitleList.length,
                    (index) => Container(
                      height: 10,
                      width: controller.currentIndex == index ? Dimensions.space20 : Dimensions.space10,
                      margin: const EdgeInsets.only(right: Dimensions.space5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: controller.currentIndex == index ? MyColor.primaryColor : MyColor.bodyTextColor,
                      ),
                    ),
                  ),
                ),
                CircularButtonWithIndicator(controller: controller)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
