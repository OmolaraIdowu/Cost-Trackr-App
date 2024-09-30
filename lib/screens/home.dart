import 'package:cost_trackr/widgets/balance_card.dart';
import 'package:cost_trackr/widgets/header.dart';
import 'package:cost_trackr/widgets/history_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: 25),
            const BalanceCard(),
            const SizedBox(height: 32),
            Row(
              children: [
                Text(
                  'History',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16),
                ),
                const Spacer(),
                Text(
                  'See All',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 16),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                const SizedBox(height: 8),
              ],
            ),
            const Expanded(
              child: Center(
                child: HistoryList(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
