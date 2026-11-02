import 'package:flutter/material.dart';

import '../models/hurdle_words.dart';

class WordleView extends StatelessWidget {
  final HurdleWords hurdleWords;
  const WordleView({super.key, required this.hurdleWords});

  @override
  Widget build(BuildContext context) {
    final bool isDone = hurdleWords.done;
    final bool isNoDone = hurdleWords.nodone;
    final bool hasLetter = hurdleWords.letter.trim().isNotEmpty;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDone
            ? Colors.green.shade600
            : isNoDone
                ? Colors.red.shade700
                : (hasLetter ? const Color(0xFF2E2E3E) : const Color(0xFF1A1A24)),
        border: Border.all(
          color: isDone
              ? Colors.greenAccent
              : isNoDone
                  ? Colors.redAccent.shade100
                  : (hasLetter ? Colors.white70 : Colors.white12),
          width: hasLetter ? 2 : 1.5,
        ),
        boxShadow: hasLetter
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Text(
        hurdleWords.letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
