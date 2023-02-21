import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/home_screen.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'config/service_locator.dart';
import 'config/shared_prefs.dart';
import 'constants/route_paths.dart';
import 'firebase_options.dart';
import 'repositories/auth/auth_repo.dart';
import 'screens/login/cubit/login_cubit.dart';
import 'screens/login/login_screen.dart';
import 'screens/registration/cubit/registration_cubit.dart';
import 'screens/registration/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs().init();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();

  runApp(SuperHeroRendezvous());
}

class SuperHeroRendezvous extends StatelessWidget {
  SuperHeroRendezvous({super.key});

  final _authBloc = locator<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authBloc,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _goRouter,
        // routeInformationParser: CustomRouter.router.routeInformationParser,
        // routerDelegate: CustomRouter.router.routerDelegate,
        title: 'SuperHero Rendezvous',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }

  late final GoRouter _goRouter = GoRouter(
    routes: [
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
    ],
    refreshListenable: _authBloc,
    redirect: (context, state) {
      print('Redirecting...');
      print('Redirecting to ${state.location}');
      print('Redirecting authstatus ${_authBloc.state.status}');

      /// return null;

      final isLoggedIn = _authBloc.state.status == AuthStatus.authenticated;
      final isLoggingIn = state.subloc == '/login';

      if (!isLoggedIn) {
        return '/login';
      }

      if (isLoggingIn) {
        return '/home';
      }
      return null;
    },
  );
}










// import 'package:equatable/equatable.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:superhero_rendezvous/firebase_options.dart';

// import '/blocs/auth/auth_bloc.dart';
// import '/cubits/connect/connect_cubit.dart';
// import '/repositories/astro/astro_repository.dart';
// import '/repositories/chat/chat_repository.dart';
// import '/repositories/notif/notif_repository.dart';
// import '/repositories/twins/twins_repository.dart';
// // import '/screens/notifictions/cubit/notifications_cubit.dart';
// import '/screens/splash/splash_screen.dart';
// import 'blocs/simple_bloc_observer.dart';
// import 'config/custom_router.dart';
// import 'config/shared_prefs.dart';
// import 'repositories/agora/agora_repository.dart';
// import 'repositories/auth/auth_repo.dart';
// import 'repositories/profile/profile_repository.dart';
// import 'services/local_notification_service.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print(
//     'background message ${message.data}',
//   );
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await setupFlutterNotifications();
//   //showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           //  add a proper drawable resource to android, for now using
//           //      one that already exists in example app.
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
// }

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   await SharedPrefs().init();
//   EquatableConfig.stringify = kDebugMode;
//   Bloc.observer = SimpleBlocObserver();

//   runApp(const MyApp());
//   // runApp(
//   //   const MaterialApp(
//   //     debugShowCheckedModeBanner: false,
//   //     home: AgoraVoiceCall(),
//   //   ),
//   // );
//   // runApp(
//   //   MaterialApp(
//   //     debugShowCheckedModeBanner: false,
//   //     home: CallInterfaceDesign(
//   //       onTapCall: () {},
//   //       isCalling: true,
//   //       duration: 3,
//   //     ),
//   //   ),
//   // );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //SharedPrefs().deleteEverything();
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(

//           /// systemNavigationBarColor: Colors.blue, // navigation bar color
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark // status bar color
//           ),
//     );
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider<AuthRepository>(
//           create: (_) => AuthRepository(),
//         ),
//         RepositoryProvider<ProfileRepository>(
//           create: (_) => ProfileRepository(),
//         ),
//         RepositoryProvider<TwinsRepository>(
//           create: (_) => TwinsRepository(),
//         ),
//         RepositoryProvider<NotificationRepository>(
//           create: (_) => NotificationRepository(),
//         ),
//         RepositoryProvider<ChatRepository>(
//           create: (_) => ChatRepository(),
//         ),
//         RepositoryProvider<AstroRepository>(
//           create: (_) => AstroRepository(),
//         ),
//         RepositoryProvider<AgoraRepository>(
//           create: (_) => AgoraRepository(),
//         ),
//         RepositoryProvider<LocalNotificationService>(
//           create: (_) => LocalNotificationService(),
//         ),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<AuthBloc>(
//             create: (context) => AuthBloc(
//                 authRepository: context.read<AuthRepository>(),
//                 profileRepository: context.read<ProfileRepository>()),
//           ),
//           BlocProvider<ConnectCubit>(
//             create: (context) => ConnectCubit(
//                 twinsRepository: context.read<TwinsRepository>(),
//                 authBloc: context.read<AuthBloc>(),
//                 astroRepository: context.read<AstroRepository>()),
//           ),
//           // BlocProvider<NotificationsCubit>(
//           //   create: (context) => NotificationsCubit(
//           //     notificationRepository: context.read<NotificationRepository>(),
//           //     authBloc: context.read<AuthBloc>(),
//           //   ),
//           // ),
//         ],
//         child: MaterialApp(
//           //showPerformanceOverlay: true,
//           theme: ThemeData(
//             primaryColor: const Color(0xffED462F),
//             // CUSTOMIZE showDatePicker Colors
//             colorScheme: const ColorScheme.light(primary: Color(0xffED462F)),
//             buttonTheme:
//                 const ButtonThemeData(textTheme: ButtonTextTheme.primary),

//             fontFamily: 'GoogleSans',

//             // scaffoldBackgroundColor: const Color(0xffED462F),
//           ),
//           debugShowCheckedModeBanner: false,
//           //  home: const SplashScreen3(),

//           //  const ShowUp(
//           //   child: Scaffold(
//           //     body: Center(
//           //       child: Text('I am good'),
//           //     ),
//           //   ),
//           //   delay: 10,
//           // ),
//           onGenerateRoute: CustomRouter.onGenerateRoute,
//           initialRoute: SplashScreen.routeName,

//           // (SharedPrefs().birthDetails?.birthDate == null)
//           //     ? SearchTwinsScreen.routeName
//           //     : AuthWrapper.routeName
//           //AutphWrapper.routeName,

//           // debugShowCheckedModeBanner: false,
//           // title: 'Flutter Demo',
//           // theme: ThemeData(
//           //   scaffoldBackgroundColor: Colors.white,
//           //   primarySwatch: Colors.blue,
//           //   fontFamily: 'GoogleSans',
//           // ),
//           // home: const SplashScreen(),
//           //home: const DashBoard(),
//         ),
//       ),
//     );
//   }
// }
