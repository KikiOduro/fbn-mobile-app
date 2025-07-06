
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/transaction_model.dart';             // Model for representing a transaction
import 'providers/transaction_provider.dart';       // For managing transaction history
import 'providers/account_provider.dart';           // For managing user accounts

// Transfer page for sending money to another bank
class OtherBankTransferForm extends StatefulWidget {
  const OtherBankTransferForm({super.key});

  @override
  State<OtherBankTransferForm> createState() => _OtherBankTransferFormState();
}

class _OtherBankTransferFormState extends State<OtherBankTransferForm> {
  // Key to manage form validation state
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _nameController = TextEditingController();     
  final _bankController = TextEditingController();     
  final _accountController = TextEditingController();  
  final _amountController = TextEditingController();   

  // Handles submission of the form
  void _submitTransfer() {
    if (_formKey.currentState!.validate()) {
      final double amount = double.parse(_amountController.text);
      final accountProvider =
          Provider.of<AccountProvider>(context, listen: false);

      // Deduct from the currently selected account
      accountProvider.deductFromAccount(amount);

      // Add the transaction to history
      Provider.of<TransactionProvider>(context, listen: false).addTransaction(
        TransactionModel(
          title:
              'Transfer to ${_nameController.text} (${_bankController.text})',
          amount: amount,
          date: DateTime.now(),
        ),
      );

      // Shows a confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Transfer Successful"),
          content: Text(
            "GHS $amount sent to ${_nameController.text} "
            "(${_bankController.text}) from ${accountProvider.selectedAccount.name}.",
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

 
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
      backgroundColor: const Color(0xFF002147), // FBN dark blue
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147),
        title: const Text('Other Bank Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        // The transfer form
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Transfer to Other Bank',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 20),

              // Dropdown to select the account to send from
              DropdownButtonFormField<String>(
                value: accountProvider.selectedAccount.id,
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
                    accountProvider.selectAccount(value); // Update selected account
                  }
                },
              ),
              const SizedBox(height: 20),

              // Recipient Name field
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Recipient Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 20),

              // Bank Name
              TextFormField(
                controller: _bankController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Bank Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter bank' : null,
              ),
              const SizedBox(height: 20),

              // Account Number
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

              // Amount
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

              // Transfer Button
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
