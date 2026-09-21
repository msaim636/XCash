import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/data/controller/withdraw/edit_withdraw_method_controller.dart';
import 'package:xcash_app/data/model/withdraw/edit_withdraw_method_response_model.dart';
import 'package:xcash_app/view/screens/withdrawals/withdraw_method/widget/choose_file_list_item.dart';

class EditWithdrawFileItem extends StatefulWidget {
  final int index;

  const EditWithdrawFileItem({super.key, required this.index});

  @override
  State<EditWithdrawFileItem> createState() => _EditWithdrawFileItemState();
}

class _EditWithdrawFileItemState extends State<EditWithdrawFileItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditWithdrawMethodController>(builder: (controller) {
      FormModel? model = controller.formList[widget.index];
      return InkWell(
          onTap: () {
            controller.pickFile(widget.index);
          },
          child: ChooseFileItem(fileName: model.selectedValue ?? MyStrings.chooseFile));
    });
  }
}
