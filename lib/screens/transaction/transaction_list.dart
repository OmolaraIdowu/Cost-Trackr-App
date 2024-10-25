import 'package:cost_trackr/screens/transaction/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final List<TransactionItem> _transactionItems = [];
  final _isLoading = true;
  String? _error;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No transactions added yet',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    // if(_transactionItems.isEmpty) {
    //   content = ListView.builder(
    //     itemCount: _transactionItems.length,
    //     itemBuilder: (ctx, index) => TransactionItem(transaction))
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
      ),
      body: const SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}
