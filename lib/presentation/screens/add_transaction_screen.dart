
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/expense_model.dart';
import '../../domain/providers/expense_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String type = 'expense';
  String category = 'Food';
  String payment = 'Cash';
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void dispose() {
    amountCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(type == 'expense' ? 'Add Expense' : 'Add Income', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SegmentedButton<String>(
              segments: const [ButtonSegment(value: 'expense', label: Text('Expense'), icon: Icon(Icons.arrow_downward)), ButtonSegment(value: 'income', label: Text('Income'), icon: Icon(Icons.arrow_upward))],
              selected: {type},
              onSelectionChanged: (s) => setState(() => type = s.first),
            ),
            const SizedBox(height: 24),
            Text('Amount (Rs)', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextFormField(controller: amountCtrl, keyboardType: TextInputType.number, style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700), decoration: InputDecoration(hintText: '0', prefixText: 'Rs ', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)), validator: (v) => v == null || v.isEmpty ? 'Enter amount' : null),
            const SizedBox(height: 20),
            Text('Category', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: (type == 'expense' ? AppConstants.categories : AppConstants.incomeSources).map((c) => ChoiceChip(label: Text(c), selected: category == c, selectedColor: AppConstants.emeraldLight, onSelected: (_) => setState(() => category = c))).toList()),
            const SizedBox(height: 20),
            Text('Payment Method', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: AppConstants.paymentMethods.map((p) => ChoiceChip(label: Text(p), selected: payment == p, onSelected: (_) => setState(() => payment = p))).toList()),
            const SizedBox(height: 20),
            TextFormField(controller: noteCtrl, decoration: InputDecoration(labelText: 'Note', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none))),
            const SizedBox(height: 20),
            ListTile(leading: const Icon(Icons.calendar_today), title: Text('${date.day}/${date.month}/${date.year}', style: GoogleFonts.poppins()), trailing: const Icon(Icons.edit), onTap: () async { final d = await showDatePicker(context: context, firstDate: DateTime(2020), lastDate: DateTime(2030), initialDate: date); if (d != null) setState(() => date = d); }, tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            const SizedBox(height: 32),
            SizedBox(width: double.infinity, child: FilledButton(onPressed: _save, child: const Text('Save Transaction'))),
          ]),
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final model = ExpenseModel(id: DateTime.now().millisecondsSinceEpoch.toString(), amount: double.tryParse(amountCtrl.text) ?? 0, category: category, note: noteCtrl.text, date: date, paymentMethod: payment, type: type);
    context.read<ExpenseProvider>().add(model);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${type.capitalize()} added'), backgroundColor: AppConstants.primaryEmerald));
  }
}

extension on String { String capitalize() => isEmpty ? this : this[0].toUpperCase() + substring(1); }
