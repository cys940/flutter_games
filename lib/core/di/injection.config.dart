// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:game/core/di/engine_module.dart' as _i378;
import 'package:game/core/di/supabase_module.dart' as _i919;
import 'package:game/features/auth/data/repositories/supabase_auth_repository.dart'
    as _i1018;
import 'package:game/features/auth/domain/repositories/auth_repository.dart'
    as _i573;
import 'package:game/features/auth/presentation/viewmodels/login_view_model.dart'
    as _i79;
import 'package:game/features/home/data/repositories/supabase_home_repository.dart'
    as _i682;
import 'package:game/features/home/domain/repositories/home_repository.dart'
    as _i75;
import 'package:game/features/home/domain/usecases/get_games_usecase.dart'
    as _i801;
import 'package:game/features/home/presentation/game/home_game_engine.dart'
    as _i32;
import 'package:game/features/home/presentation/viewmodels/home_view_model.dart'
    as _i553;
import 'package:game/features/leaderboard/data/repositories/supabase_leaderboard_repository.dart'
    as _i826;
import 'package:game/features/leaderboard/domain/repositories/leaderboard_repository.dart'
    as _i964;
import 'package:game/features/leaderboard/presentation/viewmodels/leaderboard_view_model.dart'
    as _i213;
import 'package:game/features/profile/data/repositories/supabase_profile_repository.dart'
    as _i284;
import 'package:game/features/profile/domain/repositories/profile_repository.dart'
    as _i644;
import 'package:game/features/profile/presentation/viewmodels/profile_view_model.dart'
    as _i373;
import 'package:game/features/shooter/domain/engine/shooter_engine.dart'
    as _i405;
import 'package:game/features/shooter/presentation/viewmodels/shooter_view_model.dart'
    as _i707;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final engineModule = _$EngineModule();
    final supabaseModule = _$SupabaseModule();
    gh.factory<_i32.HomeGameEngine>(() => _i32.HomeGameEngine());
    gh.lazySingleton<_i405.ShooterEngine>(() => engineModule.shooterEngine);
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabaseClient);
    gh.lazySingleton<_i644.ProfileRepository>(
      () => _i284.SupabaseProfileRepository(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i573.AuthRepository>(
      () => _i1018.SupabaseAuthRepository(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i964.LeaderboardRepository>(
      () => _i826.SupabaseLeaderboardRepository(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i75.HomeRepository>(
      () => _i682.SupabaseHomeRepository(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i79.LoginViewModel>(
      () => _i79.LoginViewModel(gh<_i573.AuthRepository>()),
    );
    gh.factory<_i373.ProfileViewModel>(
      () => _i373.ProfileViewModel(gh<_i644.ProfileRepository>()),
    );
    gh.factory<_i213.LeaderboardViewModel>(
      () => _i213.LeaderboardViewModel(gh<_i964.LeaderboardRepository>()),
    );
    gh.factory<_i707.ShooterViewModel>(
      () => _i707.ShooterViewModel(gh<_i405.ShooterEngine>()),
    );
    gh.factory<_i801.GetGamesUseCase>(
      () => _i801.GetGamesUseCase(gh<_i75.HomeRepository>()),
    );
    gh.factory<_i553.HomeViewModel>(
      () => _i553.HomeViewModel(
        gh<_i801.GetGamesUseCase>(),
        gh<_i32.HomeGameEngine>(),
      ),
    );
    return this;
  }
}

class _$EngineModule extends _i378.EngineModule {}

class _$SupabaseModule extends _i919.SupabaseModule {}
