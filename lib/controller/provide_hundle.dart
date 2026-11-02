import 'dart:math';

import 'package:english_words/english_words.dart' as words;
import 'package:flutter/material.dart';

import '../models/hurdle_words.dart';

class ProvideHundle extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<HurdleWords> hurdledBoard = [];
  String targetword = '';
  int count = 0;
  int index = 0;
  final letterPerRow = 5;
  final maxAttempts = 6;
  bool isGameOver = false;
  bool isWin = false;

  ProvideHundle() {
    init();
  }

  void init() {
    totalWords = words.all
        .where((element) => element.length == 5)
        .map((e) => e.toUpperCase())
        .toList();
    genrateBoard();
    genrateRandomword();
    rowInputs.clear();
    excludedLetters.clear();
    count = 0;
    index = 0;
    isGameOver = false;
    isWin = false;
    notifyListeners();
  }

  void genrateBoard() {
    hurdledBoard = List.generate(
      letterPerRow * maxAttempts,
      (_) => HurdleWords(letter: ' '),
    );
  }

  void genrateRandomword() {
    if (totalWords.isNotEmpty) {
      targetword = totalWords[random.nextInt(totalWords.length)].toUpperCase();
      print('Target word: $targetword');
    }
  }

  void inputLetter(String letter) {
    if (isGameOver) return;
    if (count < letterPerRow && index < hurdledBoard.length) {
      count++;
      rowInputs.add(letter);
      hurdledBoard[index] = HurdleWords(letter: letter);
      index++;
      notifyListeners();
    }
  }

  void deleteLetter() {
    if (isGameOver) return;
    if (count > 0 && index > 0) {
      count--;
      index--;
      rowInputs.removeLast();
      hurdledBoard[index] = HurdleWords(letter: ' ');
      notifyListeners();
    }
  }

  void checkWord() {
    if (isGameOver) return;
    if (rowInputs.length == letterPerRow) {
      final startIndex = index - letterPerRow;
      int matchCount = 0;

      for (int i = 0; i < letterPerRow; i++) {
        final guessedLetter = rowInputs[i];
        if (targetword[i] == guessedLetter) {
          hurdledBoard[startIndex + i].done = true;
          hurdledBoard[startIndex + i].nodone = false;
          matchCount++;
        } else {
          hurdledBoard[startIndex + i].done = false;
          hurdledBoard[startIndex + i].nodone = true;
          if (!targetword.contains(guessedLetter)) {
            if (!excludedLetters.contains(guessedLetter)) {
              excludedLetters.add(guessedLetter);
            }
          }
        }
      }

      if (matchCount == letterPerRow) {
        isWin = true;
        isGameOver = true;
      } else if (index >= hurdledBoard.length) {
        isGameOver = true;
      }

      rowInputs.clear();
      count = 0;
      notifyListeners();
    }
  }
}
