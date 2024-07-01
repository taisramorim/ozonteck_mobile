import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/blocs/cart_bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  final String userId;

  const CartPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final cartItem = state.cart[index];
                return ListTile(
                  title: Text(cartItem.product.name),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Text('\$${cartItem.totalPrice}'),
                );
              },
            );
          } else if (state is CartLoadFailure) {
            return Center(child: Text('Failed to load cart: ${state.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CartBloc>().add(PurchaseProducts(userId: userId));
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
