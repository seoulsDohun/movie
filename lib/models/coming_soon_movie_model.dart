class ComingSoonModel {
  final String id, title, thumb;

  ComingSoonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'].toString(),
        thumb = json['backdrop_path'].toString();
}
