import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tdbd_trans_berjaya_khatulistiwa/models/detail_movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/url.dart';

class DetailFetch {
  Future<DetailFilmModel> getDetailMovie(String movieId) async {
    try {
      final res = await http.get(
        Uri.parse('${Url().val}movie/$movieId${Url().apiKey}'),
      );
      return DetailFilmModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
