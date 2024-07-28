import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:pollapp/data/data_sources/supabase_data_source.dart';
import 'package:pollapp/data/repositories/user_repository_impl.dart';
import 'package:pollapp/domain/use_cases/sign_in_use_case.dart';
import 'package:pollapp/domain/use_cases/sign_up_use_case.dart';
import 'package:pollapp/domain/use_cases/update_user_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Provide the Supabase client
final supabaseClientProvider = riverpod.Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Provide the UserRepository implementation
final userRepositoryProvider = riverpod.Provider<UserRepositoryImpl>((ref) {
  final dataSource = SupabaseDataSource(ref.watch(supabaseClientProvider));
  return UserRepositoryImpl(dataSource);
});

// Provide the SignUpUseCase
final signUpProvider = riverpod.Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(userRepositoryProvider));
});

// Provide the SignInUseCase
final signInProvider = riverpod.Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(userRepositoryProvider));
});

// Provide the UpdateUserUseCase
final updateUserProvider = riverpod.Provider<UpdateUserUseCase>((ref) {
  return UpdateUserUseCase(ref.watch(userRepositoryProvider));
});
