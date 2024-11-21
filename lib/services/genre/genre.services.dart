import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tdbd_trans_berjaya_khatulistiwa/models/genre_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/url.dart';

class GenreService {
  Future<List<GenreModel>> getGenre() async {
    try {
      final res = await http.get(
        Uri.parse('${Url().val}genre/movie/list${Url().apiKey}'),
      );

      final data = jsonDecode(res.body);
      List genresJson = data['genres'];
      return genresJson
          .map((genreJson) => GenreModel.fromJson(genreJson))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

// https://api.themoviedb.org/3/discover/movie?api_key=b8adc3ae75d187ff008c07b922db96b3&with_genres=27
  Future<List<MovieModel>> getMovieByGenre(String type, String id) async {
    try {
      final res = await http.get(
        Uri.parse('${Url().val}discover/$type${Url().apiKey}&with_genres=$id'),
      );

      final List<dynamic> data = json.decode(res.body)['results'];
      print('${Url().val}discover/$type${Url().apiKey}&with_genres=$id');
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
