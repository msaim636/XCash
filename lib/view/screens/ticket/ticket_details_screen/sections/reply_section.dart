import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/data/controller/support/ticket_details_controller.dart';
import 'package:xcash_app/view/components/buttons/rounded_button.dart';
import 'package:xcash_app/view/components/buttons/rounded_loading_button.dart';
import 'package:xcash_app/view/components/text-form-field/label_text_field.dart';

import '../../../../../core/utils/my_icons.dart';
import '../../../../../core/utils/style.dart';
import '../../../../components/circle_icon_button.dart';
import '../../../../components/image/custom_svg_picture.dart';

class ReplySection extends StatelessWidget {
  const ReplySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketDetailsController>(
      builder: (controller) =>
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelTextField(
              controller: controller.replyController,
              maxLines: 5,
              contentPadding: const EdgeInsets.all(Dimensions.space10),
              isAttachment: true,
              labelText: MyStrings.message,
              hintText: "",
              inputAction: TextInputAction.done,
              onChanged: (value) {
                return;
              },
            ),
            const SizedBox(height: 20),
            controller.attachmentList.isNotEmpty ? const SizedBox(height: 20) : const SizedBox.shrink(),
            InkWell(
              onTap: () {
                controller.pickFile();
              },
              child: LabelTextField(
                readOnly: true,
                contentPadding: const EdgeInsets.all(Dimensions.space10),
                isAttachment: true,
                labelText: MyStrings.attachment.tr,
                hintText: MyStrings.chooseAFile.tr,
                inputAction: TextInputAction.done,
                onChanged: (value) {
                  return;
                },
                suffixIcon: InkWell(
                  onTap: () {
                    controller.pickFile();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                    margin: const EdgeInsets.all(Dimensions.space5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: MyColor.primaryColor,
                    ),
                    child: Text(
                      MyStrings.upload,
                      style: regularDefault.copyWith(color: MyColor.colorWhite),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Dimensions.space2),
            Text("${MyStrings.supportedFileType.tr} ${MyStrings.ext}", style: regularSmall.copyWith(color: MyColor.getGreyText())),
            const SizedBox(height: Dimensions.space20),
            controller.attachmentList.isNotEmpty
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      controller.attachmentList.length,
                          (index) => Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(Dimensions.space5),
                                decoration: const BoxDecoration(),
                                child: controller.isImage(controller.attachmentList[index].path)
                                    ? ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                    child: Image.file(
                                      controller.attachmentList[index],
                                      width: context.width / 5,
                                      height: context.width / 5,
                                      fit: BoxFit.cover,
                                    ))
                                    : controller.isDoc(controller.attachmentList[index].path)
                                    ? Container(
                                  width: context.width / 5,
                                  height: context.width / 5,
                                  decoration: BoxDecoration(
                                    color: MyColor.colorWhite,
                                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                    border: Border.all(color: MyColor.borderColor, width: 1),
                                  ),
                                  child: const Center(
                                    child: CustomSvgPicture(
                                      hasIconColor: false,
                                      image: MyIcons.doc,
                                      height: 45,
                                      width: 45,
                                    ),
                                  ),
                                )
                                    : Container(
                                  width: context.width / 5,
                                  height: context.width / 5,
                                  decoration: BoxDecoration(
                                    color: MyColor.colorWhite,
                                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                    border: Border.all(color: MyColor.borderColor, width: 1),
                                  ),
                                  child: const Center(
                                    child: CustomSvgPicture(
                                      hasIconColor: false,
                                      image: MyIcons.pdfFile,
                                      height: 45,
                                      width: 45,
                                    ),
                                  ),
                                ),
                              ),
                              CircleIconButton(
                                onTap: () {
                                  controller.removeAttachmentFromList(index);
                                },
                                height: Dimensions.space20,
                                width: Dimensions.space20,
                                backgroundColor: MyColor.colorRed,
                                child: const Icon(
                                  Icons.close,
                                  color: MyColor.colorWhite,
                                  size: Dimensions.space15,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  //
                ],
              ),
            )
                : const SizedBox(),
            const SizedBox(height: Dimensions.space30),
            controller.submitLoading
                ? const RoundedLoadingBtn()
                : RoundedButton(
              isOutlined: true,
              isColorChange: true,
              verticalPadding: Dimensions.space15,
              cornerRadius: Dimensions.space8,
              color: MyColor.primaryColor,
              text: MyStrings.reply.tr,
              press: () {
                controller.uploadTicketViewReply();
              },
            ),
            const SizedBox(height: Dimensions.space30),
          ],
        )
    );
  }
}
