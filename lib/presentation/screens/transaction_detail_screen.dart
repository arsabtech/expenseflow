
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/expense_model.dart';
import '../../core/constants/app_constants.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expense = ModalRoute.of(context)!.settings.arguments as ExpenseModel;
    return Scaffold(
      appBar: AppBar(title: Text('Details', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)), child: Column(children: [Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppConstants.emeraldLight, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.receipt, color: AppConstants.primaryEmerald, size: 32)), const SizedBox(height: 12), Text('Rs ${expense.amount.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700)), Text(expense.category, style: GoogleFonts.poppins(color: AppConstants.textGray)), const SizedBox(height: 20), _row('Date', expense.date.toString().substring(0, 16)), _row('Payment', expense.paymentMethod), _row('Type', expense.type), _row('Note', expense.note.isEmpty ? '-' : expense.note)])),
          const Spacer(),
          Row(children: [Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))), const SizedBox(width: 12), Expanded(child: FilledButton(onPressed: () {}, child: const Text('Edit')))]),
        ]),
      ),
    );
  }

  Widget _row(String k, String v) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(k, style: GoogleFonts.poppins(color: AppConstants.textGray, fontSize: 13)), Text(v, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13))]));
}
