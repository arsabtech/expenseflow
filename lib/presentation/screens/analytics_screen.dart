
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/providers/expense_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final categories = AppConstants.categories;
    final Map<String, double> catTotals = {for (var c in categories) c: 0};
    for (var e in provider.expenseList) { catTotals[e.category] = (catTotals[e.category] ?? 0) + e.amount; }

    return Scaffold(
      appBar: AppBar(title: Text('Analytics', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Spending by Category', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), const SizedBox(height: 20), SizedBox(height: 180, child: PieChart(PieChartData(sectionsSpace: 2, centerSpaceRadius: 50, sections: catTotals.entries.where((e) => e.value > 0).map((e) => PieChartSectionData(value: e.value, title: e.key.substring(0, 3), radius: 40, color: _colorFor(e.key))).toList()))), const SizedBox(height: 16), ...catTotals.entries.where((e) => e.value > 0).map((e) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: _colorFor(e.key), shape: BoxShape.circle)), const SizedBox(width: 8), Expanded(child: Text(e.key, style: GoogleFonts.poppins(fontSize: 13))), Text('Rs ${e.value.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13))])))])),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Monthly Trend', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), const SizedBox(height: 20), SizedBox(height: 120, child: BarChart(BarChartData(borderData: FlBorderData(show: false), gridData: const FlGridData(show: false), titlesData: const FlTitlesData(show: false), barGroups: List.generate(6, (i) => BarChartGroupData(x: i, barRods: [BarChartRodData(toY: (i + 1) * 20, color: AppConstants.primaryEmerald, width: 16, borderRadius: BorderRadius.circular(6))])))))])),
        ]),
      ),
    );
  }

  Color _colorFor(String cat) {
    final map = {'Food': Colors.orange, 'Transport': Colors.blue, 'Shopping': Colors.purple, 'Bills': Colors.red, 'Health': Colors.green, 'Education': Colors.teal, 'Entertainment': Colors.pink, 'Other': Colors.grey};
    return map[cat] ?? Colors.grey;
  }
}
