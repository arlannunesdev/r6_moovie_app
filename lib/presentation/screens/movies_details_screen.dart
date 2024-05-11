import 'package:flutter/material.dart';
import '../../data/models/movies_model.dart';
import '../components/details/movie_detail_header.dart';
import '../components/details/overview..dart';

class MovieDetailsScreen extends StatelessWidget {
  final dynamic item;

  const MovieDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final MoviesModels movie = item;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_sharp),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: MovieDetailHeader(movie: movie,  height: 60),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(Icons.date_range, movie.releaseDate.toString()),
                      ),
                      _buildDivider(),
                      Expanded(
                        child: _buildInfoItem(Icons.access_time, '120 min'),
                      ),
                      _buildDivider(),
                      Expanded(
                        child: _buildInfoItem(Icons.category, movie.genreIds.toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("About Movie"),
                  Text("Review"),
                  Text("Cast"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OverView(movie.overview),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        "|",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}
