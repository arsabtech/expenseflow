
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../domain/providers/expense_provider.dart';
import '../widgets/transaction_tile.dart';
import '../../core/constants/app_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ctrl = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final results = provider.search(query);
    return Scaffold(
      appBar: AppBar(title: TextField(controller: ctrl, autofocus: true, decoration: InputDecoration(hintText: 'Search transactions, notes...', border: InputBorder.none, hintStyle: GoogleFonts.poppins(color: AppConstants.textGray)), style: GoogleFonts.poppins(), onChanged: (v) => setState(() => query = v))),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: results.length, itemBuilder: (c, i) => TransactionTile(expense: results[i])),
    );
  }
}
