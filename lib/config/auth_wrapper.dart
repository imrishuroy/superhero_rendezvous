import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/blocs/auth/auth_bloc.dart';
import '/config/service_locator.dart';
import '/constants/constants.dart';
import '/widgets/loading_indicator.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final _authBloc = locator<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        print('Auth Wrapper state -- $state');
        print('Check -- 1');
        if (state.status == AuthStatus.unauthenticated) {
          print('this is the check 1');
          context.pushNamed(RoutePaths.login);

          // if (SharedPrefs().birthDetails?.birthDate == null) {
          //   print('Check 2');
          //   //Navigator.of(context).pushNamed(SearchTwinsScreen.routeName);
          // } else {
          //   print('Check 3');
          //   Navigator.of(context).pushNamed(NavScreen.routeName);
          //   Navigator.of(context).pushNamed(LoginScreen.routeName);
          // }
        } else if (state.status == AuthStatus.authenticated) {
          context.pushNamed(RoutePaths.home);

          // context.pushNamed(RouteP);
          //Navigator.of(context).pushNamed(NavScreen.routeName);

          // print('Check 4');
          // print('User from auth wrapper - ${state.user}');
          // if (state.user?.birthPlace == null &&
          //     state.user?.birthDate == null &&
          //     state.user?.birthTime == null) {
          //   Navigator.of(context).pushNamed(SearchTwinsScreen.routeName);
          // } else {
          //   print('Check 5');
          //   Navigator.of(context).pushNamed(NavScreen.routeName);
          // }
        } else {
          print('Check 6');
        }
      },
      child: const Scaffold(
        backgroundColor: Color(0xffED462F),
        body: LoadingIndicator(color: Colors.white),
      ),
    );
  }
}
