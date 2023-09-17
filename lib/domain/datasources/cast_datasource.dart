import '../entities/actor.dart';

abstract class CastDatasource {
  Future<List<Actor>> getCastByMovie(String movieId);
}
