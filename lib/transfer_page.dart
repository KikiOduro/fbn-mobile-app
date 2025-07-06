import 'package:flutter/material.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002147), 
      appBar: AppBar(
        title: const Text("To Account"),
        backgroundColor: const Color(0xFF002147),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Please choose a transaction type and fill all required inputs",
              style: TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),

          // Main content area with transfer options
          Expanded(
            child: Container(
              color: Colors.white, 
              child: ListView(
                children: [
                  // Option for transferring to FBNBank account
                  _accountOptionTile(
                    title: "FBNBank Accounts",
                    onTap: () {
                      Navigator.pushNamed(context, '/transfer-fbn');
                    },
                  ),

                  // Option for transferring to Other Bank account
                  _accountOptionTile(
                    title: "Other Banks' Accounts",
                    onTap: () {
                      Navigator.pushNamed(context, '/transfer-other');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable widget for account option tile
  Widget _accountOptionTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.chevron_right), 
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class StepCircle extends StatelessWidget {
  final int number;
  final bool isCompleted;
  final bool isCurrent;

  const StepCircle({
    super.key,
    required this.number,
    this.isCompleted = false,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    // Default colors
    Color fillColor = Colors.transparent;
    Color textColor = Colors.white54;

    // If the step is completed, highlight it
    if (isCompleted) {
      fillColor = const Color(0xFFB89C3E); // Gold
      textColor = Colors.black;
    } 
    // If the step is current, show white background
    else if (isCurrent) {
      fillColor = Colors.white;
      textColor = Colors.black;
    }

    // Circle showing the step number
    return CircleAvatar(
      radius: 18,
      backgroundColor: fillColor,
      child: Text(
        '$number',
        style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
