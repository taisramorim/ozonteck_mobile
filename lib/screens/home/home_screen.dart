import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ozonteck_mobile/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:ozonteck_mobile/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ozonteck_mobile/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ozonteck_mobile/screens/pages/balance_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  class _HomeScreenState extends State<HomeScreen>{
      @override
      Widget build(BuildContext context) {
        return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
          listener: (context, state) {
            if(state is UploadPictureSuccess) {
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
                                    CroppedFile? croppedFile = await ImageCropper().cropImage(
                                      sourcePath: image.path,
                                      aspectRatio: const CropAspectRatio(
                                        ratioX: 1, 
                                        ratioY: 1
                                        ),
                                        aspectRatioPresets: [
                                          CropAspectRatioPreset.square
                                        ],
                                        uiSettings: [
                                          AndroidUiSettings(
                                            toolbarTitle: 'Cropper',
                                            toolbarColor: Colors.black,
                                            toolbarWidgetColor: Colors.white,
                                            initAspectRatio: CropAspectRatioPreset.original,
                                            lockAspectRatio: false
                                          ),
                                          IOSUiSettings(
                                            title: 'Cropper'
                                          ),
                                        ],
                                    );
                                    if(croppedFile != null) {
                                      setState(() {
                                        context.read<UpdateUserInfoBloc>().add(
                                          UploadPicture(
                                            croppedFile.path,
                                            context.read<MyUserBloc>().state.user!.id
                                          )
                                        );                 
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, 
                                      color: Colors.grey
                                      ),
                                      child: const Icon(
                                        Icons.person, 
                                        color: Colors.white
                                      ),
                                  ),
                              )
                              : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          state.user!.picture!
                                          ),
                                        fit: BoxFit.cover
                                        )
                                    ),
                                ),
                          const SizedBox(width: 15),
                          Text(
                            "Welcome ${state.user!.name}",
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
                  IconButton(
                    onPressed: () {
                      context.read<SignInBloc>().add(const SignOutRequired());
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ranking Container
                    SizedBox(
                      height: 150,
                      width: 300,
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Theme.of(context).colorScheme.onTertiary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/oztmobile-750cd.appspot.com/o/Pins%2Froyal-black.png?alt=media&token=4683efb9-7d2e-4ac2-b99c-f58fc6c2bbd6',
                            height: 70,
                            width: 70),
                      ),
                    ),
                    const SizedBox(height: 100),
                    // First 3 icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const BalancePage()),
                                );
                              },
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),
                              child: const Icon(Icons.wallet, color: Colors.white),
                            ),
                          ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.people, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.scale, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // Second 3 icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.shopping_bag, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.link, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.location_city_rounded,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
  