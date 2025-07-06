// Importing material package and the account model
import 'package:flutter/material.dart';
import '../models/account_model.dart';

//  managing the user's accounts and their balances
class AccountProvider extends ChangeNotifier {
  // Private list of accounts the user owns
  final List<AccountModel> _accounts = [
    AccountModel(id: '1', name: 'Savings Account', balance: 5000.00),
    AccountModel(id: '2', name: 'Current Account', balance: 2500.00),
    AccountModel(id: '3', name: 'Student Account', balance: 1000.00),
  ];

  // The ID of the account currently selected by the user
  String _selectedAccountId = '1'; // Default: Savings Account

  // Public getter to access all accounts
  List<AccountModel> get accounts => _accounts;

  // Returns the account that is currently selected
  AccountModel get selectedAccount =>
      _accounts.firstWhere((acc) => acc.id == _selectedAccountId);

  // Updates the selected account by ID
  void selectAccount(String id) {
    _selectedAccountId = id;
    notifyListeners(); // Notify UI to update
  }

  // Deduct a specific amount from the selected account
  void deductFromAccount(double amount) {
    selectedAccount.balance -= amount;
    notifyListeners(); // Update UI after deduction
  }

  // Add a specific amount to the selected account
  void addToAccount(double amount) {
    selectedAccount.balance += amount;
    notifyListeners(); // Update UI after addition
  }

  // Alias for addToAccount — could be used specifically on the Add Funds screen
  void addFunds(double amount) {
    final account = _accounts.firstWhere((acc) => acc.id == _selectedAccountId);
    account.balance += amount;
    notifyListeners(); // Update UI
  }
}
