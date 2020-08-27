import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui.dart';
import 'betukereso.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>(
      create: (context) => AppModel(),
      child: MaterialApp(
        title: '\uD83D\uDCD6 Bet\u0171keres\u0151',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}


