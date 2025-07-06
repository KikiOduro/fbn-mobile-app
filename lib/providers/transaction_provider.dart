
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

// This provider manages the list of transactions (like transfers, bills, etc.)
class TransactionProvider with ChangeNotifier {
  // Private list that stores all transactions
  final List<TransactionModel> _transactions = [];

  // Public getter to access the list of transactions
  List<TransactionModel> get transactions => _transactions;

  // Adds a new transaction to the top of the list
  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction); // Adds most recent at the top
    notifyListeners(); // Notifies the UI to refresh and reflect the new data
  }
}
