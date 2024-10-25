import 'package:cost_trackr/data/dummy_data.dart';
import 'package:cost_trackr/screens/transaction/add_transaction.dart';
import 'package:cost_trackr/screens/transaction/transaction_item.dart';
import 'package:cost_trackr/screens/transaction/transaction_list.dart';
import 'package:cost_trackr/widgets/balance_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 24, right: 24, top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, ', style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Keep track of your expenses today',
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: theme.primaryColor),
                    ),
                    const Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const BalanceCard(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: theme.textTheme.titleMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const TransactionListScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'See All ᐳ',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: const Color(0xFF005CE7)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: transactionsData.length,
                  itemBuilder: (ctx, index) {
                    return TransactionItem(transactionsData[index]);
                  }),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
