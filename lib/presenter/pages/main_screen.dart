import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r6_moovie_app/resources/app_strings.dart';

import '../bloc/movies/movie_bloc.dart';
import '../bloc/movies/movie_event.dart';
import '../bloc/movies/movie_state.dart';
import '../bloc/series/series_bloc.dart';
import '../bloc/series/series_event.dart';
import '../bloc/series/series_state.dart';
import '../widgets/home/banner_list.dart';
import '../widgets/home/media_list.dart';
import '../widgets/home/search_bar_app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MovieBloc _movieBloc;
  late final SeriesBloc _seriesBloc;

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
  }

  void _initializeBlocs() {
    _movieBloc = BlocProvider.of<MovieBloc>(context);
    _seriesBloc = BlocProvider.of<SeriesBloc>(context);
    _movieBloc.add(LoadingSuccessEvent());
    _seriesBloc.add(LoadingSeriesSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SearchBarApp(),
          BlocBuilder<MovieBloc, MovieState>(
            bloc: _movieBloc,
            builder: (context, movieState) {
              return BlocBuilder<SeriesBloc, SeriesState>(
                bloc: _seriesBloc,
                builder: (context, serieState) {
                  if (movieState is LoadedSuccessState &&
                      serieState is LoadedSeriesSuccessState) {
                    return Column(
                      children: [
                        BannerList(
                          title: AppStrings.populars,
                          bannerList: serieState.series,
                        ),
                        const Padding(padding: EdgeInsets.all(6.0)),
                        MediaList(
                          title: AppStrings.favorites,
                          mediaList: movieState.movies ?? [],
                          movies: const [],
                          series: const [],
                        ),
                        const Padding(padding: EdgeInsets.all(6.0)),
                        MediaList(
                          title: AppStrings.series,
                          mediaList: serieState.series ?? [],
                          movies: const [],
                          series: const [],
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
