import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/blocs/auth/auth_bloc.dart';
import '/config/service_locator.dart';
import '/constants/constants.dart';
import '/home_screen.dart';
import '/repositories/auth/auth_repo.dart';
import '/screens/login/cubit/login_cubit.dart';
import '/screens/login/login_screen.dart';
import '/screens/registration/cubit/registration_cubit.dart';
import '/screens/registration/screens/registration_screen.dart';
import '/screens/splash/splash_screen.dart';

class CustomRouter {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RoutePaths.splash,
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      // GoRoute(
      //   name: RoutePaths.authWrapper,
      //   path: '/auth-wrapper',
      //   builder: (context, state) => const AuthWrapper(),
      // ),
      GoRoute(
        name: RoutePaths.login,
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(
            authRepository: locator<AuthRepository>(),
            authBloc: locator<AuthBloc>(),
          ),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: RoutePaths.register,
        path: '/register',
        builder: (context, state) => BlocProvider(
          create: (context) => RegistrationCubit(
            authRepository: locator<AuthRepository>(),
            authBloc: locator<AuthBloc>(),
          ),
          child: const RegistrationScreen(),
        ),
      ),
      GoRoute(
        name: RoutePaths.home,
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: RoutePaths.details,
        path: '/details',
        builder: (context, state) => const DetailsScreen(),
      ),
      GoRoute(
        name: RoutePaths.newPage,
        path: '/new-page',
        builder: (context, state) => const NewPage(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      ),
    ),
    refreshListenable: AuthStateNotifier(),
    redirect: (context, state) {
      final authBloc = locator<AuthBloc>();
      print('Redirecting...');
      print('Redirecting to ${state.location}');
      print('Redirecting authstatus ${authBloc.state.status}');

      /// return null;

      final isLoggedIn = authBloc.state.status == AuthStatus.authenticated;
      final isLoggingIn = state.subloc == '/login';

      if (!isLoggedIn) {
        return '/login';
      }

      if (isLoggingIn) {
        return '/home';
      }

      print('This runs when the user is logged in and not on the login page');
      return null;
    },
  );
}

class AuthStateNotifier extends ChangeNotifier {
  late final StreamSubscription<AuthState> _blocStream;
  AuthStateProvider(AuthBloc bloc) async {
    _blocStream = bloc.stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _blocStream.cancel();
  }
}
