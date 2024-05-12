import 'package:flutter/material.dart';
import '../../../../data/models/movies_model.dart';
import '../../../../data/models/series_model.dart';
import 'arch_banner_image.dart';

class MediaDetailHeader<T> extends StatelessWidget {
  const MediaDetailHeader({
    super.key,
    required this.media,
    required this.height,
  });

  final T media;
  final double height;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var title = media is MoviesModels ? (media as MoviesModels).title : (media as SeriesModels).name;
    var backdropPath = media is MoviesModels ? (media as MoviesModels).backdropPath : (media as SeriesModels).backdropPath;

    var mediaInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ArcBannerImage("https://image.tmdb.org/t/p/w500$backdropPath", height: 80),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500$backdropPath",
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(child: mediaInformation),
            ],
          ),
        ),
      ],
    );
  }
}