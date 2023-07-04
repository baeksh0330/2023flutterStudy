import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoondemo/models/webtoon_detail.dart';
import 'package:webtoondemo/models/webtoon_episode.dart';
import 'package:webtoondemo/sevices/api_service.dart';

import '../widgets/episode_widget.dart';

//tap 하면 나오는 웹툰 디테일 페이지
class DetailScreen extends StatefulWidget {
  final String id, title, thumb;

  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPref() async {
    prefs = await SharedPreferences
        .getInstance(); // 저장소 내부를 검색해서 string list가 있는지 확인할 것. -> 폰 저장소의 액세스를 얻기
    final likedToons =
        prefs.getStringList('likedToons'); // likeToons라는 리스트가 있는지 확인하고
    if (likedToons != null) {
      //있다면 웹툰의 ID를 가지고 있는지 확인
      if (likedToons.contains(widget.id) == true) {
        // 가지고 있을시 좋아요 true->아이콘 변경
        setState(() {
          isLiked = true;
        });
      }
    } else {
      // 리스트가 없을시 빈 리스트 만들기
      await prefs.setStringList('likedToons', []); //리스트 없으면 만들기
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon =
        ApiService.getToonById(widget.id); // 그냥 초기화하려고 하면 안됨. initState 이용해줘야함.
    episodes = ApiService.getLatestEpisodeById(widget.id);
    initPref();
  }

// likedToons:[];

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      // 좋아하는 웹툰이었는데 누르면 빼기
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        // 아니라면 추가
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: isLiked
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
          ),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // overflow:화면 밖으로 픽셀 넘치는거 해결
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    // 누르면 중앙으로 이동) 따로 찾아볼 것. 같은 tag가 있으면 중앙으로 이동하는 건가?.+
                    tag: widget.id, //widget = detailscreen을 뜻함
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
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          "User-Agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                  future: webtoon,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                        //aligns the children
                        children: [
                          Text(snapshot.data!.about,
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                              "${snapshot.data!.genre} / ${snapshot.data!.age}",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ); // data중 about
                    }
                    return const Text("...");
                  }),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                  future: episodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (var episode in snapshot.data!)
                            Episode(
                              episode: episode,
                              webtoonId: widget.id,
                            ) // 원래 일괄 처리로 했는데, 눌러서 각자 에피소드로 이동하려면 각자의 버튼을 위젯으로 만들어줘야함
                          // 시즌n nn화가 리스트로 뜸(10개만 뜬댓는데 난 왜 엄청 뜨냐)
                        ],
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
