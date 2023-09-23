import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  StatefulShellRoute.indexedStack(
      builder: (_, __, navigationShell) =>
          HomeScreen(childView: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                    path: 'movie/:id',
                    name: MovieScreen.name,
                    builder: (_, state) {
                      final movieId = state.pathParameters['id'] ?? 'no-id';
                      return MovieScreen(movieId: movieId);
                    })
              ])
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/categories',
              builder: (context, state) => const CategoriesView())
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView())
        ])
      ])
]);
