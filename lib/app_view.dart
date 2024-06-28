import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozonteck_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ozonteck_mobile/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:ozonteck_mobile/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ozonteck_mobile/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ozonteck_mobile/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:ozonteck_mobile/blocs/cart_bloc/cart_bloc.dart';
import 'package:ozonteck_mobile/screens/home/home_screen.dart';
import 'package:ozonteck_mobile/screens/authentication/welcome_page.dart';
import 'package:product_repository/product_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ozone App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Color.fromRGBO(7, 24, 31, 1),
          onPrimary: Color.fromRGBO(20, 60, 76, 1),
          secondary: Color.fromRGBO(113, 202, 189, 1),
          onSecondary: Color.fromRGBO(123, 242, 215, 1),
          tertiary: Color.fromRGBO(173, 184, 194, 1),
          onTertiary: Color.fromRGBO(215, 221, 226, 1),
          outline: Color.fromRGBO(242, 249, 249, 1),
          error: Colors.red),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                    userRepository: context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                BlocProvider(
                  create: (context) => UpdateUserInfoBloc(
                    userRepository: context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                BlocProvider(
                  create: (context) => MyUserBloc(
                    myUserRepository: context.read<AuthenticationBloc>().userRepository,
                  )..add(GetMyUser(
                    myUserId: context.read<AuthenticationBloc>().state.user!.uid,
                  )),
                ),
                BlocProvider<GetProductBloc>(
                  create: (context) => GetProductBloc(
                    productRepository: context.read<ProductRepository>(),
                  )..add(LoadProduct()),
                ),
                BlocProvider(
                  create: (context) => CartBloc(
                    FirebaseCartRepository(),
                    context.read<AuthenticationBloc>().state.user!.uid,
                  )..add(LoadCart()),
                ),
              ],
              child: HomeScreen(userId: context.read<AuthenticationBloc>().state.user!.uid),
            );
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
