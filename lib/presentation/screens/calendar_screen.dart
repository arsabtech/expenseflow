
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/providers/expense_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final daysInMonth = DateTime(selected.year, selected.month + 1, 0).day;
    final firstWeekday = DateTime(selected.year, selected.month, 1).weekday;

    return Scaffold(
      appBar: AppBar(title: Text('Calendar', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [IconButton(onPressed: () => setState(() => selected = DateTime(selected.year, selected.month - 1)), icon: const Icon(Icons.chevron_left)), Text('${selected.month}/${selected.year}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)), IconButton(onPressed: () => setState(() => selected = DateTime(selected.year, selected.month + 1)), icon: const Icon(Icons.chevron_right))])),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: GridView.builder(shrinkWrap: true, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7), itemCount: daysInMonth + firstWeekday - 1, itemBuilder: (c, i) {
          if (i < firstWeekday - 1) return const SizedBox();
          final day = i - firstWeekday + 2;
          final date = DateTime(selected.year, selected.month, day);
          final hasTx = provider.expenses.any((e) => e.date.year == date.year && e.date.month == date.month && e.date.day == day);
          final isSelected = date.day == DateTime.now().day && date.month == DateTime.now().month;
          return InkWell(onTap: () => setState(() => selected = date), child: Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: isSelected ? AppConstants.primaryEmerald : hasTx ? AppConstants.emeraldLight : Colors.white, borderRadius: BorderRadius.circular(12)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('$day', style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? Colors.white : AppConstants.textDark)), if (hasTx) Container(width: 4, height: 4, decoration: const BoxDecoration(color: AppConstants.primaryEmerald, shape: BoxShape.circle))]))));
        })),
        const Divider(),
        Expanded(child: ListView(padding: const EdgeInsets.all(16), children: provider.expenses.where((e) => e.date.year == selected.year && e.date.month == selected.month && e.date.day == selected.day).map((e) => ListTile(tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), title: Text(e.category, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), subtitle: Text(e.note), trailing: Text('Rs ${e.amount}', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)))).toList())),
      ]),
    );
  }
}
