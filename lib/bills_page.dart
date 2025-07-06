// Importing required packages
import 'package:provider/provider.dart';
import 'models/transaction_model.dart';
import 'providers/transaction_provider.dart';
import 'package:flutter/material.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  // Key to manage the form's state
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage input fields
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();

  // State variables for dropdown selections
  String? _selectedBillType;
  String? _selectedAccount;

  // Dropdown options for types of bills
  final List<String> _billTypes = [
    'Electricity',
    'Water',
    'Internet',
    'DSTV',
    'School Fees',
  ];

  // Dropdown options for account numbers (can be fetched dynamically in future)
  final List<String> _accountOptions = [
    '0123456789',
    '9876543210',
    '1029384756',
  ];

  // Function to handle bill payment submission
  void _submitBillPayment() {
    if (_formKey.currentState!.validate()) {
      // Add transaction to the TransactionProvider
      Provider.of<TransactionProvider>(context, listen: false).addTransaction(
        TransactionModel(
          title: 'Bill: $_selectedBillType (From $_selectedAccount)',
          amount: double.parse(_amountController.text),
          date: DateTime.now(),
        ),
      );

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Payment Successful"),
          content: Text(
            "GHS ${_amountController.text} paid for $_selectedBillType bill from account $_selectedAccount.",
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context), // Close dialog
            ),
          ],
        ),
      );
    }
  }

  // Function to provide consistent input decoration styling
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white38),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFB89C3E)), // Gold color border
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set navy blue background
      backgroundColor: const Color(0xFF002147),

      // App bar with title
      appBar: AppBar(
        title: const Text('Bills Payment'),
        backgroundColor: const Color(0xFF002147),
      ),

      // Body with padding
      body: Padding(
        padding: const EdgeInsets.all(20),

        // Form to enter bill payment info
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Pay Your Bills',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 30),

              // Dropdown to select account
              DropdownButtonFormField<String>(
                value: _selectedAccount,
                decoration: _inputDecoration('Select Account'),
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                items: _accountOptions.map((account) {
                  return DropdownMenuItem(
                    value: account,
                    child: Text(
                      account,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAccount = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select an account' : null,
              ),
              const SizedBox(height: 20),

              // Dropdown to select bill type
              DropdownButtonFormField<String>(
                value: _selectedBillType,
                dropdownColor: Colors.black,
                decoration: _inputDecoration('Select Bill Type'),
                items: _billTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBillType = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a bill type' : null,
              ),

              const SizedBox(height: 20),

              // Input field for account or reference number
              TextFormField(
                controller: _accountController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Account / Reference Number'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter reference' : null,
              ),

              const SizedBox(height: 20),

              // Input field for payment amount
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

              // Button to submit the payment
              ElevatedButton(
                onPressed: _submitBillPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB89C3E),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
