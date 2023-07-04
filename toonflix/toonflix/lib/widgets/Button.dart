import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  // 재사용하기 위해 위젯 만드는 것
  // 버튼 따로 만들어줌 -> extract widget

  //각자의 버튼이 고유하게 가질 properties
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // request 버튼
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(45), // 버튼 깎기
      ),

      child: Padding(
        // const를 지워줘야 함! (변수를 가져오는 형태이므로 padding이 고정되지 않음)
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Text(text,
            style: TextStyle(
              fontSize: 22,
              color: textColor,
            )),
      ),
    );
  }
}
