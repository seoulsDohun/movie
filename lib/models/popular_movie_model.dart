class PopularMovieModel {
  final String id, title, thumb;

  PopularMovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'].toString(),
        thumb = json['backdrop_path'].toString();
}
