
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/expense_model.dart';
import '../../data/models/friend_model.dart';
import '../../data/models/loan_model.dart';
import '../../data/models/budget_model.dart';
import '../../data/models/savings_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseModelAdapter());
    Hive.registerAdapter(FriendModelAdapter());
    Hive.registerAdapter(LoanModelAdapter());
    Hive.registerAdapter(BudgetModelAdapter());
    Hive.registerAdapter(SavingsModelAdapter());

    await Hive.openBox<ExpenseModel>('expenses');
    await Hive.openBox<FriendModel>('friends');
    await Hive.openBox<LoanModel>('loans');
    await Hive.openBox<BudgetModel>('budgets');
    await Hive.openBox<SavingsModel>('savings');
  }

  static Box<ExpenseModel> get expenseBox => Hive.box<ExpenseModel>('expenses');
  static Box<FriendModel> get friendBox => Hive.box<FriendModel>('friends');
  static Box<LoanModel> get loanBox => Hive.box<LoanModel>('loans');
  static Box<BudgetModel> get budgetBox => Hive.box<BudgetModel>('budgets');
  static Box<SavingsModel> get savingsBox => Hive.box<SavingsModel>('savings');
}
