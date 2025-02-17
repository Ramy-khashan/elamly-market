import 'package:get_it/get_it.dart';
import '../../modules/home/controller/home_cubit.dart';

import '../../modules/explore/controller/explore_cubit.dart';
import 'auth_credential.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit());
  sl.registerLazySingleton<ExploreCubit>(() => ExploreCubit());
  sl.registerSingleton<AuthCredentialClass>(AuthCredentialClass());
}
