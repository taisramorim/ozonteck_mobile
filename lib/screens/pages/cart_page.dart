import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/blocs/cart_bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Your Cart'),            
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return _buildCartList(state.cartItems, context);
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Your cart is empty'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CartBloc>().add(ClearCart());
        },
        child: const Icon(Icons.clear_all,)
      ),
    );
  }
}

Widget _buildCartList(List<Cart> cartItems, BuildContext context) {
  return ListView.builder(
    itemCount: cartItems.length,
    itemBuilder: (context, index) {
      final item = cartItems[index];
      return ListTile(
        leading: Image.network(item.product.picture),
        title: Text(item.product.name),
        subtitle: Text('Quantity: ${item.quantity}'),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () {
            context.read<CartBloc>().add(RemoveItemFromCart(item));          
          },
        ),
      );
    }
  );
}