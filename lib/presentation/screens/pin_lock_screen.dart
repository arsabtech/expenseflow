
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key});
  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  String pin = '';

  void _add(String d) {
    if (pin.length < 4) setState(() => pin += d);
    if (pin.length == 4) { Future.delayed(const Duration(milliseconds: 300), () => Navigator.pushReplacementNamed(context, '/home')); }
  }

  void _del() => setState(() => pin = pin.isEmpty ? '' : pin.substring(0, pin.length - 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.lock_rounded, size: 48, color: AppConstants.primaryEmerald),
        const SizedBox(height: 16),
        Text('Enter PIN', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(4, (i) => Container(margin: const EdgeInsets.all(8), width: 16, height: 16, decoration: BoxDecoration(shape: BoxShape.circle, color: i < pin.length ? AppConstants.primaryEmerald : Colors.grey.shade300)))),
        const SizedBox(height: 40),
        GridView.builder(shrinkWrap: true, padding: const EdgeInsets.symmetric(horizontal: 60), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: 12, itemBuilder: (c, i) {
          if (i == 9) return const SizedBox();
          if (i == 10) return _btn('0');
          if (i == 11) return IconButton(onPressed: _del, icon: const Icon(Icons.backspace_outlined));
          return _btn('${i + 1}');
        }),
        const SizedBox(height: 24),
        TextButton.icon(onPressed: () {}, icon: const Icon(Icons.fingerprint, color: AppConstants.primaryEmerald), label: Text('Use Fingerprint', style: GoogleFonts.poppins(color: AppConstants.primaryEmerald))),
      ])),
    );
  }

  Widget _btn(String d) => InkWell(onTap: () => _add(d), borderRadius: BorderRadius.circular(40), child: Container(decoration: BoxDecoration(color: AppConstants.bgGray, shape: BoxShape.circle), child: Center(child: Text(d, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600))))); 
}
