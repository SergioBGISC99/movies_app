import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(castByMovieProvider.notifier).loadCast(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
        )),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Titulo, Overview y Rating
        _TitleAndOverview(movie: movie, size: size, textStyles: textStyles),
        //*Generos de la película
        _Genres(movie: movie),
        //*Actores de la película
        CastByMovie(movieId: movie.id.toString()),
        //*Videos de la película (si tiene)
        VideosFromMovie(movieId: movie.id),
        //*Películas similares
        SimilarMovies(movieId: movie.id)
      ],
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...movie.genreIds.map((g) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                      label: Text(g),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ))
          ],
        ),
      ),
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyles,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MoviePoster(movie: movie, size: size),
          const SizedBox(width: 10),
          SizedBox(
              width: (size.width - 40) * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MovieTtile(movie: movie, textStyles: textStyles),
                  _MovieOverview(movie: movie),
                  const SizedBox(height: 10),
                  MovieRating(voteAverage: movie.voteAverage),
                  _MovieReleaseDate(movie: movie)
                ],
              ))
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    required this.movie,
    required this.size,
  });

  final Movie movie;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        movie.posterPath,
        width: size.width * .3,
      ),
    );
  }
}

class _MovieReleaseDate extends StatelessWidget {
  const _MovieReleaseDate({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Estreno', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 5),
        Text(HumanFormats.shortDate(movie.releaseDate))
      ],
    );
  }
}

class _MovieOverview extends StatelessWidget {
  const _MovieOverview({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.overview,
      textAlign: TextAlign.justify,
    );
  }
}

class _MovieTtile extends StatelessWidget {
  const _MovieTtile({
    required this.movie,
    required this.textStyles,
  });

  final Movie movie;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.title,
      style: textStyles.titleLarge,
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * .7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () async {
              await ref
                  .read(favoritesMoviesProvider.notifier)
                  .toggleFavorites(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
                data: (data) => data
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border_rounded),
                error: (_, __) => throw UnimplementedError(),
                loading: () => const CircularProgressIndicator(strokeWidth: 2)))
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0),
        title: _CustomSizedBox(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.7, 1.0],
          colors: [Colors.transparent, scaffoldBackgroundColor],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomSizedBox(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.2],
                colors: [Colors.black54, Colors.transparent]),
            const _CustomSizedBox(
                begin: Alignment.topRight,
                stops: [0.0, 0.3],
                colors: [Colors.black87, Colors.transparent]),
          ],
        ),
      ),
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomSizedBox(
      {required this.begin,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
