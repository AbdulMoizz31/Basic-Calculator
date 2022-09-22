import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Color colour;
  final Color labelColor;
  final VoidCallback whenPressed;

  const MyButton(
      {super.key,
      required this.label,
      required this.colour,
      required this.labelColor,
      required this.whenPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colour,
          ),
          onPressed: whenPressed,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: labelColor,
            ),
          ),
        ),
      ),
    );
  }
}
