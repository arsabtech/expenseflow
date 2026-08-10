
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/providers/budget_provider.dart';
import '../../data/models/savings_model.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BudgetProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Savings Goals', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))),
      body: provider.savings.isEmpty
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('🎯', style: TextStyle(fontSize: 48)), const SizedBox(height: 12), Text('No goals yet', style: GoogleFonts.poppins(color: AppConstants.textGray)), const SizedBox(height: 12), FilledButton(onPressed: () => _addGoal(context), child: const Text('Create Goal'))]))
          : ListView.builder(padding: const EdgeInsets.all(16), itemCount: provider.savings.length, itemBuilder: (c, i) {
              final s = provider.savings[i];
              final pct = (s.saved / s.target).clamp(0, 1).toDouble();
              return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(s.icon, style: const TextStyle(fontSize: 24)), const SizedBox(width: 8), Expanded(child: Text(s.title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600))), Text('${(pct * 100).toInt()}%', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: AppConstants.primaryEmerald))]), const SizedBox(height: 12), LinearProgressIndicator(value: pct, backgroundColor: AppConstants.bgGray, color: AppConstants.primaryEmerald, minHeight: 8, borderRadius: BorderRadius.circular(8)), const SizedBox(height: 8), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Rs ${s.saved.toStringAsFixed(0)} saved', style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray)), Text('Target Rs ${s.target.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 12))])]));
            }),
      floatingActionButton: FloatingActionButton(onPressed: () => _addGoal(context), backgroundColor: AppConstants.primaryEmerald, child: const Icon(Icons.add, color: Colors.white)),
    );
  }

  void _addGoal(BuildContext context) {
    final titleCtrl = TextEditingController();
    final targetCtrl = TextEditingController();
    showDialog(context: context, builder: (c) => AlertDialog(title: const Text('New Goal'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')), TextField(controller: targetCtrl, decoration: const InputDecoration(labelText: 'Target Rs'), keyboardType: TextInputType.number)]), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')), FilledButton(onPressed: () { final id = DateTime.now().millisecondsSinceEpoch.toString(); context.read<BudgetProvider>().addSaving(SavingsModel(id: id, title: titleCtrl.text, target: double.tryParse(targetCtrl.text) ?? 1000)); Navigator.pop(c); }, child: const Text('Create'))]));
  }
}
