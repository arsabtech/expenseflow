
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool pinEnabled = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() { darkMode = prefs.getBool('darkMode') ?? false; pinEnabled = prefs.getBool('pinEnabled') ?? false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _section('General'),
        _tile('Dark Mode', 'Switch to dark theme', Icons.dark_mode, Switch(value: darkMode, activeColor: AppConstants.primaryEmerald, onChanged: (v) async { setState(() => darkMode = v); final p = await SharedPreferences.getInstance(); await p.setBool('darkMode', v); })),
        _tile('Currency', 'PKR - Pakistani Rupee', Icons.currency_rupee, const Icon(Icons.chevron_right)),
        _section('Security'),
        _tile('PIN Lock', 'Secure app with PIN', Icons.lock, Switch(value: pinEnabled, activeColor: AppConstants.primaryEmerald, onChanged: (v) async { setState(() => pinEnabled = v); final p = await SharedPreferences.getInstance(); await p.setBool('pinEnabled', v); })),
        _tile('Backup & Restore', 'Local backup', Icons.backup, const Icon(Icons.chevron_right), onTap: () => _backup()),
        _section('Data'),
        _tile('Export Data', 'PDF & CSV export', Icons.file_download, const Icon(Icons.chevron_right), onTap: () => Navigator.pushNamed(context, '/reports')),
        _tile('Clear Data', 'Delete all transactions', Icons.delete_forever, const Icon(Icons.chevron_right, color: Colors.red), onTap: () => _clearDialog()),
        const SizedBox(height: 24),
        Center(child: Text('ExpenseFlow v1.0.0
100% Offline • No Backend', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray))),
      ]),
    );
  }

  Widget _section(String t) => Padding(padding: const EdgeInsets.only(top: 16, bottom: 8), child: Text(t, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppConstants.primaryEmerald, fontSize: 13)));
  Widget _tile(String title, String subtitle, IconData icon, Widget trailing, {VoidCallback? onTap}) => Container(margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: ListTile(leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppConstants.bgGray, borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 20)), title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14)), subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: AppConstants.textGray)), trailing: trailing, onTap: onTap));

  Future<void> _backup() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/ExpenseFlow/backup.json');
    if (await file.exists()) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Backup found at ${file.path}'), backgroundColor: AppConstants.primaryEmerald)); } else { if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No backup yet. Export reports to create files.'))); }
  }

  void _clearDialog() {
    showDialog(context: context, builder: (c) => AlertDialog(title: const Text('Clear All Data?'), content: const Text('This cannot be undone.'), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')), FilledButton(onPressed: () { Navigator.pop(c); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Use Hive boxes clear in code for production clear.'))); }, style: FilledButton.styleFrom(backgroundColor: Colors.red), child: const Text('Clear'))]));
  }
}
