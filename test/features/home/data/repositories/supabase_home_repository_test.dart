import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:game/features/home/data/repositories/supabase_home_repository.dart';

import 'supabase_home_repository_test.mocks.dart';

@GenerateMocks([SupabaseClient, GoTrueClient, SupabaseQueryBuilder, PostgrestFilterBuilder<List<Map<String, dynamic>>>, PostgrestTransformBuilder<Map<String, dynamic>?>])
void main() {
  late SupabaseHomeRepository repository;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;
  late MockPostgrestFilterBuilder<List<Map<String, dynamic>>> mockPostgrestFilterBuilder;
  late MockPostgrestTransformBuilder<Map<String, dynamic>> mockPostgrestTransformBuilder;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder<List<Map<String, dynamic>>>();
    mockPostgrestTransformBuilder = MockPostgrestTransformBuilder<Map<String, dynamic>>();
    
    when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);

    when(mockSupabaseQueryBuilder.select(any)).thenReturn(mockPostgrestFilterBuilder as PostgrestFilterBuilder<List<Map<String, dynamic>>>);
    when(mockPostgrestFilterBuilder.eq(any, any)).thenReturn(mockPostgrestFilterBuilder);
    when(mockPostgrestFilterBuilder.order(any, ascending: anyNamed('ascending'))).thenReturn(mockPostgrestFilterBuilder);
    when(mockPostgrestFilterBuilder.limit(any)).thenReturn(mockPostgrestFilterBuilder);
    when(mockPostgrestFilterBuilder.single()).thenReturn(mockPostgrestTransformBuilder as PostgrestTransformBuilder<Map<String, dynamic>>);

    when(mockSupabaseQueryBuilder.insert(any)).thenReturn(mockPostgrestTransformBuilder);
    
    repository = SupabaseHomeRepository(mockSupabaseClient);
  });

  group('SupabaseHomeRepository', () {
    const tGameId = '123';
    const tScore = 100;
    const tUserId = 'user123';

    test('should save score successfully when user is authenticated', () async {
      when(mockGoTrueClient.currentUser).thenReturn(User(
        id: tUserId,
        aud: 'authenticated',
        email: 'test@test.com',
        createdAt: DateTime.now().toIso8601String(),
        appMetadata: {},
        userMetadata: {},
      ));
      
      when(mockPostgrestTransformBuilder.then(any)).thenAnswer((realInvocation) {
        final callback = realInvocation.positionalArguments[0] as FutureOr<void> Function(dynamic);
        return Future.value(callback(null));
      });

      await repository.saveScore(gameId: tGameId, score: tScore);
      verify(mockSupabaseClient.from('scores')).called(1);
    });

    test('should throw exception when saving score if user is not authenticated', () async {
      when(mockGoTrueClient.currentUser).thenReturn(null);
      expect(() => repository.saveScore(gameId: tGameId, score: tScore), throwsException);
    });

    test('should fetch high scores successfully', () async {
      final List<Map<String, dynamic>> tHighScores = [
        {'score': 150, 'user_id': 'user456'},
        {'score': 100, 'user_id': 'user123'},
      ];
      
      when(mockPostgrestFilterBuilder.then(any)).thenAnswer((realInvocation) {
        final callback = realInvocation.positionalArguments[0] as FutureOr<List<Map<String, dynamic>>> Function(List<Map<String, dynamic>>);
        return Future.value(callback(tHighScores));
      });

      final result = await repository.fetchHighScores(gameId: tGameId);
      expect(result, tHighScores);
    });

    test('should return empty list if no high scores found', () async {
      when(mockPostgrestFilterBuilder.then(any)).thenAnswer((realInvocation) {
        final callback = realInvocation.positionalArguments[0] as FutureOr<List<Map<String, dynamic>>> Function(List<Map<String, dynamic>>);
        return Future.value(callback([]));
      });

      final result = await repository.fetchHighScores(gameId: tGameId);
      expect(result, []);
    });

    test('should return list of GameEntity from getGames', () async {
      final List<Map<String, dynamic>> mockResponse = [
        {
          'id': '1',
          'title': 'Test Game 1',
          'description': 'Description 1',
          'thumbnail_path': 'path/to/thumb1.png',
          'game_type': 'shooter',
          'play_count': 10,
          'created_at': '2023-01-01T00:00:00Z',
          'last_played': DateTime.now().toIso8601String(),
        },
      ];

      when(mockSupabaseQueryBuilder.select()).thenReturn(mockPostgrestFilterBuilder as PostgrestFilterBuilder<List<Map<String, dynamic>>>);
      
      when(mockPostgrestFilterBuilder.then(any)).thenAnswer((realInvocation) {
        final callback = realInvocation.positionalArguments[0] as FutureOr<List<Map<String, dynamic>>> Function(List<Map<String, dynamic>>);
        return Future.value(callback(mockResponse));
      });

      final result = await repository.getGames();
      expect(result[0].id, '1');
    });

    test('should return a single GameEntity from getGameById', () async {
      final Map<String, dynamic> mockResponse = {
        'id': '123',
        'title': 'Single Game',
        'description': 'A single game description',
        'thumbnail_path': 'path/to/single_thumb.png',
        'game_type': 'rpg',
        'play_count': 20,
        'created_at': '2023-01-03T00:00:00Z',
        'last_played': DateTime.now().toIso8601String(),
      };

      when(mockPostgrestFilterBuilder.single()).thenReturn(mockPostgrestTransformBuilder as PostgrestTransformBuilder<Map<String, dynamic>>);
      
      when(mockPostgrestTransformBuilder.then(any)).thenAnswer((realInvocation) {
        final callback = realInvocation.positionalArguments[0] as FutureOr<dynamic> Function(Map<String, dynamic>);
        return Future.value(callback(mockResponse));
      });

      final result = await repository.getGameById('123');
      expect(result.id, '123');
    });
  });
}
