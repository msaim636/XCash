import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/core/utils/style.dart';
import 'package:xcash_app/view/components/badges/status_badge.dart';
import 'package:xcash_app/view/components/column_widget/card_column.dart';

import '../../../../../data/controller/support/ticket_details_controller.dart';

class TicketStatusWidget extends StatelessWidget {
  final TicketDetailsController controller;

  const TicketStatusWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom:Dimensions.space15),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: MyColor.getCardBgColor(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CardColumn(
                    isOnlyHeader: false,
                    header:
                        "[${MyStrings.ticket.tr}#${controller.model.data?.myTickets?.ticket ?? ''}]",
                    body: controller.model.data?.myTickets?.subject ?? '',
                    bodyMaxLine: 3,
                    space: 7,
                    headerTextStyle:
                        semiBoldDefault.copyWith(color: MyColor.getTextColor()),
                    bodyTextStyle: regularDefault.copyWith(
                        color: MyColor.getTextColor().withOpacity(.9)),
                  ),
                ),
                const SizedBox(width: 25),
                StatusBadge(
                  text: controller.getStatusText(controller.model.data?.myTickets?.status ?? '0',isPriority: true),
                  color: controller.getStatusColor(controller.model.data?.myTickets?.status ?? "0",isPriority: true)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
