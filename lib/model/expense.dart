import 'package:cost_trackr/model/category.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final DateTime date;
  final String name;
  final Category category;
  final double amount;
}
