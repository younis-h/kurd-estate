
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/reset_password.dart';
import '../../features/auth/domain/usecases/sign_in.dart';
import '../session/session_manager.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Supabase Client
  sl.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  // Session Manager
  sl.registerLazySingleton<SessionManager>(
    () => SessionManager(sl<SupabaseClient>()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<SupabaseClient>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton<SignIn>(
    () => SignIn(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton<ResetPassword>(
    () => ResetPassword(
      sl<AuthRepository>(),
    ),
  );
}
