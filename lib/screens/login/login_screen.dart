import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '/constants/constants.dart';
import '/screens/login/cubit/login_cubit.dart';
import '/screens/reset-password/reset_password.dart';
import '/widgets/custom_textfield.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/show_snakbar.dart';
import '/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                  maxHeight: 600.0,
                ),
                child: const LoginForm(),
              ),
            ),
          )
        : const Scaffold(
            body: LoginForm(),
          );

    // LayoutBuilder(
    //   builder: (context, constraints) {
    //     if (constraints.maxWidth > 768) {
    //       return Align(
    //         alignment: Alignment.center,
    //         child: ConstrainedBox(
    //           constraints: const BoxConstraints(maxWidth: 600),
    //           child: const LoginForm(),
    //         ),
    //       );
    //     }

    //     return const LoginForm();
    //   },
    // );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().loginEmail();
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.error) {
            ShowSnackBar.showSnackBar(
              context,
              title: state.failure.message,
              backgroundColor: Colors.red,
            );
          }
          if (state.status == LoginStatus.succuss) {
            ShowSnackBar.showSnackBar(
              context,
              title: 'Login Successful',
              backgroundColor: Colors.green,
            );
            context.pushNamed(RoutePaths.home);
            //Navigator.of(context).pushReplacementNamed(NavScreen.routeName);
          }
        },
        builder: (context, state) {
          if (state.status == LoginStatus.submitting) {
            return const LoadingIndicator();
          }
          return Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height * 0.35,
                      //height: 250.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          // stops: [0.1, 0.5, 0.7, 0.9],
                          stops: [0.1, 0.3],
                          colors: [
                            Color(0xffF28931),
                            Color(0xffED462F),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 60.0,
                  left: 2.0,
                  right: 2.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/twins.svg',
                        height: 27.0,
                        width: 27.0,
                      ),
                      const SizedBox(width: 10.0),
                      const Text(
                        'AstroTwins',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                ),
                Positioned(
                  top: 140.0,
                  left: 10.0,
                  right: 10.0,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: size.height * 0.65,
                        child: ListView(
                          children: [
                            const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            const Text('Email'),
                            const SizedBox(height: 5.0),
                            CustomTextField(
                              initialValue: state.email,
                              onChanged:
                                  context.read<LoginCubit>().emailChanged,
                              hintText: 'Enter email',
                              validator: (value) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!);

                                if (emailValid) {
                                  return null;
                                }
                                return 'Invalid Email';
                              },
                              inputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20.0),
                            const Text('Password'),
                            const SizedBox(height: 5.0),
                            CustomTextField(
                              maxLines: 1,
                              suffixIcon: IconButton(
                                color: Colors.grey.shade400,
                                icon: Icon(
                                  state.showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () => context
                                    .read<LoginCubit>()
                                    .showPassword(state.showPassword),
                              ),
                              onChanged:
                                  context.read<LoginCubit>().passwordChanged,
                              hintText: 'Password',
                              validator: (value) {
                                if (value!.length < 6) {
                                  return 'Please check password';
                                }
                                return null;
                                //return _checkPassword(value!);

                                // if (value!.length < 6) {
                                //   return 'Password too short';
                                // }
                                // return null;
                              },
                              inputType: TextInputType.visiblePassword,
                              isPassowrdField: !state.showPassword,
                            ),
                            const SizedBox(height: 15.0),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                  ResetPassword.routeName,
                                  arguments: ResetPasswordArgs(
                                    email: state.email,
                                    isEnabled: true,
                                  ),
                                ),
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.0,
                                    color: Contants.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: size.height * 0.08),
                            const SizedBox(height: 35.0),
                            SizedBox(
                              height: 42.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffDC402B),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                onPressed: () => _submitForm(context,
                                    state.status == LoginStatus.submitting),
                                child: const Text('Login'),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            const Center(child: Text('or')),
                            TextButton(
                              onPressed: () =>
                                  context.pushNamed(RoutePaths.register),
                              child: const Text(
                                'Don\'t have account, Register',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Contants.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:superhero_rendezvous/widgets/google_btn.dart';

// import '/blocs/auth/auth_bloc.dart';
// import '/repositories/auth/auth_repo.dart';
// import 'cubit/login_cubit.dart';

// class LoginScreen extends StatelessWidget {
//   static const String routeName = '/login';
//   const LoginScreen({Key? key}) : super(key: key);

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (_) => BlocProvider<LoginCubit>(
//         create: (context) => LoginCubit(
//           authRepository: context.read<AuthRepository>(),
//           authBloc: context.read<AuthBloc>(),
//         ),
//         child: const LoginScreen(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.network(
//             'https://mcdn.wallpapersafari.com/medium/24/2/YMylse.jpg',
//             fit: BoxFit.cover,
//           ),
//           Container(
//             color: Colors.black.withOpacity(0.4),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 22.0,
//                 vertical: 32.0,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Center(
//                     child: Text(
//                       'Join Us Now',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   const Center(
//                     child: Text(
//                       'Find your Superhero Rendezvous',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14.0,

//                         // fontSize: 18.0,
//                         // fontWeight: FontWeight.w500,
//                         // letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20.0),
//                   SizedBox(
//                     width: 348.0,
//                     child: SignInWithAppleButton(
//                       onPressed: () {},
//                       style: SignInWithAppleButtonStyle.white,
//                     ),
//                   ),
//                   const SizedBox(height: 20.0),
//                   GoogleSignInButton(
//                     onPressed: () {},
//                     title: 'Sign in with Google',
//                   ),
//                   const SizedBox(height: 20.0),
//                   SizedBox(
//                     height: 44.0,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: const Text(
//                         'Sign Up with Email',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20.0),

//                   ///const Text(
//                   //   'By signing up, you agree to our Terms of Service and Privacy Policy',
//                   //   style: TextStyle(
//                   //     color: Colors.white70,
//                   //   ),
//                   // ),
//                   // const SizedBox(height: 20.0),
//                   const Center(
//                     child: Text(
//                       'Already have an account? Sign In',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




