// import 'package:flutter/material.dart';

// class AccountsPage extends StatelessWidget {
//   const AccountsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Accounts & Balances')),
//       body: const Center(child: Text('Accounts & Balances Page')),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});
//Hardcoded list of account details
  final List<Map<String, String>> accounts = const [
    {'type': 'Savings Account', 'number': '0123456789', 'balance': '12,500.00'},
    {'type': 'Current Account', 'number': '9876543210', 'balance': '5,260.75'},
    {'type': 'Student Account', 'number': '1029384756', 'balance': '1,120.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002147),
      appBar: AppBar(
        title: const Text("Accounts & Balances"),
        backgroundColor: const Color(0xFF002147),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        //A scrollable list of account cards
        child: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                //Column to show account type, number, and balance
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account['type']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002147),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Account No: ${account['number']}',
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Balance: GHS ${account['balance']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
