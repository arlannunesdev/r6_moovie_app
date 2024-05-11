import 'package:flutter/material.dart';
import 'package:r6_moovie_app/data/models/movies_model.dart';
import 'package:r6_moovie_app/data/models/series_model.dart';
import 'package:r6_moovie_app/presentation/screens/movies_details_screen.dart';
import 'package:r6_moovie_app/presentation/screens/series_details_screen.dart';

class BannerList extends StatelessWidget {
  final List<dynamic>? bannerList;
  final String title;

  const BannerList({
    Key? key,
    required this.bannerList,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200, // Altura dos banners
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bannerList?.length ?? 0,
            itemBuilder: (context, index) {
              final banner = bannerList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeriesDetailsScreen(item: banner),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200, // Altura dos banners
                    width: 400, // Largura dos banners
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${banner.backdropPath}",
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              banner is MoviesModels
                                  ? (banner as MoviesModels).title.toString()
                                  : (banner as SeriesModels).name.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
