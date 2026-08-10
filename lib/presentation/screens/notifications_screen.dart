
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Budget Warning', 'desc': 'Food budget 80% used', 'time': '2h ago', 'icon': Icons.warning_amber},
      {'title': 'Friend Due', 'desc': 'Bilal - Rs 1500 due tomorrow', 'time': '5h ago', 'icon': Icons.people},
      {'title': 'Goal Reached!', 'desc': 'Bike savings 100% completed 🎉', 'time': '1d ago', 'icon': Icons.emoji_events},
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Notifications', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)), actions: [TextButton(onPressed: () {}, child: Text('Mark all read', style: GoogleFonts.poppins(color: AppConstants.primaryEmerald)))]),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: items.length, itemBuilder: (c, i) {
        final it = items[i];
        return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppConstants.emeraldLight, borderRadius: BorderRadius.circular(12)), child: Icon(it['icon'] as IconData, color: AppConstants.primaryEmerald)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(it['title'] as String, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)), Text(it['desc'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray))])), Text(it['time'] as String, style: GoogleFonts.poppins(fontSize: 11, color: AppConstants.textGray))]));
      }),
    );
  }
}
