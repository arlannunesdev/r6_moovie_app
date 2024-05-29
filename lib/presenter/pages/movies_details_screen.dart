import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r6_moovie_app/resources/app_strings.dart';
import 'package:r6_moovie_app/utils/utils.dart';

import '../../domain/entities/movie.dart';
import '../bloc/favorites/favorite_bloc.dart';
import '../bloc/favorites/favorite_state.dart';
import '../widgets/details/info_row.dart';
import '../widgets/details/media_detail_header.dart';
import '../widgets/details/overview.dart';
import '../widgets/details/text_list.dart';
import '../widgets/home/favorite_toggle_button.dart';
import 'favorites_screen.dart';

class MovieDetailsScreen extends StatelessWidget {
  final dynamic item;

  const MovieDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Movie movie = item;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.details),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          bool isFavorite = false;
          if (state is FavoritesLoadedState) {
            isFavorite = state.favoriteMovieIds.any((m) => m.id == movie.id);
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MediaDetailHeader(
                    media: movie,
                    height: 250,
                    action: FavoriteToggleButton(movie: movie),
                  ),
                ),
                InfoRow(
                  releaseDate: Utils.formatDateString(movie.releaseDate),
                  vote: movie.voteCount.toString(),
                  popularity: movie.popularity.toString(),
                ),
                const SizedBox(height: 10),
                const TextList(items: [
                  AppStrings.aboutMovie,
                  AppStrings.reviews,
                  AppStrings.cast
                ]),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OverView(movie.overview),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
