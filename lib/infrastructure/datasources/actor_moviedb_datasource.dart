import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/cast_datasource.dart';
import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/infrastructure/mappers/cast_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends CastDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDBkey,
        'language': 'es-MX'
      }));

  List<Actor> _jsonToActor(Map<String, dynamic> json) {
    final castResponse = CreditsResponse.fromJson(json);

    final List<Actor> lstCast =
        castResponse.cast.map((cast) => CastMapper.castToEntity(cast)).toList();
    return lstCast;
  }

  @override
  Future<List<Actor>> getCastByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    return _jsonToActor(response.data);
  }
}
