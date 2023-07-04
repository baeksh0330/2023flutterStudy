import 'package:flutter/material.dart';
import 'package:webtoondemo/models/webtoon_model.dart';
import 'package:webtoondemo/sevices/api_service.dart';
import 'package:webtoondemo/widgets/webtoon_widgets.dart';

class HomeScreen extends StatelessWidget {
  // 변할 수 있는 UI와 데이터를 위한 stateful widget
  HomeScreen({super.key}); // future넣었으니까 const 쓸 수 없음

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        // statefulwidget을 쓰지 않아도 괜찮게 해줌
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          } //변화)data = 데이터 받음 /error= 데이터 없어서 오류남
          return const Center(
            child: CircularProgressIndicator(), //동그랗게 빙글빙글 돌아가는 로딩상태
          );
        },
      ), //builder : UI를 그려주는 함수
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      // 쓸 게 많을때 스크롤뷰 구현해주는 것. builder를 쓰면 더 많은 데이터를 컨트롤 가능.
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length, // data가 확실히 존재함을 앎
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        // print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) =>
          const SizedBox(width: 40), // 타이틀 사이에 띄어쓰기
    );
  }
}
