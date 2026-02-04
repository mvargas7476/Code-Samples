import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  // You can add const since there is a separation between widget and it's state
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;
  
  void rollDice() {
    const duration = Duration(milliseconds: 50); // how fast the dice cycles
    int cycles = 10; // how many times to change the face

    Timer.periodic(duration, (timer) {
      setState(() {
        currentDiceRoll = randomizer.nextInt(6) + 1;
      });

      cycles--;
      if (cycles == 0) {
        timer.cancel();
        // set the actual final roll
        setState(() {
          currentDiceRoll = randomizer.nextInt(6) + 1;
        });
      }
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [  
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png', 
          width: 200,
        ),
        const SizedBox(height: 20,),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, 
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text("Roll Dice"))
      ],
    );
  }
}