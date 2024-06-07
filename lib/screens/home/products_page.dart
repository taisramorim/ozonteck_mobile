import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/blocs/cart_bloc/cart_bloc.dart';
import 'package:ozonteck_mobile/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:ozonteck_mobile/screens/pages/product_detail.dart';
import 'package:ozonteck_mobile/widgets/cart_icon.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Products Page'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const CartIcon(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<GetProductBloc, GetProductState>(
              builder: (context, state) {
                if (state is GetProductSuccess) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 9 / 17,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, int i) {
                      final sortedProducts = List.from(state.products);
                      sortedProducts.sort((a, b) => a.name.compareTo(b.name));
                      final product = sortedProducts[i];
                      return Material(
                        elevation: 3,
                        color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => ProductDetail(product),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AspectRatio(
                                  aspectRatio:
                                      1.3, // Set the aspect ratio as needed for your images
                                  child: Image.network(
                                    product.picture,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  limitDescription(product.description),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'R\$ ${product.price.toString()}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    if (product.discount > 0) ...{
                                      const SizedBox(width: 3),
                                      Text(
                                        'R\$ ${(product.price + product.discount).toString()}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    },
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(AddToCart(product));
                                        },
                                        icon:
                                            const Icon(Icons.add_shopping_cart),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is GetProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            )        
        )
      );    
  }

  String limitDescription(String description) {
    int dotIndex = description.indexOf('.');
    return dotIndex != -1
        ? description.substring(0, dotIndex + 1)
        : description;
  }
}
