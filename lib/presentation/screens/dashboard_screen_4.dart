
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/providers/expense_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_tile.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final recent = provider.expenses.take(5).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Hi, Future 👋', style: GoogleFonts.poppins(fontSize: 14, color: AppConstants.textGray, fontWeight: FontWeight.w400)),
          Text('Dashboard', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700)),
        ]),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/search'), icon: const Icon(Icons.search)),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/notifications'), icon: Badge(child: const Icon(Icons.notifications_outlined))),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          BalanceCard(balance: provider.balance, income: provider.totalIncome, expense: provider.totalExpense),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: _budgetCard(context, provider)),
            const SizedBox(width: 12),
            Expanded(child: _chartCard(provider)),
          ]),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Recent Transactions', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
            TextButton(onPressed: () => DefaultTabController.of(context)?.animateTo(1), child: Text('See All', style: GoogleFonts.poppins(color: AppConstants.primaryEmerald))),
          ]),
          if (recent.isEmpty)
            Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Center(child: Column(children: [const Icon(Icons.receipt_long, size: 40, color: Colors.grey), const SizedBox(height: 8), Text('No transactions yet', style: GoogleFonts.poppins(color: AppConstants.textGray)), const SizedBox(height: 12), FilledButton(onPressed: () => Navigator.pushNamed(context, '/add'), child: const Text('Add First Expense'))]))),
          ...recent.map((e) => TransactionTile(expense: e, onDelete: () => provider.delete(e.id))),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => Navigator.pushNamed(context, '/add'), backgroundColor: AppConstants.primaryEmerald, icon: const Icon(Icons.add, color: Colors.white), label: Text('Add', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600))),
    );
  }

  Widget _budgetCard(BuildContext context, ExpenseProvider provider) {
    final spent = provider.totalExpense;
    final limit = 15000.0;
    final percent = (spent / limit).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Budget', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 12),
        Stack(alignment: Alignment.center, children: [
          SizedBox(width: 70, height: 70, child: CircularProgressIndicator(value: percent, strokeWidth: 6, backgroundColor: AppConstants.bgGray, color: percent > 0.8 ? Colors.red : AppConstants.primaryEmerald)),
          Text('${(percent * 100).toInt()}%', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 8),
        Text('Rs ${spent.toStringAsFixed(0)} / ${limit.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 11, color: AppConstants.textGray)),
      ]),
    );
  }

  Widget _chartCard(ExpenseProvider provider) {
    final data = List.generate(7, (i) => provider.expenseList.where((e) => e.date.day == DateTime.now().subtract(Duration(days: 6 - i)).day).fold(0.0, (s, e) => s + e.amount));
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('This Week', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 12),
        SizedBox(height: 60, child: BarChart(BarChartData(borderData: FlBorderData(show: false), gridData: const FlGridData(show: false), titlesData: const FlTitlesData(show: false), barGroups: List.generate(7, (i) => BarChartGroupData(x: i, barRods: [BarChartRodData(toY: data[i] == 0 ? 2 : data[i] / 100, color: AppConstants.primaryEmerald, width: 6, borderRadius: BorderRadius.circular(4))]))))),
        const SizedBox(height: 4),
        Text('Avg Rs ${(data.isEmpty ? 0 : data.reduce((a, b) => a + b) / 7).toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 11, color: AppConstants.textGray)),
      ]),
    );
  }
}
