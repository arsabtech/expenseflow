
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/providers/budget_provider.dart';
import '../../domain/providers/expense_provider.dart';
import '../../data/models/budget_model.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = context.watch<BudgetProvider>();
    final expenseProvider = context.watch<ExpenseProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('Budget', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Column(children: [Text('Monthly Budget', style: GoogleFonts.poppins(color: AppConstants.textGray)), const SizedBox(height: 8), Text('Rs 15000', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700)), const SizedBox(height: 12), LinearProgressIndicator(value: (expenseProvider.totalExpense / 15000).clamp(0, 1), backgroundColor: AppConstants.bgGray, color: expenseProvider.totalExpense > 12000 ? Colors.red : AppConstants.primaryEmerald, minHeight: 8, borderRadius: BorderRadius.circular(8)), const SizedBox(height: 8), Text(expenseProvider.totalExpense > 12000 ? '⚠️ Overspending Alert!' : 'On track', style: GoogleFonts.poppins(fontSize: 12, color: expenseProvider.totalExpense > 12000 ? Colors.red : AppConstants.primaryEmerald))])), 
          const SizedBox(height: 16),
          ...AppConstants.categories.map((cat) {
            final spent = expenseProvider.expenses.where((e) => e.category == cat && e.type == 'expense').fold(0.0, (s, e) => s + e.amount);
            final limit = 3000.0;
            final pct = (spent / limit).clamp(0, 1).toDouble();
            return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(cat, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), Text('Rs ${spent.toStringAsFixed(0)} / ${limit.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 12))]), const SizedBox(height: 8), LinearProgressIndicator(value: pct, backgroundColor: AppConstants.bgGray, color: pct > 0.8 ? Colors.red : AppConstants.primaryEmerald, minHeight: 6, borderRadius: BorderRadius.circular(4))]));
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { final id = DateTime.now().millisecondsSinceEpoch.toString(); context.read<BudgetProvider>().addBudget(BudgetModel(id: id, category: 'Food', limit: 3000)); }, backgroundColor: AppConstants.primaryEmerald, child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}
