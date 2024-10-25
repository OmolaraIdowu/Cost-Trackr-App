import 'package:cost_trackr/data/dummy_data.dart';
import 'package:cost_trackr/screens/s/pie_chart.dart';
import 'package:cost_trackr/screens/transaction/expense.dart';
import 'package:cost_trackr/screens/transaction/income.dart';
import 'package:cost_trackr/screens/transaction/transaction_item.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(text: 'Incomes'),
                Tab(text: 'Expenses'),
              ],
              indicatorColor: theme.primaryColor,
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.unselectedWidgetColor,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Incomes
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      children: [
                        // Placeholder for Income PieChart
                        const PieChartItem(),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Incomes', style: theme.textTheme.titleMedium),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const IncomeScreen(),
                                  ),
                                );
                              },
                              child: Text('See All ᐳ',
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      color: const Color(0xFF005CE7))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: transactionsData.length,
                            itemBuilder: (ctx, index) {
                              return TransactionItem(transactionsData[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tab 2: Expenses
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      children: [
                        // Placeholder for Expense PieChart
                        const PieChartItem(),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Expenses',
                                style: theme.textTheme.titleMedium),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const ExpensesScreen(),
                                  ),
                                );
                              },
                              child: Text('See All ᐳ',
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      color: const Color(0xFF005CE7))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: transactionsData.length,
                            itemBuilder: (ctx, index) {
                              return TransactionItem(transactionsData[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
