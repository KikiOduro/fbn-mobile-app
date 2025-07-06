import 'package:flutter/material.dart';//imports the material package
import 'package:provider/provider.dart';//imports the provider package
import 'providers/account_provider.dart';//imports the account provider
// Stateful widget since user interaction and form state needs to be managed
class AddFundsPage extends StatefulWidget {
  const AddFundsPage({super.key});

  @override
  State<AddFundsPage> createState() => _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage> {
  // Key to identify and manage the form's state
  final _formKey = GlobalKey<FormState>();
   // Controller to retrieve and control the amount input
  final _amountController = TextEditingController();
  // Function to handle form submission
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);

  // Call the provider's addFunds function for the selected account
      Provider.of<AccountProvider>(context, listen: false).addFunds(amount);

            // Show a success dialog to confirm the funds were added
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Success"),
          content: Text("GHS $amount added to your account."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // goes back to dashboard
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
  // Reusable function to style text input fields consistently
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white38),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFB89C3E)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002147),
      appBar: AppBar(
        title: const Text("Add Funds"),
        backgroundColor: const Color(0xFF002147),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Enter amount to add",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Amount (GHS)"),
                //ensures the input is a valid number
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return "Enter a valid amount";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB89C3E),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "Add Funds",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
