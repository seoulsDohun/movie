import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/models/coming_soon_movie_model.dart';
import 'package:movie/models/detail_movie_model.dart';
import 'package:movie/models/now_play_movie_model.dart';
import 'package:movie/models/popular_movie_model.dart';

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';
  static const String popularUrl = 'popular'; // 인기 영화 리스트
  static const String nowPlayUrl = 'now-playing'; // 현재 상영중 영화 리스트
  static const String comingSoonUrl = 'coming-soon'; // 개봉할 영화 리스트
  static const String detailUrl = 'movie'; // 영화 상세

  /* 인기 영화 리스트 조회 */
  static Future<List<PopularMovieModel>> getPopularMovieList() async {
    final url = Uri.parse('$baseUrl/$popularUrl');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<PopularMovieModel> popularMovieInstances = [];
      var popularMovies = jsonDecode(response.body);
      for (var popularMovie in popularMovies['results']) {
        popularMovieInstances.add(PopularMovieModel.fromJson(popularMovie));
      }
      return popularMovieInstances;
    }
    throw Error();
  }

  /* 상영중 영화 리스트 조회 */
  static Future<List<NowPlayMovieModel>> getNowPlayMovieList() async {
    final url = Uri.parse('$baseUrl/$nowPlayUrl');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<NowPlayMovieModel> nowPlayMovieInstances = [];
      var nowPlayMovies = jsonDecode(response.body);

      for (var nowPlayMovie in nowPlayMovies['results']) {
        nowPlayMovieInstances.add(NowPlayMovieModel.fromJson(nowPlayMovie));
      }
      return nowPlayMovieInstances;
    }
    throw Error();
  }

  /* 개봉할 영화 리스트 조회 */
  static Future<List<ComingSoonModel>> getComingSoonMovieList() async {
    final url = Uri.parse('$baseUrl/$comingSoonUrl');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<ComingSoonModel> comingSoonMovieInstances = [];
      var comingSoonMovies = jsonDecode(response.body);

      for (var comingSoonMovie in comingSoonMovies['results']) {
        comingSoonMovieInstances.add(ComingSoonModel.fromJson(comingSoonMovie));
      }
      return comingSoonMovieInstances;
    }
    throw Error();
  }

  /* 영화 상세 조회 */
  static Future<DetailMovieModel> getDetailMovie(String id) async {
    final url = Uri.parse('$baseUrl/$detailUrl?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var detailMovieData = jsonDecode(response.body);
      return DetailMovieModel.fromJson(detailMovieData);
    }
    throw Error();
  }
}
