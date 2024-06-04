import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            title: const Text('Orders Page'),
          ),
          body: SafeArea( 
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.money_rounded, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Your previous orders will be displayed here.',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.money_off_csred_rounded, color: Colors.white), 
                      SizedBox(width: 8.0),
                      Text(
                        'You have no orders yet.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    final Transfer transfer = Transfer(
                      id: index.toString(),
                      description: 'Transfer $index',
                      amount: 10.0 * index,
                      date: DateTime.now()
                    );
                    return ListTile(
                      title: Text(transfer.description),
                      subtitle: Text(transfer.amount.toString()),
                      trailing: Text(transfer.date.toString()),
                    );
                  }
                ))
          ],
        ),
      ),
    );
  }
}

  // Example of a model class
  class Transfer {
  final String id;
  final String description;
  final double amount;
  final DateTime date;

  Transfer({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}