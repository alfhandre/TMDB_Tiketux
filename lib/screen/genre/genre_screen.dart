import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/card.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_button.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/empty_state.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/providers/movie_provider.dart';

class GenreScreen extends StatefulWidget {
  final String genre, id;
  const GenreScreen({super.key, required this.id, required this.genre});

  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  int selectedCategory = 0;
  String type = 'movie';

  Map<String, List<MovieModel>> cachedData = {};

  void updateCategory(int category) {
    setState(() {
      selectedCategory = category;
      type = category == 0 ? 'movie' : 'tv';

      Provider.of<MovieProvider>(context, listen: false)
          .fetchMoviesbyGenre(type, widget.id);
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false)
        .fetchMoviesbyGenre(type, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          widget.genre,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 12),
                  CustomChip(
                    text: 'Film',
                    isActive: selectedCategory == 0,
                    onPressed: () => updateCategory(0),
                  ),
                  const SizedBox(width: 12),
                  CustomChip(
                    text: 'Serial TV',
                    isActive: selectedCategory == 1,
                    onPressed: () => updateCategory(1),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Consumer<MovieProvider>(
                builder: (context, movieProvider, child) {
                  List<MovieModel> movies = movieProvider.trendMoviesbyGenre;

                  if (movies.isEmpty) {
                    return const EmptyState(
                      message: 'Sedang tidak ada trend film',
                      widthPicture: 120,
                    );
                  }

                  return Column(
                    children: movies.map((data) {
                      String title =
                          data.title ?? data.name ?? "No Title Available";
                      String description = data.overview.isNotEmpty
                          ? data.overview
                          : "Description not available\n";
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CardTrending(
                          id: '${data.id}',
                          width: 1,
                          backdrop_path: data.backdropPath ?? '',
                          title: title,
                          description: description,
                          score: "${data.voteAverage}",
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
