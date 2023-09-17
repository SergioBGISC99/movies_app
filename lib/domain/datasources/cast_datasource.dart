import '../entities/cast.dart';

abstract class CastDatasource {
  Future<List<Actor>> getCastByMovie(String movieId);
}
