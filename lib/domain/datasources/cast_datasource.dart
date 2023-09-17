import '../entities/cast.dart';

abstract class CastDatasource {
  Future<List<Cast>> getCastByMovie(String movieId);
}
