
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../domain/providers/expense_provider.dart';
import '../widgets/transaction_tile.dart';
import '../../core/constants/app_constants.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final list = filter == 'All' ? provider.expenses : provider.expenses.where((e) => e.type == filter.toLowerCase()).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Transactions', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), actions: [IconButton(onPressed: () => Navigator.pushNamed(context, '/calendar'), icon: const Icon(Icons.calendar_month))]),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: ['All', 'Expense', 'Income'].map((f) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(f), selected: filter == f, selectedColor: AppConstants.emeraldLight, onSelected: (_) => setState(() => filter = f)))).toList()),
        ),
        Expanded(
          child: list.isEmpty
              ? Center(child: Text('No transactions', style: GoogleFonts.poppins(color: AppConstants.textGray)))
              : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: list.length, itemBuilder: (c, i) => TransactionTile(expense: list[i], onDelete: () => provider.delete(list[i].id), onTap: () => Navigator.pushNamed(context, '/detail', arguments: list[i]))),
        ),
      ]),
    );
  }
}
