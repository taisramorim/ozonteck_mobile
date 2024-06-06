import 'package:flutter/material.dart';
import 'package:ozonteck_mobile/screens/pages/product_detail.dart';

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
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.shopping_cart),
              ),
            ],            
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 9/16),
                itemCount: 8, 
              itemBuilder: (context, int i){
                return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context, 
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const ProductDetail(),
                        )
                      );
                      },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Image.asset('assets/AMPOLA.png', scale: 9,),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text('Lançamento',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          const SizedBox(height: 10),
                          const Text(
                            'Ampola Just making a test',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Ampola ozonizada de tratamento para cabelos ressecados.',                       style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'R\$55.00',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                'R\$75.00',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.lineThrough
                                ),
                              ),
                              IconButton(
                                onPressed: () {}, 
                                icon: const Icon(Icons.add_shopping_cart)),
                            ],
                          ),
                        ],
                      ),
                    ),                 
                  ),
                );
              }),
          ),
    );
  }
}