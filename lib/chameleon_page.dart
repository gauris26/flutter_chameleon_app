import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final kTextStyle = TextStyle(fontSize: 50, shadows: [
  Shadow(
      color: Colors.black.withOpacity(0.3),
      offset: const Offset(15, 15),
      blurRadius: 15),
]);

class ChameleonPage extends StatefulWidget {
  const ChameleonPage({Key? key}) : super(key: key);
  @override
  State<ChameleonPage> createState() => _ChameleonPageState();
}

class _ChameleonPageState extends State<ChameleonPage> {
  Color _color = Colors.transparent;
  late final StreamSubscription _subscription;
  final colorStream = Stream.periodic(const Duration(milliseconds: 1500));

  @override
  void initState() {
    _subscription = colorStream.listen((event) => randomColorChange())..pause();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chameleon App'),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        color: _color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Hey! I'm a ", style: kTextStyle),
                        TextSpan(
                          text:
                              ' ${Theme.of(context).platform.name.toUpperCase()} ',
                          style: kTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            backgroundColor: Colors.white,
                            fontSize: 60,
                          ),
                        ),
                        TextSpan(text: " application", style: kTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_subscription.isPaused) {
                    _subscription.resume();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _subscription.pause(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Pause',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void randomColorChange() {
    setState(() {
      _color = Colors.accents[Random().nextInt(Colors.accents.length)];
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

extension TargetPlatformEx on TargetPlatform {
  String get name =>
      kIsWeb ? "Web" : toString().replaceFirst("TargetPlatform.", "");
}
