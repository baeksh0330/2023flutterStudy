import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;
  final int offsetForCard;

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.offsetForCard,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -offsetForCard * 20),
      child: Container(
        clipBehavior: Clip.hardEdge, // containier 밖으로 내부 아이콘이 빠져나가지 못하도록 하는 기능.
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : const Color(0xFF1F2123),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // text끼리 말고, 내부값끼리 정렬하고 간격 맞출때에는 alignment 쓰기
            // child: 안쓰는 오류 꼭 확인할 것.
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 좌측기준 정렬
                children: [
                  Text(name,
                      style: TextStyle(
                        color: isInverted ? Colors.black : Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? Colors.black : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(code,
                          style: TextStyle(
                            fontSize: 20,
                            color: isInverted ? Colors.black : Colors.white,
                          )),
                    ],
                  )
                ],
              ),
              Transform.scale(
                // 아이콘만 크기 키우기
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 12), // 아이콘 위치 변경하기.
                  child: Icon(
                    icon,
                    color: isInverted ? Colors.black : Colors.white,
                    size: 98,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
