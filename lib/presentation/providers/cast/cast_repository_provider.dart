import 'package:cinemapedia/infrastructure/repositories/cast_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/actor_moviedb_datasource.dart';

final castRepositoryProvider = Provider((ref) {
  return CastRepositoryImpl(ActorMoviedbDatasource());
});
