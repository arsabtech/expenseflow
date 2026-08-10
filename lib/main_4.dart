
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/database/hive_service.dart';
import 'domain/providers/expense_provider.dart';
import 'domain/providers/friend_provider.dart';
import 'domain/providers/budget_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/transactions_screen.dart';
import 'presentation/screens/add_transaction_screen.dart';
import 'presentation/screens/friends_screen.dart';
import 'presentation/screens/analytics_screen.dart';
import 'presentation/screens/budget_screen.dart';
import 'presentation/screens/savings_screen.dart';
import 'presentation/screens/reports_screen.dart';
import 'presentation/screens/calendar_screen.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/search_screen.dart';
import 'presentation/screens/notifications_screen.dart';
import 'presentation/screens/pin_lock_screen.dart';
import 'presentation/screens/transaction_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const ExpenseFlowApp());
}

class ExpenseFlowApp extends StatefulWidget {
  const ExpenseFlowApp({super.key});
  @override
  State<ExpenseFlowApp> createState() => _ExpenseFlowAppState();
}

class _ExpenseFlowAppState extends State<ExpenseFlowApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => setState(() => _showSplash = false));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()..load()),
        ChangeNotifierProvider(create: (_) => FriendProvider()..load()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()..load()),
      ],
      child: MaterialApp(
        title: 'ExpenseFlow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: _showSplash ? const SplashScreen() : const MainNav(),
        routes: {
          '/home': (_) => const MainNav(),
          '/add': (_) => const AddTransactionScreen(),
          '/search': (_) => const SearchScreen(),
          '/notifications': (_) => const NotificationsScreen(),
          '/calendar': (_) => const CalendarScreen(),
          '/reports': (_) => const ReportsScreen(),
          '/settings': (_) => const SettingsScreen(),
          '/detail': (_) => const TransactionDetailScreen(),
          '/pin': (_) => const PinLockScreen(),
          '/onboarding': (_) => const OnboardingScreen(),
        },
      ),
    );
  }
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;
  final _screens = const [
    DashboardScreen(),
    TransactionsScreen(),
    FriendsScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 4))]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF10B981),
            unselectedItemColor: const Color(0xFF64748B),
            showUnselectedLabels: false,
            showSelectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Tx'),
              BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Friends'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Analytics'),
              BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
