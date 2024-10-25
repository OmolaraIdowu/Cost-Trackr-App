import 'package:cost_trackr/screens/transaction/add_transaction.dart';
import 'package:cost_trackr/screens/transaction/transaction_summary.dart';
import 'package:cost_trackr/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(this.transaction, {super.key});

  final Map<String, dynamic> transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const TransactionSummaryScreen(),
            ),
          );
        },
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: ((context) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const AddTransactionScreen()));
                }),
                backgroundColor: Colors.green,
                icon: Icons.edit_outlined,
              ),
              SlidableAction(
                onPressed: ((context) {
                  CustomDialog.show(
                      context: context,
                      title: 'Delete Transaction',
                      content:
                          'Are you sure you want to delete this transaction?',
                      confirmText: 'Delete',
                      onConfirm: () {
                        Navigator.of(context).pop();
                      });
                }),
                backgroundColor: Colors.red,
                icon: Icons.delete_outline_rounded,
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: theme.shadowColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/travel.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              theme.primaryColorDark,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transaction['name'],
                              style: theme.textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(transaction['date'],
                              style: theme.textTheme.titleSmall!
                                  .copyWith(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  Text(transaction['totalAmount'],
                      style: theme.textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
