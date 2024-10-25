import 'package:cost_trackr/widgets/button_icon_bg.dart';
import 'package:cost_trackr/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransactionSummaryScreen extends StatelessWidget {
  const TransactionSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: theme.primaryColor,
        title: Text(
          'Transaction Summary',
          style: theme.textTheme.headlineMedium!
              .copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: theme.primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/edit.svg',
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {}),
                  const SizedBox(width: 20),
                  CustomIconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/share.svg',
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {}),
                  const SizedBox(width: 20),
                  CustomIconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/delete.svg',
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                        CustomDialog.show(
                          context: context,
                          title: 'Delete Transaction',
                          content:
                              'Are you sure you want to delete this transaction?',
                          confirmText: 'Delete',
                          onConfirm: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount',
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            'N 6000',
                            style: theme.textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction Type',
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            'Income',
                            style: theme.textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            'Food',
                            style: theme.textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Description',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 16),
                      Container(
                          padding: const EdgeInsets.all(16),
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: theme.shadowColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text('Bought doughnuts for Mom',
                              style: theme.textTheme.titleSmall!.copyWith(
                                color: theme.disabledColor,
                              )))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
