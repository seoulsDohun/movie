class ComingSoonModel {
  final String id, title, thumb, posterThumb;

  ComingSoonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'].toString(),
        thumb = json['backdrop_path'].toString(),
        posterThumb = json['poster_path'].toString();
}
