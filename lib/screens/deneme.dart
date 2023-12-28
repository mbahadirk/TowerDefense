import 'package:flutter/material.dart';

class TappingGame extends StatefulWidget {
  @override
  _TappingGameState createState() => _TappingGameState();
}

class _TappingGameState extends State<TappingGame> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tıklama Sayacı Oyunu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Back button pressed
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tıklama Sayısı:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$_counter',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Artır',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
