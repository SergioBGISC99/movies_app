import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/actor.dart';
import 'cast_repository_provider.dart';

final castByMovieProvider =
    StateNotifierProvider<CastByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final fecthCastInfo = ref.watch(castRepositoryProvider);
  return CastByMovieNotifier(getCast: fecthCastInfo.getCastByMovie);
});

typedef GetCastCallback = Future<List<Actor>> Function(String movieId);

class CastByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetCastCallback getCast;

  CastByMovieNotifier({required this.getCast}) : super({});

  Future<void> loadCast(String movieId) async {
    if (state[movieId] != null) return;
    final cast = await getCast(movieId);
    state = {...state, movieId: cast};
  }
}
