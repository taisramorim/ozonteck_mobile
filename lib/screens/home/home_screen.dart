import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:ozonteck_mobile/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:ozonteck_mobile/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ozonteck_mobile/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ozonteck_mobile/components/icons_home.dart';
import 'package:ozonteck_mobile/widgets/score/pins_level.dart';
import 'package:ozonteck_mobile/widgets/score/score_display.dart';
import 'package:ozonteck_mobile/screens/home/balance_page.dart';
import 'package:ozonteck_mobile/screens/home/network_page.dart';
import 'package:ozonteck_mobile/screens/home/orders_page.dart';
import 'package:ozonteck_mobile/screens/home/products_page.dart';
import 'package:ozonteck_mobile/screens/home/score_page.dart';
import 'package:ozonteck_mobile/screens/pages/cart_page.dart';
import 'package:ozonteck_mobile/screens/pages/profile_page.dart';
import 'package:product_repository/product_repository.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: context.read<MyUserBloc>(),
                                ),
                                BlocProvider.value(
                                  value: context.read<UpdateUserInfoBloc>(),
                                ),
                              ],
                              child: ProfilePage(userId: widget.userId),
                            ),
                          ),
                        );
                      },
                      child: state.user!.picture == ""
                          ? Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              child: const Icon(Icons.person, color: Colors.white),
                            )
                          : Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(state.user!.picture!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Hello ${state.user!.name}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(userId: widget.userId),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Ranking Container
                Hero(
                  tag: 'score',
                  child: SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScorePage()),
                        );
                      },
                      child: Material(
                        color: Theme.of(context).colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(20),
                        child: ScoreDisplay(
                          currentPoints: 5000,
                          nextLevelPoints: 15000,
                          imageUrl: pinsLevelMapping[7].imageUrl,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                // First 3 icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconsHome(
                      iconData: Icons.account_balance,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BalancePage()),
                        );
                      },
                    ),
                    IconsHome(
                      iconData: Icons.people,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NetworkPage(userId: widget.userId)),
                        );
                      },
                    ),
                    IconsHome(
                      iconData: Icons.heat_pump_rounded,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => GetProductBloc(
                                productRepository: RepositoryProvider.of<ProductRepository>(context),
                              )..add(LoadProduct()),
                              child: const ProductsPage(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Second 2 icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconsHome(
                      iconData: Icons.shopping_bag,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OrdersPage()),
                        );
                      },
                    ),
                    IconsHome(
                      iconData: Icons.location_city,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NetworkPage(userId: widget.userId)),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
