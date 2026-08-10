
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/providers/friend_provider.dart';
import '../../data/models/friend_model.dart';
import '../../data/models/loan_model.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});
  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FriendProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        bottom: TabBar(controller: _tab, labelColor: AppConstants.primaryEmerald, unselectedLabelColor: AppConstants.textGray, indicatorColor: AppConstants.primaryEmerald, tabs: const [Tab(text: 'Lent'), Tab(text: 'Borrowed')]),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(child: _stat('Lent Pending', provider.pendingLent(), Colors.orange)),
            const SizedBox(width: 12),
            Expanded(child: _stat('Borrowed Pending', provider.pendingBorrowed(), Colors.red)),
          ]),
        ),
        Expanded(
          child: provider.friends.isEmpty
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.people_outline, size: 48, color: Colors.grey), const SizedBox(height: 8), Text('No friends yet', style: GoogleFonts.poppins(color: AppConstants.textGray)), const SizedBox(height: 12), FilledButton(onPressed: () => _addFriendDialog(), child: const Text('Add Friend'))]))
              : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: provider.friends.length, itemBuilder: (c, i) {
                  final f = provider.friends[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)]),
                    child: Row(children: [
                      CircleAvatar(backgroundColor: AppConstants.emeraldLight, child: Text(f.name[0].toUpperCase(), style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: AppConstants.primaryEmerald))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(f.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), Text(f.phone, style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray))])),
                      Column(children: [
                        IconButton(onPressed: () => _whatsApp(f), icon: const Icon(Icons.chat, color: Colors.green)),
                        IconButton(onPressed: () => _call(f), icon: const Icon(Icons.call, color: AppConstants.primaryEmerald)),
                      ]),
                    ]),
                  );
                }),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: _addFriendDialog, backgroundColor: AppConstants.primaryEmerald, child: const Icon(Icons.person_add, color: Colors.white)),
    );
  }

  Widget _stat(String label, double amt, Color color) {
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppConstants.textGray)), const SizedBox(height: 4), Text('Rs ${amt.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: color))]));
  }

  void _addFriendDialog() {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    showDialog(context: context, builder: (c) => AlertDialog(title: Text('Add Friend', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')), TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone +92...'), keyboardType: TextInputType.phone)]), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')), FilledButton(onPressed: () { if (nameCtrl.text.isNotEmpty) { final f = FriendModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: nameCtrl.text, phone: phoneCtrl.text); context.read<FriendProvider>().addFriend(f); Navigator.pop(c); } }, child: const Text('Add'))]));
  }

  void _whatsApp(FriendModel f) async {
    final uri = Uri.parse('https://wa.me/${f.phone.replaceAll('+', '')}?text=Salam ${f.name}! Hisab yaad dila raha tha.');
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _call(FriendModel f) async {
    final uri = Uri.parse('tel:${f.phone}');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
