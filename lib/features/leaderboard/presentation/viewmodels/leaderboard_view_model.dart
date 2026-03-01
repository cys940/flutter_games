import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/entities/score_entity.dart';
import '../../domain/repositories/leaderboard_repository.dart';

@injectable
class LeaderboardViewModel {
  LeaderboardViewModel(this._repository);
  final LeaderboardRepository _repository;

  final scores = signal<List<ScoreEntity>>([]);
  final myScores = signal<List<ScoreEntity>>([]);
  final isLoading = signal<bool>(false);
  final selectedGame = signal<String>('all');
  final errorMessage = signal<String?>(null);

  static const games = ['all', 'shooter', 'puzzle'];
  static const gameLabels = {'all': '전체', 'shooter': '슈터', 'puzzle': '퍼즐'};

  Future<void> loadLeaderboard() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final gameId = selectedGame.value == 'all' ? null : selectedGame.value;
      scores.value = await _repository.getTopScores(gameId: gameId);
    } catch (e) {
      errorMessage.value = '리더보드를 불러오지 못했습니다.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMyScores(String userId) async {
    try {
      myScores.value = await _repository.getMyScores(userId);
    } catch (_) {}
  }

  Future<void> selectGame(String gameId) async {
    selectedGame.value = gameId;
    await loadLeaderboard();
  }

  int getMyRank(String userId) {
    final idx = scores.value.indexWhere((s) => s.userId == userId);
    return idx == -1 ? -1 : idx + 1;
  }
}
