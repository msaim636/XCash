import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/core/utils/style.dart';
import 'package:xcash_app/data/controller/withdraw/add_withdraw_method_controller.dart';
import 'package:xcash_app/data/model/withdraw/add_withdraw_method_response_model.dart';
import 'package:xcash_app/data/repo/withdraw/add_withdraw_method_repo.dart';
import 'package:xcash_app/data/services/api_service.dart';
import 'package:xcash_app/view/components/app-bar/custom_appbar.dart';
import 'package:xcash_app/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:xcash_app/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:xcash_app/view/components/buttons/rounded_button.dart';
import 'package:xcash_app/view/components/buttons/rounded_loading_button.dart';
import 'package:xcash_app/view/components/card/bottom_sheet_card.dart';
import 'package:xcash_app/view/components/checkbox/custom_check_box.dart';
import 'package:xcash_app/view/components/custom_drop_down_button_with_text_field.dart';
import 'package:xcash_app/view/components/custom_loader/custom_loader.dart';
import 'package:xcash_app/view/components/custom_radio_button.dart';
import 'package:xcash_app/view/components/text-form-field/custom_text_field.dart';
import 'package:xcash_app/view/components/text/label_text.dart';
import 'package:xcash_app/view/components/text/label_text_with_instructions.dart';
import 'package:xcash_app/view/screens/transaction/widget/filter_row_widget.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_method/widget/file_item.dart';

class AddWithdrawMethodScreen extends StatefulWidget {
  const AddWithdrawMethodScreen({super.key});

  @override
  State<AddWithdrawMethodScreen> createState() => _AddWithdrawMethodScreenState();
}

class _AddWithdrawMethodScreenState extends State<AddWithdrawMethodScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AddWithdrawMethodRepo(apiClient: Get.find()));
    final controller = Get.put(AddWithdrawMethodController(addWithdrawMethodRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWithdrawMethodController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          title: MyStrings.addWithdrawMethod.tr,
          bgColor: MyColor.getAppBarColor(),
        ),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelText(text: MyStrings.selectMethod),
                    const SizedBox(height: Dimensions.textToTextSpace),
                    SizedBox(
                      height: 50,
                      child: FilterRowWidget(
                          borderColor: controller.selectedMethod?.id.toString() == "-1" ? MyColor.textFieldDisableBorderColor : MyColor.textFieldEnableBorderColor,
                          text: "${controller.selectedMethod?.id.toString() == "-1" ? MyStrings.selectMethod : controller.selectedMethod?.name}",
                          press: () => CustomBottomSheet(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BottomSheetHeaderRow(header: ''),
                                  ListView.builder(
                                      itemCount: controller.methodList.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            final controller = Get.find<AddWithdrawMethodController>();
                                            WithdrawMethod selectedValue = controller.methodList[index];
                                            controller.setSelectedMethod(selectedValue);
                                            Navigator.pop(context);

                                            FocusScopeNode currentFocus = FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                          },
                                          child: BottomSheetCard(
                                            child: Text(
                                              controller.methodList[index].name?.tr ?? "",
                                              style: regularDefault,
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              )).customBottomSheet(context)),
                    ),
                    const SizedBox(height: Dimensions.space15),
                    const LabelText(text: MyStrings.selectCurrency),
                    const SizedBox(height: Dimensions.textToTextSpace),
                    SizedBox(
                      height: 50,
                      child: FilterRowWidget(
                          borderColor: controller.selectedCurrencyModel.curName == MyStrings.selectOne ? MyColor.textFieldDisableBorderColor : MyColor.textFieldEnableBorderColor,
                          text: controller.selectedCurrencyModel.curName == MyStrings.selectOne ? MyStrings.selectCurrency : controller.selectedCurrencyModel.curName,
                          press: () => CustomBottomSheet(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BottomSheetHeaderRow(header: ''),
                                  const SizedBox(height: Dimensions.space15),
                                  ListView.builder(
                                      itemCount: controller.selectedCurrencyList.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            final controller = Get.find<AddWithdrawMethodController>();
                                            CurrencyModel selectedValue = controller.selectedCurrencyList[index];
                                            controller.setSelectedCurrency(selectedValue);
                                            Navigator.pop(context);

                                            FocusScopeNode currentFocus = FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                          },
                                          child: BottomSheetCard(
                                            child: Text(
                                              controller.selectedCurrencyList[index].curName.tr,
                                              style: regularDefault,
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              )).customBottomSheet(context)),
                    ),
                    const SizedBox(height: Dimensions.space15),
                    CustomTextField(needOutlineBorder: true, isRequired: true, controller: controller.nameController, labelText: MyStrings.provideNickName.tr, hintText: MyStrings.provideNickName.toLowerCase(), onChanged: (value) {}),
                    Visibility(
                      visible: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.space15),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: controller.formList.length,
                              itemBuilder: (ctx, index) {
                                FormModel model = controller.formList[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    model.type == 'text' || model.type == 'number' || model.type == 'email' || model.type == 'url'
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomTextField(
                                                  instructions: model.instruction,
                                                  isRequired: model.isRequired == 'optional' ? false : true,
                                                  hintText: (model.name ?? '').toString().capitalizeFirst,
                                                  needOutlineBorder: true,
                                                  labelText: model.name ?? '',
                                                  textInputType: model.type == 'number'
                                                      ? TextInputType.number
                                                      : model.type == 'email'
                                                          ? TextInputType.emailAddress
                                                          : model.type == 'url'
                                                              ? TextInputType.url
                                                              : TextInputType.text,
                                                  validator: (value) {
                                                    if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                      return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    controller.changeSelectedValue(value, index);
                                                  }),
                                              const SizedBox(height: Dimensions.space10),
                                            ],
                                          )
                                        : model.type == 'textarea'
                                            ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextField(
                                                      instructions: model.instruction,
                                                      isRequired: model.isRequired == 'optional' ? false : true,
                                                      needOutlineBorder: true,
                                                      maxLines: 5,
                                                      labelText: model.name ?? '',
                                                      hintText: (model.name ?? '').capitalizeFirst,
                                                      inputAction: TextInputAction.newline,
                                                      textInputType: TextInputType.multiline,
                                                      validator: (value) {
                                                        if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                          return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      onChanged: (value) {
                                                        controller.changeSelectedValue(value, index);
                                                      }),
                                                  const SizedBox(height: Dimensions.space10),
                                                ],
                                              )
                                            : model.type == 'select'
                                                ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      LabelTextInstruction(
                                                        text: model.name ?? '',
                                                        isRequired: model.isRequired == 'optional' ? false : true,
                                                        instructions: model.instruction,
                                                      ),
                                                      const SizedBox(
                                                        height: Dimensions.textToTextSpace,
                                                      ),
                                                      CustomDropDownWithTextField(
                                                          list: model.options ?? [],
                                                          onChanged: (value) {
                                                            controller.changeSelectedValue(value, index);
                                                          },
                                                          selectedValue: model.selectedValue),
                                                      const SizedBox(height: Dimensions.space10)
                                                    ],
                                                  )
                                                : model.type == 'radio'
                                                    ? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          LabelTextInstruction(
                                                            text: model.name ?? '',
                                                            isRequired: model.isRequired == 'optional' ? false : true,
                                                            instructions: model.instruction,
                                                          ),
                                                          CustomRadioButton(
                                                            title: model.name,
                                                            selectedIndex: controller.formList[index].options?.indexOf(model.selectedValue ?? '') ?? 0,
                                                            list: model.options ?? [],
                                                            onChanged: (selectedIndex) {
                                                              controller.changeSelectedRadioBtnValue(index, selectedIndex);
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    : model.type == 'checkbox'
                                                        ? Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              LabelTextInstruction(
                                                                text: model.name ?? '',
                                                                isRequired: model.isRequired == 'optional' ? false : true,
                                                                instructions: model.instruction,
                                                              ),
                                                              CustomCheckBox(
                                                                selectedValue: controller.formList[index].cbSelected,
                                                                list: model.options ?? [],
                                                                onChanged: (value) {
                                                                  controller.changeSelectedCheckBoxValue(index, value);
                                                                },
                                                              ),
                                                            ],
                                                          )
                                                        : model.type == 'file'
                                                            ? Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  LabelTextInstruction(
                                                                    text: model.name ?? '',
                                                                    isRequired: model.isRequired == 'optional' ? false : true,
                                                                    instructions: model.instruction,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                    child: ConfirmWithdrawFileItem(index: index),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text("${MyStrings.supportedFileType} ", style: regularSmall.copyWith(color: MyColor.highPriorityPurpleColor)),
                                                                      Text(model.extensions ?? '', style: regularSmall.copyWith(color: MyColor.highPriorityPurpleColor)),
                                                                    ],
                                                                  )
                                                                ],
                                                              )
                                                            : model.type == 'datetime'
                                                                ? Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                        child: CustomTextField(
                                                                            instructions: model.instruction,
                                                                            isRequired: model.isRequired == 'optional' ? false : true,
                                                                            hintText: (model.name ?? '').toString().capitalizeFirst,
                                                                            needOutlineBorder: true,
                                                                            labelText: model.name ?? '',
                                                                            controller: controller.formList[index].textEditingController,
                                                                            // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                                                            textInputType: TextInputType.datetime,
                                                                            readOnly: true,
                                                                            validator: (value) {
                                                                              // print(model.isRequired);
                                                                              if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                                                return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                            onTap: () {
                                                                              controller.changeSelectedDateTimeValue(index, context);
                                                                            },
                                                                            onChanged: (value) {
                                                                              // print(value);
                                                                              controller.changeSelectedValue(value, index);
                                                                            }),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : model.type == 'date'
                                                                    ? Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                            child: CustomTextField(
                                                                                instructions: model.instruction,
                                                                                isRequired: model.isRequired == 'optional' ? false : true,
                                                                                hintText: (model.name ?? '').toString().capitalizeFirst,
                                                                                needOutlineBorder: true,
                                                                                labelText: model.name ?? '',
                                                                                controller: controller.formList[index].textEditingController,
                                                                                // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                                                                textInputType: TextInputType.datetime,
                                                                                readOnly: true,
                                                                                validator: (value) {
                                                                                  // print(model.isRequired);
                                                                                  if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                                                    return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                onTap: () {
                                                                                  controller.changeSelectedDateOnlyValue(index, context);
                                                                                },
                                                                                onChanged: (value) {
                                                                                  // print(value);
                                                                                  controller.changeSelectedValue(value, index);
                                                                                }),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : model.type == 'time'
                                                                        ? Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                                child: CustomTextField(
                                                                                    instructions: model.instruction,
                                                                                    isRequired: model.isRequired == 'optional' ? false : true,
                                                                                    hintText: (model.name ?? '').toString().capitalizeFirst,
                                                                                    needOutlineBorder: true,
                                                                                    labelText: model.name ?? '',
                                                                                    controller: controller.formList[index].textEditingController,
                                                                                    // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                                                                    textInputType: TextInputType.datetime,
                                                                                    readOnly: true,
                                                                                    validator: (value) {
                                                                                      // print(model.isRequired);
                                                                                      if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                                                        return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                                                      } else {
                                                                                        return null;
                                                                                      }
                                                                                    },
                                                                                    onTap: () {
                                                                                      controller.changeSelectedTimeOnlyValue(index, context);
                                                                                    },
                                                                                    onChanged: (value) {
                                                                                      // print(value);
                                                                                      controller.changeSelectedValue(value, index);
                                                                                    }),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : const SizedBox(),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.space25),
                    controller.submitLoading
                        ? const RoundedLoadingBtn()
                        : RoundedButton(
                            press: () {
                              controller.submitData();
                            },
                            text: MyStrings.addWithdrawMethod),
                  ],
                ),
              ),
      ),
    );
  }
}
