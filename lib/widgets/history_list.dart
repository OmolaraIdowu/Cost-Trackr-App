import 'package:cost_trackr/model/expense.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final List<Expense> _expenses = [];

  @override
  Widget build(BuildContext context) {
    if (_expenses.isEmpty) {
      return Center(
        child: Text(
          'No expenses added yet.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: _expenses.length,
      itemBuilder: (ctx, index) => ListTile(
          title: Text(_expenses[index].name,
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {}),
    );
  }
}
