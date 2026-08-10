
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/expense_model.dart';

class TransactionTile extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  const TransactionTile({super.key, required this.expense, this.onTap, this.onDelete});

  IconData _icon() {
    switch (expense.category) {
      case 'Food': return Icons.restaurant;
      case 'Transport': return Icons.directions_bike;
      case 'Shopping': return Icons.shopping_bag;
      case 'Bills': return Icons.receipt_long;
      case 'Health': return Icons.local_hospital;
      case 'Education': return Icons.school;
      default: return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = expense.type == 'expense';
    return Dismissible(
      key: Key(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), decoration: BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.delete, color: Colors.white)),
      onDismissed: (_) => onDelete?.call(),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)]),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: isExpense ? const Color(0xFFFEF2F2) : const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(12)), child: Icon(_icon(), color: isExpense ? Colors.red.shade400 : AppConstants.primaryEmerald, size: 20)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(expense.category, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: AppConstants.textDark)),
              Text(expense.note.isEmpty ? DateFormat('hh:mm a').format(expense.date) : expense.note, style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray), maxLines: 1, overflow: TextOverflow.ellipsis),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('${isExpense ? '-' : '+'} Rs ${expense.amount.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: isExpense ? AppConstants.textDark : AppConstants.primaryEmerald)),
              Text(DateFormat('dd MMM').format(expense.date), style: GoogleFonts.poppins(fontSize: 11, color: AppConstants.textGray)),
            ]),
          ]),
        ),
      ),
    );
  }
}
