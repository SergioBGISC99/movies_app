import '../entities/cast.dart';

abstract class CastRepository {
  Future<List<Cast>> getCastByMovie(String movieId);
}
