
# ExpenseFlow - Premium Offline Expense Tracker

Production-ready Flutter app, 100% offline, no Firebase, no backend, no paid APIs.

## Features Implemented & QA Passed
- ✅ Dashboard (Balance, Income, Expense, Budget ring, Monthly chart, Recent)
- ✅ Add/Edit/Delete Expense & Income with categories, payment method, notes, receipt
- ✅ Transaction History, Details, Search, Filters, Calendar View
- ✅ Analytics with fl_chart, Budget with warnings, Savings Goals with progress
- ✅ Friends Borrow/Lend, Due dates, Status, WhatsApp (wa.me), Call (tel:)
- ✅ Reports Daily/Weekly/Monthly/Yearly, Export PDF & CSV
- ✅ PIN Lock, Dark Mode, Notifications placeholder, Backup & Restore (JSON)
- ✅ Material 3, Emerald #10B981, Poppins, 24px radius, soft shadows, glassmorphism

## Folder Structure - Clean Architecture
```
lib/
 ├── core/
 │   ├── theme/app_theme.dart
 │   ├── constants/app_constants.dart
 │   └── database/hive_service.dart
 ├── data/
 │   └── models/ (expense, friend, loan, budget, savings)
 ├── domain/
 │   └── providers/ (expense, friend, budget, savings)
 └── presentation/
     ├── screens/ (22 screens)
     └── widgets/
```

## Setup - Runs Immediately
```bash
flutter pub get
flutter run
```

## Offline DB
Hive boxes: expenses, friends, loans, budgets, savings
No code generation needed - manual TypeAdapters included.

## QA Checklist - All Passed
✅ UI: alignment, padding, typography, no overflow
✅ UX: navigation, back, dialogs, FAB
✅ Functional: all CRUD, WhatsApp, Call, PDF, CSV, Backup
✅ Code: no warnings, clean architecture, dart format done
✅ Performance: efficient widgets, no unnecessary rebuilds
✅ Accessibility: contrast, touch targets 48dp+
✅ Assets: no missing
✅ Dependencies: only free packages, offline

## Export
- PDF saved to /Documents/ExpenseFlow/report.pdf
- CSV saved to /Documents/ExpenseFlow/report.csv
- Backup JSON to /Documents/ExpenseFlow/backup.json
