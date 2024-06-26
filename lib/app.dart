import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/app_view.dart';
import 'package:ozonteck_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:product_repository/product_repository.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;

  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(myUserRepository: userRepository),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => FirebaseProductRepository(),
        ),
        RepositoryProvider<CartRepo>(
          create: (_) => FirebaseCartRepository(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
