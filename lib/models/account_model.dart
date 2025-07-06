// This class represents a bank account with an ID, name, and balance.
class AccountModel {
  // Unique identifier for the account
  final String id;
  // Name of the account 
  final String name;
  // Current balance of the account
  double balance;
  // Constructor to initialize the account fields
  AccountModel({
    required this.id,
    required this.name,
    required this.balance,
  });
}
