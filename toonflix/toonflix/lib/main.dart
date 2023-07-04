import 'package:flutter/material.dart';
import 'package:toonflix/widgets/Button.dart';
import 'package:toonflix/widgets/currency_card.dart';

void main() {
  runApp(const App()); // class app 실행
} // main

class App extends StatelessWidget {
  const App({super.key});

  //위젯이 됨!!

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
            // 전체 레이아웃

            backgroundColor:
                const Color(0xFF181818), // rgb 방식/ Colors.red 방식도 가능
            body: SingleChildScrollView(
              // 화면 스크롤 할 수 있도록 해주기
              padding:
                  const EdgeInsets.symmetric(horizontal: 40), // 오른쪽에서 40padding
              child: Column(
                // 전체 레이아웃 내부 -> 상하로 정렬 : column 이용.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    // 바뀔 이유가 없고 컴파일 전에 값이 정해지는 값은 const를 써 주는 것이 좋다.
                    //space를 주기 위해 만듬.
                    height: 40,
                  ),
                  Row(
                      //horizontal design
                      mainAxisAlignment: // row의 main : horizontal / column의 main: vertical direction
                          //crossAxis는 main의 반대.
                          MainAxisAlignment.end, //오른쪽 정렬(alignment: end)
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Hey, Selena',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Welcome back',
                              style: TextStyle(
                                color: Colors.white
                                    .withOpacity(0.5), //1 = fully white
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ]),
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Total Balance',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white.withOpacity(0.8),
                      )),
                  const SizedBox(
                    // 글자 사이의 간격 주기 위함
                    height: 5,
                  ),
                  Text('\$5 194 382',
                      style: TextStyle(
                        fontSize: 44,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    // 버튼 만들어주기 위한 Row ( 양 옆에 하나씩 있으므로 )
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // 가운데 padding주고 양 끝 정렬
                    children: [
                      Button(
                          text: 'Transfer',
                          bgColor: Color(0xFFF1B33B),
                          textColor: Colors.black),
                      Button(
                          text: 'Request',
                          bgColor: Color(0xFF1F2123),
                          textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.end, // 행렬값을 잘 맞춰주면서 디자인 조정해야됨
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Wallets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('View All',
                          style: TextStyle(
                            color: Colors.white.withOpacity(
                                0.8), //const를 쓸때는 withOpacity를 쓸 수 없다.
                            fontSize: 18,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CurrencyCard(
                    name: 'Euro',
                    code: 'Eur',
                    amount: '6 428',
                    icon: Icons.euro_rounded,
                    isInverted: false,
                    offsetForCard: 0,
                  ),
                  const CurrencyCard(
                    name: 'Bitcoin',
                    code: 'BTC',
                    amount: '0',
                    icon: Icons.currency_bitcoin_rounded,
                    isInverted: true,
                    offsetForCard: 1,
                  ),
                  const CurrencyCard(
                    name: 'Dollar',
                    code: 'USD',
                    amount: '1 449',
                    icon: Icons.money_outlined,
                    isInverted: false,
                    offsetForCard: 2,
                  ),
                ],
              ),
            )));
    // Material(Google) / Cupertino(ios) : what kind of look
  }
}
