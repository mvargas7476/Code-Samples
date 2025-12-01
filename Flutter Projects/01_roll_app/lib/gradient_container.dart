import 'package:flutter/material.dart';
import 'package:roll_app/dice_roller.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.colors});
  // This is another constructor that feaults the color as needed
  const GradientContainer.purple({super.key}) : colors = const [Colors.purple, Colors.indigo];

  final List<Color> colors;
  
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: DiceRoller(), 
      ),
    );
  }
}