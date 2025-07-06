// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'providers/account_provider.dart';
import 'providers/transaction_provider.dart';

// Main dashboard screen
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting selected account from AccountProvider
    final accountProvider = Provider.of<AccountProvider>(context);
    final selected = accountProvider.selectedAccount;

    // Getting username passed from login or home page
    final String username =
        ModalRoute.of(context)!.settings.arguments as String? ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFF002147),

      // Main layout with a sidebar on the left and content on the right
      body: Row(
        children: [
          const Sidebar(), // Custom widget for sidebar navigation
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Personalized welcome message
                  Text(
                    ' Welcome back, $username!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Visa Card design with hardcoded values + username
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3A3A3A), Color(0xFF1A1A1A)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PLATINUM VISA',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '1234 5678 9012 3456', // hardcoded card number
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'VALID THRU 12/25',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              username.toUpperCase(), // cardholder name
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Display selected account's balance
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB89C3E), // gold color
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Account name and balance
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${selected.name} Balance',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'GHS ${selected.balance.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.pie_chart,
                          size: 40,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Header for recent purchases
                  const Text(
                    'Recent Purchases',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Recent transactions section
                  Expanded(
                    child: Consumer<TransactionProvider>(
                      builder: (context, provider, _) {
                        // Filter recent transactions (bills and transfers only)
                        final transactions = provider.transactions
                            .where(
                              (tx) =>
                                  tx.title.toLowerCase().contains("bill") ||
                                  tx.title.toLowerCase().contains("transfer"),
                            )
                            .toList()
                            .reversed
                            .take(5)
                            .toList();

                        // If no transactions yet
                        if (transactions.isEmpty) {
                          return const Center(
                            child: Text(
                              'No recent purchases.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }

                        // Show the recent transactions
                        return ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final tx = transactions[index];
                            return PurchaseItem(
                              icon: Icons.monetization_on,
                              title: tx.title,
                              date: DateFormat(
                                'dd MMM yyyy – hh:mm a',
                              ).format(tx.date),
                              amount: '- GHS ${tx.amount.toStringAsFixed(2)}',
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Sidebar with hover expansion
class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _hover = false; // Tracks if the sidebar is being hovered over

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),

      // Animated width change on hover
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _hover ? 200 : 60,
        color: const Color(0xFF001F3F),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Sidebar navigation items
            NavCard(
              icon: Icons.send,
              label: 'Transfer',
              route: '/transfer',
              expanded: _hover,
            ),
            NavCard(
              icon: Icons.receipt,
              label: 'Bills',
              route: '/bills',
              expanded: _hover,
            ),
            NavCard(
              icon: Icons.account_balance,
              label: 'Accounts',
              route: '/accounts',
              expanded: _hover,
            ),
            NavCard(
              icon: Icons.history,
              label: 'Transactions',
              route: '/transactions',
              expanded: _hover,
            ),
          ],
        ),
      ),
    );
  }
}

// Sidebar navigation card
class NavCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool expanded;

  const NavCard({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route), // Navigate to page
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            if (expanded) ...[
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Recent purchase transaction card
class PurchaseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String amount;

  const PurchaseItem({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(date, style: const TextStyle(color: Colors.white70)),
      trailing: Text(
        amount,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
