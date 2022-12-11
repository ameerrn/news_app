import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsContainer extends StatelessWidget {
  DetailsContainer({this.text, super.key});

  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Text(
        text!,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
    );
  }
}
