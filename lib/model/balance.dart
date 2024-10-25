import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Balance {
  Balance({
    required this.currentBalance,
    required this.periodStart,
    required this.periodEnd,
    required this.income,
    required this.expense,
  }) : id = uuid.v4();

  final String id;
  final double currentBalance;
  final double periodStart;
  final double periodEnd;
  final double income;
  final double expense;
}
