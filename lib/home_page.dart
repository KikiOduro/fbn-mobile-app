import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';

class FBNHomePage extends StatelessWidget {
  const FBNHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002147),
      body: Column(
        children: [
          // Logo/Image (top)
          Expanded(
            flex: 7,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/fbn.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
          ),

          // Welcome Text
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Banking Made Easy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Continue button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Continue'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 6,
            ),
          ),

          const SizedBox(height: 20),

          // Recent purchases
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.only(bottom: 20),
            child: Consumer<TransactionProvider>(
              builder: (context, provider, _) {
                final transactions = provider.transactions.reversed
                    .take(3)
                    .toList();

                if (transactions.isEmpty) {
                  return const Text(
                    'No recent purchases',
                    style: TextStyle(color: Colors.white70),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Purchases',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...transactions.map(
                      (tx) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          '• ${tx.title} - GHS ${tx.amount.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
