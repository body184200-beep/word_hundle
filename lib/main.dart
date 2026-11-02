import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hundle/view/word_hundle.dart';

import 'controller/provide_hundle.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProvideHundle(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const WordHundle(),
    );
  }
}
