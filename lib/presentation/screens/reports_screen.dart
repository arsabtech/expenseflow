
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/providers/expense_provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Reports', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [Expanded(child: _card('Daily', 'Rs ${provider.totalExpense.toStringAsFixed(0)}')), const SizedBox(width: 12), Expanded(child: _card('Monthly', 'Rs ${provider.totalExpense.toStringAsFixed(0)}'))]),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Column(children: [Row(children: [Expanded(child: FilledButton.icon(onPressed: () => _exportPdf(context, provider), icon: const Icon(Icons.picture_as_pdf), label: const Text('Export PDF'))), const SizedBox(width: 12), Expanded(child: FilledButton.icon(onPressed: () => _exportCsv(context, provider), icon: const Icon(Icons.table_chart), label: const Text('Export CSV'), style: FilledButton.styleFrom(backgroundColor: AppConstants.textDark)))]), const SizedBox(height: 12), Text('Exports saved to Documents/ExpenseFlow/', style: GoogleFonts.poppins(fontSize: 11, color: AppConstants.textGray))])),
        ]),
      ),
    );
  }

  Widget _card(String title, String value) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.poppins(color: AppConstants.textGray, fontSize: 12)), const SizedBox(height: 4), Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w700))]));

  Future<void> _exportPdf(BuildContext context, ExpenseProvider provider) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(pw.Page(build: (c) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [pw.Text('Expense Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)), pw.SizedBox(height: 20), ...provider.expenses.map((e) => pw.Text('${e.date.toString().substring(0, 10)} - ${e.category} - Rs ${e.amount} - ${e.note}'))])));
      final dir = await getApplicationDocumentsDirectory();
      final folder = Directory('${dir.path}/ExpenseFlow')..createSync(recursive: true);
      final file = File('${folder.path}/report.pdf');
      await file.writeAsBytes(await pdf.save());
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF saved to ${file.path}'), backgroundColor: AppConstants.primaryEmerald));
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _exportCsv(BuildContext context, ExpenseProvider provider) async {
    try {
      final rows = [['Date', 'Category', 'Amount', 'Type', 'Note'], ...provider.expenses.map((e) => [e.date.toString(), e.category, e.amount.toString(), e.type, e.note])];
      final csv = const ListToCsvConverter().convert(rows);
      final dir = await getApplicationDocumentsDirectory();
      final folder = Directory('${dir.path}/ExpenseFlow')..createSync(recursive: true);
      final file = File('${folder.path}/report.csv');
      await file.writeAsString(csv);
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CSV saved to ${file.path}'), backgroundColor: AppConstants.primaryEmerald));
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
