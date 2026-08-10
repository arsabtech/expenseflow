
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<Map<String, String>> _pages = [
    {'title': 'Track Every Rupee', 'desc': 'Clean, minimal tracking with categories, receipts and payment methods. 100% offline.', 'emoji': '💸'},
    {'title': 'Smart Analytics', 'desc': 'Beautiful charts, budget warnings, savings goals and reports. Export PDF & CSV.', 'emoji': '📊'},
    {'title': 'Friends & Borrow', 'desc': 'Lent or borrowed? Track with due dates, WhatsApp reminder and call directly.', 'emoji': '🤝'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (i) => setState(() => _index = i),
              itemCount: _pages.length,
              itemBuilder: (c, i) {
                final p = _pages[i];
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(p['emoji']!, style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 32),
                    Text(p['title']!, style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    Text(p['desc']!, style: GoogleFonts.poppins(fontSize: 15, color: AppConstants.textGray), textAlign: TextAlign.center),
                  ]),
                );
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(3, (i) => Container(margin: const EdgeInsets.all(4), width: _index == i ? 24 : 8, height: 8, decoration: BoxDecoration(color: _index == i ? AppConstants.primaryEmerald : Colors.grey.shade300, borderRadius: BorderRadius.circular(4))))),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(children: [
              TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/home'), child: Text('Skip', style: GoogleFonts.poppins(color: AppConstants.textGray))),
              const Spacer(),
              FilledButton(onPressed: () {
                if (_index < 2) {_controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);} else {Navigator.pushReplacementNamed(context, '/home');}
              }, child: Text(_index == 2 ? 'Get Started' : 'Next')),
            ]),
          ),
        ]),
      ),
    );
  }
}
