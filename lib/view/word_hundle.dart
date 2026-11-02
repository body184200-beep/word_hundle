import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hundle/view/wordle_view.dart';

import '../controller/provide_hundle.dart';
import 'keyboard_view.dart';

class WordHundle extends StatelessWidget {
  const WordHundle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12121A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'WORD HURDLE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
            tooltip: 'Restart Game',
            onPressed: () {
              Provider.of<ProvideHundle>(context, listen: false).init();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<ProvideHundle>(
              builder: (context, provider, child) {
                if (provider.isWin) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      '🎉 أحسنت! إجابة صحيحة!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  );
                } else if (provider.isGameOver) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade700,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'انتهت المحاولات! الكلمة هي:${provider.targetword} ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  );
                }
                return const SizedBox(height: 8);
              },
            ),
            Expanded(
              child: Consumer<ProvideHundle>(
                builder: (context, value, child) => Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 360),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: value.hurdledBoard.length,
                      itemBuilder: (context, index) {
                        final hurdleWords = value.hurdledBoard[index];
                        return WordleView(
                          hurdleWords: hurdleWords,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const KeyboardView(),
          ],
        ),
      ),
    );
  }
}
