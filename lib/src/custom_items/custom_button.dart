import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;

  const CustomButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black), // Apply contrast color to the icon
      label: Text(
        label,
        style: const TextStyle(color: Colors.black), // Apply contrast color to the text
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 20), // Increased vertical padding
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: const Size(400, 70),
        maximumSize: const Size(2000, 70),
      ),
    );
  }
}