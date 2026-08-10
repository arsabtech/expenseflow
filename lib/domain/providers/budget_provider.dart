
import 'package:flutter/material.dart';
import '../../core/database/hive_service.dart';
import '../../data/models/budget_model.dart';
import '../../data/models/savings_model.dart';

class BudgetProvider extends ChangeNotifier {
  List<BudgetModel> _budgets = [];
  List<SavingsModel> _savings = [];

  List<BudgetModel> get budgets => _budgets;
  List<SavingsModel> get savings => _savings;

  void load() {
    _budgets = HiveService.budgetBox.values.toList();
    _savings = HiveService.savingsBox.values.toList();
    notifyListeners();
  }

  Future<void> addBudget(BudgetModel b) async {
    await HiveService.budgetBox.put(b.id, b);
    load();
  }

  Future<void> addSaving(SavingsModel s) async {
    await HiveService.savingsBox.put(s.id, s);
    load();
  }

  Future<void> updateSaving(String id, double amount) async {
    final s = HiveService.savingsBox.get(id);
    if (s != null) {
      s.saved += amount;
      await s.save();
      load();
    }
  }
}
