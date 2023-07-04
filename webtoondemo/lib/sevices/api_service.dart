//flutter위젯이나 클래스가 아닌 dart 클래스를 만들어 줄 것.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webtoondemo/models/webtoon_detail.dart';
import 'package:webtoondemo/models/webtoon_episode.dart';
import 'package:webtoondemo/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static const String today = "today";

//데이터 불러오기
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response =
        await http.get(url); // 데이터 받아오는 함수 : get. future 타입 값 return.
    //async programming : 서버가 응답할때까지 프로그램이 기다리도록.
    //get을 실행하고 값이 올때까지 기다리기. (다음줄로 넘어가지 않음)=> get의 output이 중요하므로.
    if (response.statusCode == 200) {
      // print(response.body); //200이 들어오면 console에 print) body는 data가 들어있는 부분.
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // final toon = WebtoonModel.fromJson(webtoon);
        // print(toon.title);
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    } else {
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
