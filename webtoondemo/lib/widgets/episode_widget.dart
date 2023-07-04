import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webtoondemo/models/webtoon_episode.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}"); // .을 쓸거면 중괄호 필요. 아니면 필요없음
    await launchUrl(url); // future값 return
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10), // 박스 사이 간격
        decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(episode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  // fontWeight: FontWeight.w600,
                )),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}

//class 옮길때 오류 날 경우, text / url / 등의 변수를 한 글자 지우고 자동완성되도록 하는 식의 재구성을 마치면 오류 사라짐.