import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/blocs/cart_bloc/cart_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail(this.product, {super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserId();
  }

  Future<void> _fetchCurrentUserId() async {
    final userRepository = context.read<UserRepository>();
    try {
      final userId = await userRepository.getCurrentUserId();
      setState(() {
        _currentUserId = userId;
      });
    } catch (e) {
      // Handle error if needed
      print('Error fetching user ID: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Product Detail'),            
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product.imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ),
                        Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'R\$ ${widget.product.price.toString()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentUserId != null) {
                            final cartItem = CartItem(product: widget.product);
                            context.read<CartBloc>().add(AddToCart(
                              userId: _currentUserId!,
                              cartItem: cartItem,
                            ));
                          }                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                        limitDescription(widget.product.description),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 600, // Ajuste a altura do painel
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Text(
                                widget.product.description,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('Leia mais', style: TextStyle(fontSize: 14),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),      
    );
  }

  String limitDescription(String description) {
  int dotIndex = description.indexOf('.');
  return dotIndex != -1 ? description.substring(0, dotIndex + 1) : description;
  }
}