
import 'package:flutter/material.dart';
import '../../core/database/hive_service.dart';
import '../../data/models/friend_model.dart';
import '../../data/models/loan_model.dart';

class FriendProvider extends ChangeNotifier {
  List<FriendModel> _friends = [];
  List<LoanModel> _loans = [];

  List<FriendModel> get friends => _friends;
  List<LoanModel> get loans => _loans;

  void load() {
    _friends = HiveService.friendBox.values.toList();
    _loans = HiveService.loanBox.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> addFriend(FriendModel f) async {
    await HiveService.friendBox.put(f.id, f);
    load();
  }

  Future<void> addLoan(LoanModel loan) async {
    await HiveService.loanBox.put(loan.id, loan);
    final friend = HiveService.friendBox.get(loan.friendId);
    if (friend != null) {
      if (loan.type == 'lent') {
        friend.totalLent += loan.amount;
      } else {
        friend.totalBorrowed += loan.amount;
      }
      await friend.save();
    }
    load();
  }

  Future<void> markPaid(String loanId) async {
    final loan = HiveService.loanBox.get(loanId);
    if (loan != null) {
      loan.status = 'paid';
      await loan.save();
      load();
    }
  }

  List<LoanModel> loansForFriend(String friendId) => _loans.where((l) => l.friendId == friendId).toList();
  double pendingLent() => _loans.where((l) => l.type == 'lent' && l.status == 'pending').fold(0, (s, l) => s + l.amount);
  double pendingBorrowed() => _loans.where((l) => l.type == 'borrowed' && l.status == 'pending').fold(0, (s, l) => s + l.amount);
}
