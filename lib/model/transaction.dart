import 'package:cost_trackr/model/category.dart';
import 'package:cost_trackr/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

class Transaction {
  Transaction({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
    this.currency = Currency.usd,
    required this.transactionType,
  }) : id = uuid.v4();

  final String id;
  final DateTime date;
  final String description;
  final Category category;
  final double amount;
  final Currency? currency;
  final TransactionType transactionType;

  get formattedDate {
    return formatter.format(date);
  }
}
