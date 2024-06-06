import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: 
                  AssetImage('assets/AMPOLA.png'),
                  scale: 2.5,
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Ampola Mágica Soft Hair Ozonizada Reconstrução 18ml',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '\$55.00',
                            style: TextStyle(
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
                        onPressed: () {},
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
                    const Text('Ampola ozonizada de tratamento para cabelos ressecados, Soft Hair da OZONTECK oferece nutrição e hidratação intensa que dá brilho aos fios.'),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 600, // Ajuste a altura do painel
                            padding: const EdgeInsets.all(16.0),
                            child: const SingleChildScrollView(
                              child: Text(
                                'Ampola ozonizada de tratamento para cabelos ressecados, Soft Hair da OZONTECK oferece nutrição e hidratação intensa que dá brilho aos fios. Contém alta concentração de nutrientes e hidratantes que penetram profundamente na fibra capilar e eliminam o aspecto sem vida, áspero e opaco dos fios. Além de tratar, a fórmula de Soft Hair também protege da volta do ressecamento com a selagem das cutículas, a barreira natural dos fios, que garante também o brilho luminoso e o sensorial macio. TOP 10 benefícios da Ampola Mágica SOFT HAIR! 1 - Hidrata e nutre profundamente. 2- Auxilia no combate a queda. 3- Fortalece os fios. 4- Auxilia no crescimento capilar. 5- Mais brilho e maciez. 6- Reduz o volume. 7- Controla o frizz. 8- Elimina as pontas duplas. 9- Compatível com todos os tipos de cabelos. 10- Produto com ALTÍSSIMA QUALIDADE para empreender. Modo de preparo: 1 colher de sopa para cada 30ml de água, misturar até virar um mousse. Rende até 5 aplicaçações dependendo o comprimento do seu cabelo. Conselho de Aplicação: Após lavar os cabelos, retire o excesso de água dos fios com uma toalha, em seguida, distribua o conteúdo preparado da ampola no comprimento e pontas. Massageie mecha a mecha e deixe agir de 10 a 15 minutos. Enxágue completamente. A FINALIZAÇÃO É POR CONTA DO CLIENTE. PARA TODOS OS TIPOS DE CABELO.',
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
}