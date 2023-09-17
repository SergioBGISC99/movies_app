import '../entities/actor.dart';

abstract class CastRepository {
  Future<List<Actor>> getCastByMovie(String movieId);
}
