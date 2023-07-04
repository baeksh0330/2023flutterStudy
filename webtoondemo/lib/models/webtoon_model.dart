class WebtoonModel {
  final String title, thumb, id;

//named Constructor
  WebtoonModel.fromJson(
      Map<String, dynamic> json) // initialize. 냅다 함수 선언하고 다른곳에서 써주는듯.
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
