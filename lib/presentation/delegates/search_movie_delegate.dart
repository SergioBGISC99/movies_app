import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../config/helpers/human_formats.dart';
import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback movieCallback;

  SearchMovieDelegate({required this.movieCallback});

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(
              onPressed: () => query = '', icon: const Icon(Icons.clear)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: movieCallback(query),
        initialData: const [],
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) =>
                  _MovieSearchItem(movie: movies[index]));
        });
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;

  const _MovieSearchItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: size.width * .2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) =>
                    FadeInDown(child: child),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: size.width * .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textStyles.titleMedium,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  movie.overview,
                  style: textStyles.bodySmall,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star_half_rounded,
                        color: Colors.yellow.shade800),
                    const SizedBox(width: 3),
                    Text(HumanFormats.number(movie.voteAverage),
                        style: textStyles.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade800)),
                    const Spacer(),
                    Text(
                      HumanFormats.number(movie.popularity),
                      style: textStyles.bodySmall,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
