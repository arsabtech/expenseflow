
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)), child: Column(children: [CircleAvatar(radius: 40, backgroundColor: AppConstants.emeraldLight, child: Text('FA', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppConstants.primaryEmerald))), const SizedBox(height: 12), Text('Future with Ak', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700)), Text('futurewithak • Member since 2024', style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray)), const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_stat('Transactions', '128'), _stat('Saved', 'Rs 45k'), _stat('Goals', '3/5')])])),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Achievements', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), const SizedBox(height: 12), Row(children: [ _badge('🔥', 'Streak'), _badge('💰', 'Saver'), _badge('📊', 'Analyst'), _badge('🤝', 'Helper')])])),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: () => Navigator.pushNamed(context, '/settings'), icon: const Icon(Icons.settings), label: const Text('Settings & Backup')),
        ]),
      ),
    );
  }

  Widget _stat(String label, String value) => Column(children: [Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w700)), Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppConstants.textGray))]);
  Widget _badge(String emoji, String label) => Expanded(child: Column(children: [Text(emoji, style: const TextStyle(fontSize: 28)), const SizedBox(height: 4), Text(label, style: GoogleFonts.poppins(fontSize: 11))]));
}
