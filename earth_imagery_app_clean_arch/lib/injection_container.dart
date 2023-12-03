import 'package:earth_imagery_app_clean_arch/features/auth/data/datasources/local_datasources/auth_local_datasource.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/domain/usecases/login_usecase.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final GetIt locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => AuthBloc(authRepository: locator()));

  //usecases
  locator.registerLazySingleton<LoginUsecase>(() => LoginUsecase());

  //Datasources
  locator.registerLazySingleton(
      () => AuthLocalDataSource(Hive.box<AuthModel>('users')));

  //Repositories
  locator.registerLazySingleton(() => AuthRepositoryImpl(
      authLocalDataSource: locator<AuthLocalDataSource>(),
      loginUsecase: locator<LoginUsecase>()));
}
