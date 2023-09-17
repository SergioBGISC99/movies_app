import '../../domain/datasources/cast_datasource.dart';
import '../../domain/entities/actor.dart';
import '../../domain/repositories/cast_repository.dart';

class CastRepositoryImpl extends CastRepository {
  final CastDatasource datasource;

  CastRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getCastByMovie(String movieId) {
    return datasource.getCastByMovie(movieId);
  }
}
