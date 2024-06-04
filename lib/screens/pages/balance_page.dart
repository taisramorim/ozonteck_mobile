import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Transaction> transactionList = List.generate(150, (index) {
      return Transaction(
        id: index.toString(),
        description: 'This was you $index purchase',
        amount: 10 * index,
        date: DateTime.now()
      );
    });

    int totalBalance = transactionList.fold<int>(0, (sum, transaction) => sum + transaction.amount);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const Text('Your Balance'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 55.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.stacked_line_chart_outlined, color: Colors.white, size: 38,),
                      const SizedBox(width: 8.0),
                      Text(
                        'Your current balance: $totalBalance',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.account_balance_wallet, color: Colors.white), // Replace if needed
                      const SizedBox(width: 8.0),
                      Text(
                        'Last month: ${totalBalance - 50000} ',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    final transaction = Transaction(
                      id: index.toString(),
                      description: 'Transaction $index',
                      amount: 10 * index,
                      date: DateTime.now()
                    );
                    return ListTile(
                      title: Text(transaction.description),
                      subtitle: Text(transaction.amount.toString()),
                      trailing: Text(transaction.date.toString()),
                    );
                  }
                ))
          ],
        ),
      )
    );
  }
}

  // Example of a model class
  class Transaction {
  final String id;
  final String description;
  final int amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}
