// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r6_moovie_app/resources/app_strings.dart';
import 'package:r6_moovie_app/utils/utils.dart';
import 'package:r6_moovie_app/presenter/widgets/details/cast.dart';
import 'package:r6_moovie_app/presenter/widgets/details/review.dart';
import '../../domain/entities/movie.dart';
import '../bloc/favorites/favorite_bloc.dart';
import '../bloc/favorites/favorite_state.dart';
import '../widgets/details/info_row.dart';
import '../widgets/details/media_detail_header.dart';
import '../widgets/details/overview.dart';
import '../widgets/home/favorite_toggle_button.dart';
import 'favorites_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  final dynamic item;

  const MovieDetailsScreen({super.key, required this.item});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.item;

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
                MaterialPageRoute(
                    builder: (context) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          bool isFavorite = false;
          if (state is FavoritesLoadedState) {
            isFavorite =
                state.favoriteMovies.any((movie) => movie.id == movie.id);
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
                    action: FavoriteToggleButton(media: movie),
                  ),
                ),
                InfoRow(
                    releaseDate: Utils.formatDateToBrazilian(movie.releaseDate),
                    vote: movie.voteCount.toString(),
                    popularity: movie.popularity.toString()),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                      child: Text(
                        AppStrings.aboutMovie,
                        style: TextStyle(
                          fontSize: 15,
                          decoration: _selectedIndex == 0
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                      child: Text(
                        AppStrings.reviews,
                        style: TextStyle(
                          fontSize: 15,
                          decoration: _selectedIndex == 1
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      },
                      child: Text(
                        AppStrings.cast,
                        style: TextStyle(
                          fontSize: 15,
                          decoration: _selectedIndex == 2
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _selectedIndex == 0
                      ? OverView(movie.overview.isEmpty
                          ? AppStrings.noLanguageMovie
                          : movie.overview)
                      : _selectedIndex == 1
                          ? Review(movie.voteAverage.toString())
                          : Cast(movie.title),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
