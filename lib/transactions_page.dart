import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'models/transaction_model.dart';
import 'providers/transaction_provider.dart';
import 'package:intl/intl.dart'; // for formatting date

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;

    return Scaffold(
      backgroundColor: const Color(0xFF002147),
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: const Color(0xFF002147),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: transactions.isEmpty
            ? const Center(
                child: Text(
                  'No transactions yet.',
                  style: TextStyle(color: Colors.white70),
                ),
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        tx.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('dd MMM yyyy – hh:mm a').format(tx.date),
                      ),
                      trailing: Text(
                        '- GHS ${tx.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
