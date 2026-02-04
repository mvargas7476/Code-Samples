import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.textToDisplay, {super.key});

  final String textToDisplay;

  @override
  Widget build(context) {
    return Text(
      textToDisplay,
      style: const TextStyle(
        color: Colors.deepPurple, 
        fontSize: 28
      ),
    );
  }
}
