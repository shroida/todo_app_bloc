import 'package:flutter/material.dart';

class FloatingButtonContainer extends StatelessWidget {
  const FloatingButtonContainer({super.key, required this.callbackFunction});
  final void Function(BuildContext context) callbackFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.deepPurple, // Custom color
        borderRadius: BorderRadius.circular(50), // Border radius of 50
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor:
            Colors.transparent, // Set transparent to use container's color
        elevation: 0, // Remove default shadow
        onPressed: () => callbackFunction(context),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white, // Icon color
        ),
      ),
    );
  }
}
