import 'package:flutter/material.dart';

class Keys extends StatelessWidget {
  final String letter;
  final bool excluded;
  final Function(String) onPress;

  const Keys({
    super.key,
    required this.letter,
    required this.excluded,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: excluded
                ? const Color(0xFF22222D)
                : const Color(0xFF3E3E50),
            foregroundColor: excluded ? Colors.white24 : Colors.white,
            elevation: excluded ? 0 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 44),
          ),
          onPressed: excluded ? null : () => onPress(letter),
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
