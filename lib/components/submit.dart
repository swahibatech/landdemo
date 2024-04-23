import 'package:flutter/material.dart';

class Submit extends StatelessWidget {
  final Function()? onTap;

  const Submit({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 8, 67, 156),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
