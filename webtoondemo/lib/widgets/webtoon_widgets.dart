import 'package:flutter/material.dart';
import 'package:webtoondemo/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;
  const Webtoon(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 동작 감지
      onTap: () {
        Navigator.push(
          // 애니메이션 효과를 이용해서 다른 페이지로 이동하는 것처럼 보임!!!
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
            fullscreenDialog: true, // 아래에서부터 나오는 애니메이션 효과, 버튼이 >에서 x가 됨
          ),
        ); //route = 애니메이션 효과로 감싸서 스크린처럼 보이게 해주는 그런.. 그냥 detailScreen을 여기 쓸 수는 없음
      }, //user clicks the button
      child: Column(
        children: [
          Hero(
            tag: id, //웹툰 아이디로 태그 달아주기
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15, //그림자가 어디까지 갈지
                      offset: const Offset(10, 15), //(0,0) = 중앙
                      color: Colors.black.withOpacity(1), //그림자 선명.,
                    )
                  ]),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
