import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcash_app/core/helper/shared_preference_helper.dart';
import 'package:xcash_app/push_notification_service.dart';
import 'package:xcash_app/view/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:xcash_app/view/components/preview_image.dart';
import 'package:xcash_app/view/screens/Profile/profile_screen.dart';
import 'package:xcash_app/view/screens/account/change-password/change_password_screen.dart';
import 'package:xcash_app/view/screens/add-money/add_money/add_money_screen.dart';
import 'package:xcash_app/view/screens/add-money/add_money/add_money_web_view.dart';
import 'package:xcash_app/view/screens/add-money/add_money_history/add_money_history_screen.dart';
import 'package:xcash_app/view/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:xcash_app/view/screens/auth/forget_password/forget_password/forget_password.dart';
import 'package:xcash_app/view/screens/auth/forget_password/reset_password/reset_password_screen.dart';
import 'package:xcash_app/view/screens/auth/forget_password/verify_forget_password/verify_forget_password_screen.dart';
import 'package:xcash_app/view/screens/auth/kyc/kyc.dart';
import 'package:xcash_app/view/screens/auth/login/login_screen.dart';
import 'package:xcash_app/view/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:xcash_app/view/screens/auth/registration/registration_screen.dart';
import 'package:xcash_app/view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:xcash_app/view/screens/edit_profile/edit_profile_screen.dart';
import 'package:xcash_app/view/screens/exchange/exchange_money_screen.dart';
import 'package:xcash_app/view/screens/faq/faq_screen.dart';
import 'package:xcash_app/view/screens/invoice/create_invoice/create_invoice_screen.dart';
import 'package:xcash_app/view/screens/invoice/my_invoice/invoice_screen.dart';
import 'package:xcash_app/view/screens/invoice/update_invoice/update_invoice_screen.dart';
import 'package:xcash_app/view/screens/language/language_screen.dart';
import 'package:xcash_app/view/screens/money_discharge/make_payment/make_payment.dart';
import 'package:xcash_app/view/screens/onboard/onboard_screen.dart';
import 'package:xcash_app/view/screens/otp/otp_screen.dart';
import 'package:xcash_app/view/screens/money_discharge/money_out/money_out_screen.dart';
import 'package:xcash_app/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:xcash_app/view/screens/qr_code/my_qr_code.dart';
import 'package:xcash_app/view/screens/qr_code/qr_code_scanner.dart';
import 'package:xcash_app/view/screens/request-money/request_money/request_money.dart';
import 'package:xcash_app/view/screens/request-money/request_to_me/request_to_me_screen.dart';
import 'package:xcash_app/view/screens/splash/splash_screen.dart';
import 'package:xcash_app/view/screens/ticket/all_ticket_screen.dart';
import 'package:xcash_app/view/screens/ticket/new_ticket_screen/new_ticket_screen.dart';
import 'package:xcash_app/view/screens/ticket/ticket_details_screen/ticket_details_screen.dart';
import 'package:xcash_app/view/screens/transaction/transaction_history_screen.dart';
import 'package:xcash_app/view/screens/transfer/transfer_money_screen.dart';
import 'package:xcash_app/view/screens/two_factor/two_factor_setup_screen/two_factor_setup_screen.dart';
import 'package:xcash_app/view/screens/two_factor/two_factor_verification_screen/two_factor_verification_screen.dart';
import 'package:xcash_app/view/screens/voucher/create_voucher/create_voucher.dart';
import 'package:xcash_app/view/screens/voucher/my_voucher/my_voucher_screen.dart';
import 'package:xcash_app/view/screens/voucher/redeem_log/redeem_log_screen.dart';
import 'package:xcash_app/view/screens/wallet/my_wallet_screen.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_history/withdraw_history_screen.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_method/add_withdraw_method.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_method/edit_withdraw_method.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_method/withdraw_method_screen.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_money/withdraw_money_screen.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_preview/withdraw_preview_screen.dart';

import '../../data/model/user/user.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = "/onboard_screen";
  static const String faqScreen = "/faq_screen";
  static const String loginScreen = "/login_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String registrationScreen = "/registration_screen";
  static const String otpScreen = "/otp_screen";
  static const String bottomNavBar = "/bottom_nav_bar";
  static const String myWalletScreen = "/my_wallet_screen";

  static const String addMoneyHistoryScreen = "/add_money_history_screen";
  static const String addMoneyScreen = "/add_money_screen";
  static const String addMoneyWebScreen = "/add_money_web_screen";

  static const String profileCompleteScreen = "/profile_complete_screen";

  static const String emailVerificationScreen = "/verify_email_screen";
  static const String smsVerificationScreen = "/verify_sms_screen";
  static const String verifyPassCodeScreen = "/verify_pass_code_screen";
  static const String twoFactorScreen = "/two-factor-screen";
  static const String twoFactorSetUpScreen = "/two-factor-setup-screen";
  static const String resetPasswordScreen = "/reset_pass_screen";

  static const String invoiceScreen = "/invoice_screen";
  static const String createInvoiceScreen = "/create_invoice_screen";
  static const String updateInvoiceScreen = "/update_invoice_screen";

  static const String transactionHistoryScreen = "/transaction_history_screen";

  static const String myVoucherScreen = "/my_voucher_screen";
  static const String requestToMeScreen = "/request_to_me_screen";

  static const String withdrawMoneyScreen = "/withdraw_money_screen";
  static const String withdrawPreviewScreen = "/withdraw_preview_screen";
  static const String withdrawHistoryScreen = "/withdraw_history_screen";
  static const String addWithdrawMethodScreen = "/add_withdraw_method_screen";
  static const String withdrawMethodScreen = "/withdraw_method_screen";
  static const String editWithdrawMethod = "/withdraw_method_edit_screen";

  static const String notificationScreen = "/notification_screen";
  static const String profileScreen = "/profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String kycScreen = "/kyc_screen";

  static const String exchangeMoneyScreen = "/exchange_money_screen";

  static const String requestMoneyScreen = "/request_money_screen";

  static const String makePaymentScreen = "/make_payment_screen";
  static const String moneyOutScreen = "/money_out_screen";

  static const String transferMoneyScreen = "/transfer_money_screen";

  static const String createVoucherScreen = "/create_voucher_screen";
  static const String redeemLogScreen = "/redeem_log_screen";
  static const String privacyScreen = "/privacy_screen";
  static const String myQrCodeScreen = "/my_qr_code_screen";
  static const String qrCodeScanner = "/qr_code_scanner_screen";

  static const String languageScreen = "/languages_screen";

  static const String allTicketScreen = '/all_ticket_screen';
  static const String ticketDetailsdScreen = '/ticket_details_screen';
  static const String newTicketScreen = '/new_ticket_screen';

  static const String previewImageScreen = "/preview-image-screen";
  static const String supportTicketScreen = "/support-ticket-screen";

  List<GetPage> routes = [
    GetPage(name: onboardScreen, page: () => const OnBoardingScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),
    GetPage(name: bottomNavBar, page: () => const BottomNavBar()),
    GetPage(name: myWalletScreen, page: () => const MyWalletScreen()),
    GetPage(name: addMoneyHistoryScreen, page: () => const AddMoneyHistoryScreen()),
    GetPage(name: addMoneyScreen, page: () => const AddMoneyScreen()),
    GetPage(name: addMoneyWebScreen, page: () => AddMoneyWebView(redirectUrl: Get.arguments)),
    GetPage(name: invoiceScreen, page: () => const InvoiceScreen()),
    GetPage(name: createInvoiceScreen, page: () => const CreateInvoiceScreen()),
    GetPage(name: updateInvoiceScreen, page: () => const UpdateInvoiceScreen()),
    GetPage(name: myVoucherScreen, page: () => const MyVoucherScreen()),
    GetPage(name: withdrawMoneyScreen, page: () => const WithdrawMoneyScreen()),
    GetPage(name: withdrawPreviewScreen, page: () => const WithdrawPreviewScreen()),
    GetPage(name: withdrawHistoryScreen, page: () => const WithdrawHistoryScreen()),
    GetPage(name: withdrawMethodScreen, page: () => const WithdrawMethodScreen()),
    GetPage(name: addWithdrawMethodScreen, page: () => const AddWithdrawMethodScreen()),
    GetPage(name: editWithdrawMethod, page: () => const EditWithdrawMethodScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: transactionHistoryScreen, page: () => const TransactionHistoryScreen()),
    GetPage(name: requestToMeScreen, page: () => const RequestToMeScreen()),
    GetPage(name: exchangeMoneyScreen, page: () => const ExchangeMoneyScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: emailVerificationScreen, page: () => const EmailVerificationScreen()),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: twoFactorScreen, page: () => const TwoFactorVerificationScreen()),
    GetPage(name: twoFactorSetUpScreen, page: () => const TwoFactorSetupScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen(actionId: Get.arguments[0], nextRoute: Get.arguments[1], otpType: Get.arguments[2])),
    GetPage(name: requestMoneyScreen, page: () => const RequestMoneyScreen()),
    GetPage(name: makePaymentScreen, page: () => const MakePaymentScreen()),
    GetPage(name: moneyOutScreen, page: () => const MoneyOutScreen()),
    GetPage(name: transferMoneyScreen, page: () => const TransferMoneyScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: createVoucherScreen, page: () => const CreateVoucherScreen()),
    GetPage(name: redeemLogScreen, page: () => const RedeemLogScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: myQrCodeScreen, page: () => const MyQrCodeScreen()),
    GetPage(name: qrCodeScanner, page: () => const QrCodeScannerScreen()),
    GetPage(name: supportTicketScreen, page: () => const AllTicketScreen()),
    GetPage(name: ticketDetailsdScreen, page: () => const TicketDetailsScreen()),
    GetPage(name: newTicketScreen, page: () => const NewTicketScreen()),
    GetPage(name: languageScreen, page: () => const LanguageScreen()),
    GetPage(name: allTicketScreen, page: () => const AllTicketScreen()),
    GetPage(name: previewImageScreen, page: () => PreviewImage(url: Get.arguments)),
  ];
  //

  static Future<void> checkUserStatusAndGoToNextStep(User? user, {bool isRemember = false, String accessToken = "", String tokenType = ""}) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (isRemember) {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await sharedPreferences.setString(SharedPreferenceHelper.userIdKey, user?.id.toString() ?? '-1');
    await sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, user?.mobile ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');

    if (accessToken.isNotEmpty) {
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, accessToken ?? '');
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, tokenType ?? '');
    }

    bool isProfileCompleteEnable = user?.profileComplete == '0' ? true : false;
    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen);
    } else {
      await PushNotificationService(apiClient: Get.find()).sendUserToken().then((v) {
      Get.offAndToNamed(RouteHelper.bottomNavBar, arguments: [true]);
      });

    }
  }
}
