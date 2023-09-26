import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class CastByMovie extends ConsumerWidget {
  final String movieId;

  const CastByMovie({super.key, required this.movieId});

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
