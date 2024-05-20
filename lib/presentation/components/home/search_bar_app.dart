import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:r6_moovie_app/resources/app_colors.dart';
import 'package:r6_moovie_app/data/network/api_client.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});
  
  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  List<Map<String, dynamic>> searchResult = [];
  bool showSearchResults = false;

  Future<void> searchListFunction(String val) async {

    List<Map<String, dynamic>> tempSearchResult = [];
    
    var dio = Dio();
    var apiKey = 'inserir a chave aqui';
    var searchUrl =
        'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$val';
    try {
    var searchResponse = await dio.get(searchUrl);
    print('Response: $searchResponse\n'); 
    if (searchResponse.statusCode == 200) {
      var tempData = searchResponse.data;
      print('Temp Data: $tempData\n'); 
      var searchJson = tempData['results'];
      print('Search JSON: $searchJson\n'); 

      var filteredResults = searchJson.where((result) => result['media_type'] != 'person').toList();

      for (var result in filteredResults) {

          print('ID: ${result['id']}');
          print('Poster Path: ${result['poster_path']}');
          print('Vote Average: ${result['vote_average']}');
          print('Media Type: ${result['media_type']}');

        if (result['id'] != null &&
            result['poster_path'] != null &&
            result['vote_average'] != null &&
            result['media_type'] != null && 
            result['media_type'] != 'person') {
              print('passa aqui');
          setState(() {
            tempSearchResult.add({
              'id': result['id'],
              'poster_path': result['poster_path'],
              'vote_average': result['vote_average'],
              'media_type': result['media_type'],
              'popularity': result['popularity'],
              'overview': result['overview'],
              result.containsKey('title') ? 'title': 'name': result.containsKey('title') ? result['title'] : result['name'],
            });

            if (tempSearchResult.length > 5) {
              tempSearchResult.removeRange(5, tempSearchResult.length);
            }
          });
        } else {
          print('deu ruim');
        }
      }

      setState(() {
      searchResult = List.from(tempSearchResult); 
    });


    }
    } catch (e) {
      print('Error: $e');
    }

      print('Search Result: $searchResult');
  }

  final TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColorLight),
                          borderRadius: BorderRadius.circular(30),
                        ),
                          child: SearchBar(
                            hintText: 'Search',
                            onChanged: (value) {
                              searchListFunction(value);
                            },
                            leading: const Icon(Icons.search,
                            color: AppColors.primaryColorLight),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final result = searchResult[index];
                return ListTile(
                  leading: result['poster_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w92${result['poster_path']}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          width: 100,
                          height: 100,
                        ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.containsKey('title') ? result['title'] : result['name'] ?? '',    
                          
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      
                      Text(
                        'Rating: ${result['vote_average'].toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
