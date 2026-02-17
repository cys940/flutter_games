// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:game/core/di/engine_module.dart' as _i378;
import 'package:game/features/home/data/repositories/mock_home_repository.dart'
    as _i74;
import 'package:game/features/home/domain/repositories/home_repository.dart'
    as _i75;
import 'package:game/features/home/domain/usecases/get_games_usecase.dart'
    as _i801;
import 'package:game/features/home/presentation/game/home_game_engine.dart'
    as _i32;
import 'package:game/features/home/presentation/viewmodels/home_view_model.dart'
    as _i553;
import 'package:game/features/shooter/domain/engine/shooter_engine.dart'
    as _i405;
import 'package:game/features/shooter/presentation/viewmodels/shooter_view_model.dart'
    as _i707;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final engineModule = _$EngineModule();
    gh.factory<_i32.HomeGameEngine>(() => _i32.HomeGameEngine());
    gh.lazySingleton<_i405.ShooterEngine>(() => engineModule.shooterEngine);
    gh.lazySingleton<_i75.HomeRepository>(() => _i74.MockHomeRepository());
    gh.factory<_i801.GetGamesUseCase>(
      () => _i801.GetGamesUseCase(gh<_i75.HomeRepository>()),
    );
    gh.factory<_i707.ShooterViewModel>(
      () => _i707.ShooterViewModel(gh<_i405.ShooterEngine>()),
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
