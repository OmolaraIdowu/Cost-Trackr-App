import 'package:cost_trackr/model/transaction.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final List<Transaction> _transaction = [];

  @override
  Widget build(BuildContext context) {
    if (_transaction.isEmpty) {
      return Center(
        child: Text(
          'No expenses added yet.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: _transaction.length,
      itemBuilder: (ctx, index) => ListTile(
          // leading: _transaction[index].category.icon,
          title: Text(_transaction[index].description,
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {}),
    );
  }
}
