
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expense;
  const BalanceCard({super.key, required this.balance, required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(AppConstants.radius),
        boxShadow: [BoxShadow(color: AppConstants.primaryEmerald.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Total Balance', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.wallet, color: Colors.white, size: 20)),
          ]),
          const SizedBox(height: 8),
          Text('Rs ${balance.toStringAsFixed(0)}', style: GoogleFonts.poppins(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: _mini('Income', income, Icons.arrow_upward)),
            const SizedBox(width: 12),
            Expanded(child: _mini('Expense', expense, Icons.arrow_downward)),
          ]),
        ],
      ),
    );
  }

  Widget _mini(String label, double amt, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, size: 14, color: Colors.white)),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 11)),
          Text('Rs ${amt.toStringAsFixed(0)}', style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }
}
