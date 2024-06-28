import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ozonteck_mobile/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:ozonteck_mobile/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:ozonteck_mobile/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ozonteck_mobile/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ozonteck_mobile/components/icons_home.dart';
import 'package:ozonteck_mobile/components/score/pins_level.dart';
import 'package:ozonteck_mobile/components/score/score_display.dart';
import 'package:ozonteck_mobile/screens/home/balance_page.dart';
import 'package:ozonteck_mobile/screens/home/network_page.dart';
import 'package:ozonteck_mobile/screens/home/orders_page.dart';
import 'package:ozonteck_mobile/screens/home/products_page.dart';
import 'package:ozonteck_mobile/screens/home/score_page.dart';
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
                    state.user!.picture == ""
                        ? GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                                maxHeight: 500,
                                maxWidth: 500,
                                imageQuality: 40,
                              );
                              if (image != null) {
                                CroppedFile? croppedFile =
                                    await ImageCropper().cropImage(
                                  sourcePath: image.path,
                                  aspectRatio: const CropAspectRatio(
                                    ratioX: 1,
                                    ratioY: 1
                                  ),                                  
                                  uiSettings: [
                                    AndroidUiSettings(
                                        toolbarTitle: 'Cropper',
                                        toolbarColor: Colors.black,
                                        toolbarWidgetColor: Colors.white,
                                        aspectRatioPresets: [
                                          CropAspectRatioPreset.square
                                        ],
                                        initAspectRatio:
                                            CropAspectRatioPreset.original,
                                        lockAspectRatio: false),
                                    IOSUiSettings(title: 'Cropper'),
                                  ],
                                );
                                if (croppedFile != null) {
                                  setState(() {
                                    context.read<UpdateUserInfoBloc>().add(
                                        UploadPicture(
                                            croppedFile.path,
                                            context
                                                .read<MyUserBloc>().state.user!.id));
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              child: const Icon(Icons.person,
                                  color: Colors.white),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(state.user!.picture!),
                                    fit: BoxFit.cover)),
                          ),
                    const SizedBox(width: 15),
                    Text(
                      "Hello ${state.user!.name}",
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
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
                            imageUrl: pinsLevelMapping[7].imageUrl),
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
                      }
                    ),
                    IconsHome(
                      iconData: Icons.people,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NetworkPage(userId: widget.userId,)),
                        );
                      }
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
                              )
                            )
                        );
                      },
                    )
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
                      }
                    ),
                    IconsHome(
                      iconData: Icons.location_city,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NetworkPage(userId: widget.userId)),
                        );
                      }
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