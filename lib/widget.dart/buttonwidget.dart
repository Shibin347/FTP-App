import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff7ac4a8),
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
          
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Color(0xff1b2842)),
          ),
        ],
      );
}
