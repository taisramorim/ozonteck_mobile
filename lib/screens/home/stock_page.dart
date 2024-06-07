import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/blocs/cart_bloc/cart_bloc.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Your Stock'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated){
            final user = state.user;
            return ListView.builder(
              itemCount: user.personalStock.length,
              itemBuilder:  (context, index) {
                final productId = user.personalStock.keys.elementAt(index);
                final productQuantity = user.personalStock[productId];
                return ListTile(
                  title: Text('Prodict ID: $productId'),  
                  subtitle: Text('Quantity: $productQuantity'),
                );
              },
            );
          } else {
            return const Center (
              child: Text('No products in stock'),
            );
          }
        },
      )
    );
  }
}