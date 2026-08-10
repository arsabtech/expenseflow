
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(color: AppConstants.primaryEmerald, borderRadius: BorderRadius.circular(24)), child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 40)),
          const SizedBox(height: 16),
          Text('ExpenseFlow', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: AppConstants.textDark)),
          Text('Premium • Offline • Secure', style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray, letterSpacing: 1.2)),
          const SizedBox(height: 32),
          const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: AppConstants.primaryEmerald)),
        ]),
      ),
    );
  }
}
