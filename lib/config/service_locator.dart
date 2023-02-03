import 'package:get_it/get_it.dart';

import '/blocs/auth/auth_bloc.dart';
import '/repositories/auth/auth_repo.dart';
import '/repositories/profile/profile_repository.dart';
import '/screens/nav/bloc/nav_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // repositories
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => ProfileRepository());

  // blocs
  locator.registerFactory(
    () => AuthBloc(
      authRepository: locator(),
      profileRepository: locator(),
    ),
  );

  locator.registerFactory(
    () => NavBloc(
      authBloc: locator(),
      profileRepository: locator(),
    ),
  );

  //TODO: check for this

  // locator.registerFactory(
  //   () => LoginCubit(
  //     authRepository: locator(),
  //     authBloc: locator<AuthBloc>()
  //   ),
  // );
}
