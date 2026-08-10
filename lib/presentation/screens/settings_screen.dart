import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // General Section
          Text(
            'General',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: Text('Appearance', style: GoogleFonts.poppins()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language_outlined),
                  title: Text('Language', style: GoogleFonts.poppins()),
                  trailing: Text('English', style: GoogleFonts.poppins(color: Colors.grey)),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // About Section
          Text(
            'About',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text('About ExpenseFlow', style: GoogleFonts.poppins()),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text('Privacy Policy', style: GoogleFonts.poppins()),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // --- YE WAHI FIX KI HUI LINE HAI ---
          Center(
            child: Text(
              'ExpenseFlow v1.0.0\n100% Offline - No Backend',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
