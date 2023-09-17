import '../entities/cast.dart';

abstract class CastRepository {
  Future<List<Actor>> getCastByMovie(String movieId);
}
