import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/data/controller/common/theme_controller.dart';
import 'package:xcash_app/data/controller/faq_controller/faq_controller.dart';
import 'package:xcash_app/data/repo/faq_repo/faq_repo.dart';
import 'package:xcash_app/view/components/app-bar/custom_appbar.dart';
import 'package:xcash_app/view/components/no_data.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';
import 'faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    ThemeController themeController = Get.put(ThemeController(sharedPreferences: Get.find()));
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FaqRepo(apiClient: Get.find()));
    final controller = Get.put(FaqController(faqRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(isShowBackBtn: true, title: MyStrings.faq.tr),
        body: GetBuilder<FaqController>(
          builder: (controller) => controller.isLoading
              ? const CustomLoader()
              : controller.faqList.isEmpty
                  ? const NoDataWidget()
                  : SingleChildScrollView(
                      padding: Dimensions.screenPadding,
                      physics: const BouncingScrollPhysics(),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.faqList.length,
                        separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                        itemBuilder: (context, index) => FaqListItem(
                            answer: (controller.faqList[index].dataValues?.answer ?? '').tr,
                            question: (controller.faqList[index].dataValues?.question ?? '').tr,
                            index: index,
                            press: () {
                              controller.changeSelectedIndex(index);
                            },
                            selectedIndex: controller.selectedIndex),
                      ),
                    ),
        ));
  }
}
