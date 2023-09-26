import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450)),
      child: GestureDetector(
        onTap: () => context.push('/movie/${movie.id}'),
        child: FadeInImage(
          height: 180,
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
          image: NetworkImage(movie.posterPath),
        ),
      ),
    );
  }
}
