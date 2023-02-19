// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_auth/features/login/presentation/bloc/login_bloc.dart'
    as _i9;
import 'package:flutter_auth/features/signup/presentation/bloc/signup_bloc.dart'
    as _i10;
import 'package:flutter_auth/features/user/presentation/bloc/user_bloc.dart'
    as _i11;
import 'package:flutter_auth/features/user/providers/user_api.dart' as _i5;
import 'package:flutter_auth/features/user/providers/user_local_storage.dart'
    as _i6;
import 'package:flutter_auth/features/user/repositories/user_repository.dart'
    as _i7;
import 'package:flutter_auth/features/user/repositories/user_repository_impl.dart'
    as _i8;
import 'package:flutter_auth/injection/register_module.dart' as _i12;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Dio>(() => registerModule.client);
    gh.lazySingleton<_i4.FlutterSecureStorage>(() => registerModule.storage);
    gh.lazySingleton<_i5.UserApi>(() => _i5.UserApi(client: gh<_i3.Dio>()));
    gh.lazySingleton<_i6.UserLocalStorage>(
        () => _i6.UserLocalStorage(storage: gh<_i4.FlutterSecureStorage>()));
    gh.lazySingleton<_i7.UserRepository>(
      () => _i8.UserRepositoryImpl(
        api: gh<_i5.UserApi>(),
        storage: gh<_i6.UserLocalStorage>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i9.LoginBloc>(
        () => _i9.LoginBloc(userRepository: gh<_i7.UserRepository>()));
    gh.factory<_i10.SignupBloc>(
        () => _i10.SignupBloc(userRepository: gh<_i7.UserRepository>()));
    gh.factory<_i11.UserBloc>(() => _i11.UserBloc(gh<_i7.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
