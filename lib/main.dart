
import 'package:flutter/material.dart';
// Importing Provider package for state management
import 'package:provider/provider.dart';

// Importing providers (state management classes)
import 'providers/transaction_provider.dart';
import 'providers/account_provider.dart';

// Importing various page widgets (screens)
import 'home_page.dart';
import 'login_page.dart';
import 'dashboard.dart';
import 'transfer_page.dart';
import 'bills_page.dart';
import 'accounts_page.dart';
import 'transactions_page.dart';
import 'transfer_fbn_form.dart';
import 'transfer_other_form.dart';
import 'add_funds_page.dart'; // Page to add money to an account

void main() {
  // Wrapping the app with MultiProvider to provide multiple states
  runApp(
    MultiProvider(
      providers: [
        // Providing a TransactionProvider to manage transactions state
        ChangeNotifierProvider(create: (_) => TransactionProvider()),

        // Providing an AccountProvider to manage account balances and info
        ChangeNotifierProvider(create: (_) => AccountProvider()),
      ],

      // Running the main app widget
      child: const MyApp(),
    ),
  );
}

// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title of the app
      title: 'FBNMobile',

      // Hides the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,

      // Sets the first page to show when the app starts
      initialRoute: '/',

      // Defining routes for easy navigation between screens
      routes: {
        '/': (context) => const FBNHomePage(), //  home screen
        '/login': (context) => const LoginPage(), // Login screen
        '/dashboard': (context) => const DashboardPage(), // Main dashboard
        '/transfer': (context) => const TransferPage(), // Transfer selection
        '/bills': (context) => const BillsPage(), // Bill payments
        '/accounts': (context) => const AccountsPage(), // View/manage accounts
        '/transactions': (context) => const TransactionsPage(), // View transaction history
        '/transfer-fbn': (context) => const FBNTransferForm(), // Transfer to FBNBank accounts
        '/transfer-other': (context) => const OtherBankTransferForm(), // Transfer to other banks
        '/add-funds': (context) => const AddFundsPage(), // Add money to an account
      },
    );
  }
}
