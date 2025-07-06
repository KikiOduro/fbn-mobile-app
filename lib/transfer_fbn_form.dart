
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/transaction_model.dart';             // Model for storing transaction details
import 'providers/transaction_provider.dart';       // Manages transaction history
import 'providers/account_provider.dart';           // Manages selected account and balances

// Transfer form page for sending money to another FBN account
class FBNTransferForm extends StatefulWidget {
  const FBNTransferForm({super.key});

  @override
  State<FBNTransferForm> createState() => _FBNTransferFormState();
}

class _FBNTransferFormState extends State<FBNTransferForm> {
  // Form key to manage validation state
  final _formKey = GlobalKey<FormState>();

  // Controllers to retrieve form input values
  final _nameController = TextEditingController();
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();

  //  transfer logic
  void _submitTransfer() {
    if (_formKey.currentState!.validate()) {
      final double amount = double.parse(_amountController.text);
      final accountProvider = Provider.of<AccountProvider>(context, listen: false);

      // Deduct the amount from the currently selected account
      accountProvider.deductFromAccount(amount);

      // Add the transaction to the transaction list
      Provider.of<TransactionProvider>(context, listen: false).addTransaction(
        TransactionModel(
          title: 'Transfer to ${_nameController.text} (FBN)', // Transaction title
          amount: amount,
          date: DateTime.now(), // Timestamp
        ),
      );

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Transfer Successful"),
          content: Text(
            "GHS $amount sent to ${_nameController.text} (FBNBank) "
            "from ${accountProvider.selectedAccount.name}.",
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context), // Close the dialog
            ),
          ],
        ),
      );
    }
  }

  //  input decoration styling
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white38),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFB89C3E)), // Gold border
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF002147), // background
      appBar: AppBar(
        title: const Text('FBNBank Transfer'),
        backgroundColor: const Color(0xFF002147),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        // Transfer form
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Transfer to FBN Account',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 20),

              // Account selector dropdown
              DropdownButtonFormField<String>(
                value: accountProvider.selectedAccount.id, // current selected account
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Select Account'),
                items: accountProvider.accounts.map((acc) {
                  return DropdownMenuItem(
                    value: acc.id,
                    child: Text(
                      '${acc.name} - GHS ${acc.balance.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    accountProvider.selectAccount(value); // change selected account
                  }
                },
              ),
              const SizedBox(height: 20),

              // Recipient name field
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Recipient Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 20),

              // Recipient account number field
              TextFormField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Account Number'),
                validator: (value) => value == null || value.length < 8
                    ? 'Enter valid account number'
                    : null,
              ),
              const SizedBox(height: 20),

              // Amount field
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Amount (GHS)'),
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'Enter valid amount'
                        : null,
              ),
              const SizedBox(height: 30),

              // Submit Transfer button
              ElevatedButton(
                onPressed: _submitTransfer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB89C3E), 
                ),
                child: const Text(
                  'Transfer',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
