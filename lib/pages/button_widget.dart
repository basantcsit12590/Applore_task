import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onClicked;
  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.iconData,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey, minimumSize: Size.fromHeight(50)),
      onPressed: onClicked,
      child: buildContent(iconData, text, onClicked));
}

Widget buildContent(IconData iconData, String text, VoidCallback onClicked) =>
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          size: 28,
        ),
        SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.white),
        )
      ],
    );
