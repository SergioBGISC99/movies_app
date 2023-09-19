import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants/formatters.dart';
import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideShow(movies: slideShowMovies),
            _NowPlaying(nowPlayingMovies: nowPlayingMovies, ref: ref),
            _Upcoming(upcomingMovies: upcomingMovies, ref: ref),
            _Popular(popularMovies: popularMovies, ref: ref),
            _TopRated(topRatedMovies: topRatedMovies, ref: ref),
            const SizedBox(height: 25)
          ],
        );
      }, childCount: 1))
    ]);
  }
}

class _TopRated extends StatelessWidget {
  const _TopRated({
    required this.topRatedMovies,
    required this.ref,
  });

  final List<Movie> topRatedMovies;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return MovieHorizontalListView(
      movies: topRatedMovies,
      title: 'Mejor calificades',
      subtitle: 'Desde siempre',
      loadNextPage: () =>
          ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
    );
  }
}

class _Popular extends StatelessWidget {
  const _Popular({
    required this.popularMovies,
    required this.ref,
  });

  final List<Movie> popularMovies;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return MovieHorizontalListView(
      movies: popularMovies,
      title: 'Populares',
      loadNextPage: () =>
          ref.read(popularMoviesProvider.notifier).loadNextPage(),
    );
  }
}

class _Upcoming extends StatelessWidget {
  const _Upcoming({
    required this.upcomingMovies,
    required this.ref,
  });

  final List<Movie> upcomingMovies;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return MovieHorizontalListView(
      movies: upcomingMovies,
      title: 'Próximamente',
      subtitle: 'Este mes',
      loadNextPage: () =>
          ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
    );
  }
}

class _NowPlaying extends StatelessWidget {
  const _NowPlaying({
    required this.nowPlayingMovies,
    required this.ref,
  });

  final List<Movie> nowPlayingMovies;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return MovieHorizontalListView(
      movies: nowPlayingMovies,
      title: 'En cines',
      subtitle: Formatters.formattedDate,
      loadNextPage: () =>
          ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
    );
  }
}
