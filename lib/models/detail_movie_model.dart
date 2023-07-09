class DetailMovieModel {
  final String title, overview;
  final num voteAverage, runtime;
  final List<dynamic> genres;

  DetailMovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'].toString(),
        overview = json['overview'].toString(),
        voteAverage = json['vote_average'],
        runtime = json['runtime'],
        genres = json['genres'];
}
