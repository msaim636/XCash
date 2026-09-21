import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/core/utils/style.dart';
import 'package:xcash_app/data/controller/withdraw/edit_withdraw_method_controller.dart';
import 'package:xcash_app/data/repo/withdraw/edit_withdraw_method_repo.dart';
import 'package:xcash_app/data/services/api_service.dart';
import 'package:xcash_app/view/components/app-bar/custom_appbar.dart';
import 'package:xcash_app/view/components/buttons/rounded_button.dart';
import 'package:xcash_app/view/components/buttons/rounded_loading_button.dart';
import 'package:xcash_app/view/components/checkbox/custom_check_box.dart';
import 'package:xcash_app/view/components/custom_drop_down_button_with_text_field.dart';
import 'package:xcash_app/view/components/custom_loader/custom_loader.dart';
import 'package:xcash_app/view/components/custom_radio_button.dart';
import 'package:xcash_app/view/components/text-form-field/custom_text_field.dart';
import 'package:xcash_app/view/components/text/label_text_with_instructions.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_method/widget/edit_file_item.dart';
import '../../../../../data/model/withdraw/edit_withdraw_method_response_model.dart' as withdraw;

class EditWithdrawMethodScreen extends StatefulWidget {
  const EditWithdrawMethodScreen({super.key});

  @override
  State<EditWithdrawMethodScreen> createState() => _EditWithdrawMethodScreenState();
}

class _EditWithdrawMethodScreenState extends State<EditWithdrawMethodScreen> {
  @override
  void initState() {
    final String id = Get.arguments;

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(EditWithdrawMethodRepo(apiClient: Get.find()));
    final controller = Get.put(EditWithdrawMethodController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditWithdrawMethodController>(
      builder: (controller) => Container(
        color: MyColor.primaryColor,
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            title: MyStrings.withdrawMethodEdit,
            bgColor: MyColor.getAppBarColor(),
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(isRequired: true, needRequiredSign: true, needOutlineBorder: true, controller: controller.nameController, labelText: MyStrings.provideNickName.tr, hintText: MyStrings.provideNickName.toLowerCase(), onChanged: (value) {}),
                      const SizedBox(height: Dimensions.space15),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.formList.length,
                          itemBuilder: (ctx, index) {
                            withdraw.FormModel model = controller.formList[index];
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  model.type == 'text' || model.type == 'number' || model.type == 'email' || model.type == 'url'
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                                controller: controller.formList[index].textEditingController,
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
                                                    controller: controller.formList[index].textEditingController,
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
                                                              child: EditWithdrawFileItem(index: index),
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
                                                                            controller.changeSelectedDateTimeValue(index, context, null);
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
                              ),
                            );
                          }),
                      const SizedBox(height: Dimensions.space15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space12, horizontal: Dimensions.space15),
                        decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              MyStrings.status.tr,
                              style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                            ),
                            Switch(value: controller.status == '1', onChanged: (value) => controller.changeStatus())
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
                              text: MyStrings.updateMethod),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
