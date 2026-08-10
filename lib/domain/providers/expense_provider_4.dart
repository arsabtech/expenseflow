
import 'package:flutter/material.dart';
import '../../core/database/hive_service.dart';
import '../../data/models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> _expenses = [];

  List<ExpenseModel> get expenses => _expenses;
  List<ExpenseModel> get expenseList => _expenses.where((e) => e.type == 'expense').toList();
  List<ExpenseModel> get incomeList => _expenses.where((e) => e.type == 'income').toList();

  double get totalExpense => expenseList.fold(0, (s, e) => s + e.amount);
  double get totalIncome => incomeList.fold(0, (s, e) => s + e.amount);
  double get balance => totalIncome - totalExpense;

  double monthlyExpense(DateTime month) {
    return _expenses.where((e) => e.type == 'expense' && e.date.month == month.month && e.date.year == month.year).fold(0, (s, e) => s + e.amount);
  }

  void load() {
    _expenses = HiveService.expenseBox.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> add(ExpenseModel model) async {
    await HiveService.expenseBox.put(model.id, model);
    load();
  }

  Future<void> update(ExpenseModel model) async {
    await model.save();
    load();
  }

  Future<void> delete(String id) async {
    await HiveService.expenseBox.delete(id);
    load();
  }

  List<ExpenseModel> search(String query) {
    if (query.isEmpty) return _expenses;
    return _expenses.where((e) => e.category.toLowerCase().contains(query.toLowerCase()) || e.note.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
