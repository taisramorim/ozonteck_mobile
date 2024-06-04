import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Your Balance',
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '\$500.00', // Replace with actual balance fetched from data
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Transaction History',
              
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 100, // Replace with actual transaction list length
              itemBuilder: (context, index) {
                // Replace with actual transaction model
                final transaction = Transaction(
                  id: index.toString(),
                  description: 'Transaction $index',
                  amount: 50.0, // Example amount
                  date: DateTime.now(),
                );
                return ListTile(
                  title: Text(transaction.description),
                  subtitle: Text(transaction.amount.toString()),
                  trailing: Text(transaction.date.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Example Transaction model
class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}
