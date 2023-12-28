import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tower_defense_game/screens/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ekran yönünü yatay modda sabitle
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'My App',
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // Diğer text stilleri
        ),
        scaffoldBackgroundColor: Colors.grey, // İstediğiniz arkaplan rengini buradan ayarlayabilirsiniz
      ),
      home: Options(),
    );
  }
}

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  double musicVolume = 0.5;
  double sfxVolume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text('Options'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            height: 80.0,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSliderRow('Music', musicVolume, Colors.blue), // Music yazısının rengi mavi
            const SizedBox(height: 10),
            buildSliderRow('SFX', sfxVolume, Colors.green), // SFX yazısının rengi yeşil
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildSaveAndExitButton(),
        ),
      ),
    );
  }

  Widget buildSliderRow(String label, double value, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white), // Yazı rengini belirle
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 400,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              ),
              child: Slider(
                value: value,
                onChanged: (newValue) {
                  setState(() {
                    if (label == 'Music') {
                      musicVolume = newValue;
                    } else if (label == 'SFX') {
                      sfxVolume = newValue;
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSaveAndExitButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainMenu(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: Theme.of(context).textTheme.button,
      ),
      child: const Text('Save and Exit'),
    );
  }
}
