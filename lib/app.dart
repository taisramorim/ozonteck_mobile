import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/app_view.dart';
import 'package:ozonteck_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:ozonteck_mobile/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:ozonteck_mobile/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ozonteck_mobile/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ozonteck_mobile/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:ozonteck_mobile/blocs/cart_bloc/cart_bloc.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;

  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (_) => userRepository),
        RepositoryProvider<ProductRepository>(
          create: (context) => FirebaseProductRepository(),
        ),
        RepositoryProvider<CartRepo>(
          create: (_) => FirebaseCartRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              myUserRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignInBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UpdateUserInfoBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => MyUserBloc(
              myUserRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => GetProductBloc(
              productRepository: context.read<ProductRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(
              userRepository: context.read<UserRepository>(),              
              cartRepository: context.read<CartRepo>(),
              productRepository: context.read<ProductRepository>(),
            ),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}
