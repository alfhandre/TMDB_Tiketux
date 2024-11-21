import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/empty_state.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/error_state.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/loading.dart';

class MovieListWidget extends StatelessWidget {
  final String message;
  final Future<List<MovieModel>> futureMovies;
  final Widget Function(MovieModel) buildCard;
  final int itemLimit;

  const MovieListWidget({
    required this.futureMovies,
    required this.buildCard,
    required this.message,
    this.itemLimit = 5,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: futureMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressCustom();
        } else if (snapshot.hasError) {
          return const ErrorState();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return EmptyState(
            message: message,
            widthPicture: 120,
          );
        } else {
          List<MovieModel> movies = snapshot.data!.take(itemLimit).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: defaultMargin),
                ...movies.map((data) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: buildCard(data),
                    )),
              ],
            ),
          );
        }
      },
    );
  }
}
