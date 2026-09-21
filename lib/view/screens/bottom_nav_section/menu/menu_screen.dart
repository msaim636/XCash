import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/route/route.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';
import 'package:xcash_app/core/utils/my_images.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/core/utils/style.dart';
import 'package:xcash_app/core/utils/util.dart';
import 'package:xcash_app/data/controller/localization/localization_controller.dart';
import 'package:xcash_app/data/controller/menu/my_menu_controller.dart';
import 'package:xcash_app/data/repo/auth/general_setting_repo.dart';
import 'package:xcash_app/data/repo/menu_repo/menu_repo.dart';
import 'package:xcash_app/data/services/api_service.dart';
import 'package:xcash_app/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:xcash_app/view/components/divider/custom_divider.dart';
import 'package:xcash_app/view/components/will_pop_widget.dart';
import 'package:xcash_app/view/screens/bottom_nav_section/menu/widget/delete_account_bottom_sheet_body.dart';
import 'package:xcash_app/view/screens/bottom_nav_section/menu/widget/menu_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    final controller = Get.put(MyMenuController(menuRepo: Get.find(), repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) => GetBuilder<MyMenuController>(
        builder: (menuController) => WillPopWidget(
          nextRoute: RouteHelper.bottomNavBar,
          child: Container(
            color: MyColor.primaryColor,
            child: Scaffold(
              backgroundColor: MyColor.screenBgColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: MyColor.primaryColor,
                title: Text(MyStrings.menu, style: regularLarge.copyWith(color: MyColor.colorWhite)),
                automaticallyImplyLeading: false,
              ),
              body: GetBuilder<MyMenuController>(
                builder: (controller) => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space12),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                        decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius), boxShadow: MyUtils.getCardShadow()),
                        child: Column(
                          children: [
                            MenuItems(imageSrc: MyImages.user, label: MyStrings.profile.tr, onPressed: () => Get.toNamed(RouteHelper.profileScreen)),
                            const CustomDivider(space: Dimensions.space10),
                            MenuItems(imageSrc: MyImages.twoFA, label: MyStrings.twoFactorAuth.tr, onPressed: () => Get.toNamed(RouteHelper.twoFactorSetUpScreen)),
                            const CustomDivider(space: Dimensions.space10),
                            MenuItems(imageSrc: MyImages.changePassword, label: MyStrings.changePassword, onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen)),
                            const CustomDivider(space: Dimensions.space10),
                            MenuItems(isSvgImage: false, imageSrc: MyImages.menuQrCode, label: MyStrings.myQrCode, onPressed: () => Get.toNamed(RouteHelper.myQrCodeScreen)),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                        decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius), boxShadow: MyUtils.getCardShadow()),
                        child: Column(
                          children: [
                            Visibility(
                                visible: menuController.isWithdrawEnable,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MenuItems(imageSrc: MyImages.menuWithdraw_1, label: MyStrings.withdraw.tr, onPressed: () => Get.toNamed(RouteHelper.withdrawHistoryScreen)),
                                    const CustomDivider(space: Dimensions.space10),
                                  ],
                                )),
                            Visibility(
                                visible: menuController.isTransferEnable,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MenuItems(imageSrc: MyImages.menuTransfer_1, label: MyStrings.transfer.tr, onPressed: () => Get.toNamed(RouteHelper.transferMoneyScreen)),
                                    const CustomDivider(space: Dimensions.space10),
                                  ],
                                )),
                            Visibility(
                                visible: menuController.isInvoiceEnable,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MenuItems(imageSrc: MyImages.menuInvoice_1, label: MyStrings.invoice.tr, onPressed: () => Get.toNamed(RouteHelper.invoiceScreen)),
                                    const CustomDivider(space: Dimensions.space10),
                                  ],
                                )),
                            MenuItems(imageSrc: MyImages.supportTicket, label: MyStrings.supportTicket.tr, onPressed: () => Get.toNamed(RouteHelper.allTicketScreen)),
                            const CustomDivider(space: Dimensions.space10),
                            MenuItems(imageSrc: MyImages.menuTransaction_1, label: MyStrings.transaction.tr, onPressed: () => Get.toNamed(RouteHelper.transactionHistoryScreen)),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                          decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius), boxShadow: MyUtils.getCardShadow()),
                          child: Column(
                            children: [
                              Visibility(
                                  visible: menuController.langSwitchEnable,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MenuItems(
                                        imageSrc: MyImages.language,
                                        label: MyStrings.language.tr,
                                        onPressed: () {
                                          Get.toNamed(RouteHelper.languageScreen);
                                        },
                                      ),
                                      const CustomDivider(space: Dimensions.space10),
                                    ],
                                  )),
                              MenuItems(
                                  imageSrc: MyImages.faq,
                                  label: MyStrings.faq.tr,
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.faqScreen);
                                  }),
                              const CustomDivider(space: Dimensions.space10),
                              MenuItems(
                                  imageSrc: MyImages.policy,
                                  label: MyStrings.privacyPolicy.tr,
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.privacyScreen);
                                  }),
                              const CustomDivider(space: Dimensions.space10),
                              MenuItems(
                                imageColor: MyColor.redCancelTextColor,
                                  imageSrc: MyImages.deleteUser,
                                  label: MyStrings.deleteAccount.tr,
                                     textStyle:const TextStyle(color: MyColor.redCancelTextColor),
                                   onPressed: () {
                                    CustomBottomSheet(
                                      isNeedMargin: true,
                                      child: const DeleteAccountBottomsheetBody(),
                                    ).customBottomSheet(context);
                                  }),
                              const CustomDivider(space: Dimensions.space10),
                              controller.logoutLoading
                                  ? const Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(color: MyColor.primaryColor, strokeWidth: 2.00),
                                      ),
                                    )
                                  : MenuItems(imageSrc: MyImages.logout, label: MyStrings.logout.tr, onPressed: () => controller.logout())
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
