import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget{
  const AnswerButton({super.key, 
    required this.answerText, 
    required this.onTap}
  );

  final String answerText;
  final void Function() onTap;
  
  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 45, 10, 107),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40)
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        )
      ), 
      child: Text(answerText, textAlign: TextAlign.center,),
    );
  }
}