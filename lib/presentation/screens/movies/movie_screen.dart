import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../providers/providers.dart';

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

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * .7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);
          },
          icon: const Icon(Icons.favorite_border_rounded),
          // icon: Icon(
          //   Icons.favorite_rounded,
          //   color: Colors.red,
          // ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.8, 1.0],
                colors: [Colors.transparent, Colors.black54]),
            const _CustomSizedBox(
                begin: Alignment.topRight,
                stops: [0.0, 0.3],
                colors: [Colors.black54, Colors.transparent]),
          ],
        ),
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
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MoviePoster(movie: movie, size: size),
              const SizedBox(width: 10),
              _MovieContent(size: size, movie: movie, textStyles: textStyles)
            ],
          ),
        ),
        //Todo: Generos de la película
        _MoviesGenres(movie: movie),
        //Todo: mostrar actores list view
        _CastByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 50)
      ],
    );
  }
}

class _MoviesGenres extends StatelessWidget {
  const _MoviesGenres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
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
    );
  }
}

class _MovieContent extends StatelessWidget {
  const _MovieContent({
    required this.size,
    required this.movie,
    required this.textStyles,
  });

  final Size size;
  final Movie movie;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: (size.width - 40) * .7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: textStyles.titleLarge,
            ),
            const SizedBox(height: 15),
            Text(
              movie.overview,
              style: textStyles.bodyMedium,
              textAlign: TextAlign.justify,
            )
          ],
        ));
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

class _CastByMovie extends ConsumerWidget {
  final String movieId;

  const _CastByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final castByMovie = ref.watch(castByMovieProvider);

    if (castByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final cast = castByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cast.length,
          itemBuilder: (context, index) {
            final actor = cast[index];
            return FadeInRight(
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Picture
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        width: 135,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(actor.name, maxLines: 2),
                    const SizedBox(height: 5),
                    Text(
                      actor.character ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    )
                    //Nombre
                  ],
                ),
              ),
            );
          }),
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
