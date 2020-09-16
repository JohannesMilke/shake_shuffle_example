import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Shuffle Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<String> quotes = [
    'You only live once, but if you do it right, once is enough.',
    'If you want to live a happy life, tie it to a goal, not to people or things.',
    'In order to write about life first you must live it.',
  ];

  String quote = quotes.first;
  ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        final newQuote = (List.of(quotes)
              ..remove(quote)
              ..shuffle())
            .first;

        setState(() {
          this.quote = newQuote;
        });
      },
    );
  }

  @override
  void dispose() {
    detector.stopListening();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(48),
          child: Center(
            child: Text(
              quote,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
