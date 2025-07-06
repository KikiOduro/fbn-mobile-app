// This class represents a financial transaction
class TransactionModel {
  // A short description or title of the transaction
  final String title;
  // The amount involved in the transaction
  final double amount;
  // The date and time the transaction occurred
  final DateTime date;
  // Constructor to initialize the transaction with required fields
  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
  });
}
