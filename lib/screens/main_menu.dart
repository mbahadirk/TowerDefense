import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/screens/game/tower_defense_game.dart';
import 'background.dart';
import 'market.dart';
import 'options.dart';
import 'characters.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}

class TowerDefenseGameScreen extends StatelessWidget {
  final TowerDefenseGame game;

  const TowerDefenseGameScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}

class MainMenu extends StatelessWidget {
  final ValueNotifier<String> selectedCharacter =
  ValueNotifier<String>('assets/characters/character_Autumn.jpg');
  final ValueNotifier<String> selectedBackground =
  ValueNotifier<String>('backGrounds/background_Default.jpg');


  MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Character(selectedCharacter: selectedCharacter),
          Background(selectedBackground: selectedBackground),

          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Text(
                      'Tower Defense',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 65.0,
                        shadows: const [
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.deepOrange,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 50,
            child: PlayButton(onPressed: () => navigateToGame(context)),
          ),
          Positioned(
            bottom: 100,
            left: 50,
            child: OptionsButton(onPressed: () => navigateToOptions(context)),
          ),
          Positioned(
            top: 200,
            right: 100,
            child: MarketButton(
              selectedBackground: selectedBackground,
              selectedCharacter: selectedCharacter,
              onSelectBackground: (selectedBackground) {
                this.selectedBackground.value =
                    selectedBackground ?? 'backGrounds/background_Default.jpg';
              },
              onSelectCharacter: (selectedCharacter) {
                this.selectedCharacter.value =
                    selectedCharacter ?? 'characters/character_Autumn.jpg';
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToGame(BuildContext context) {
    final game = TowerDefenseGame();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Material(
          child: TowerDefenseGameScreen(game: game),
        ),
      ),
    );
  }


  void navigateToOptions(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Options(),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PlayButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text("Play"),
      ),
    );
  }
}

class OptionsButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const OptionsButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text("Options"),
      ),
    );
  }
}

class MarketButton extends StatelessWidget {
  final ValueNotifier<String> selectedBackground;
  final ValueNotifier<String> selectedCharacter;
  final void Function(String?) onSelectBackground;
  final void Function(String?) onSelectCharacter;

  const MarketButton({
    Key? key,
    required this.selectedBackground,
    required this.selectedCharacter,
    required this.onSelectBackground,
    required this.onSelectCharacter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        onPressed: () async {
          final Map<String, String>? selectedCharacterResult =
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GameMarketScreen(
                onSelectBackground: onSelectBackground,
                onSelectCharacter: onSelectCharacter,
                selectedCharacter: selectedCharacter,
                selectedBackground: selectedBackground,
              ),
            ),
          );

          if (selectedCharacterResult != null &&
              selectedCharacterResult['$selectedCharacter'] != null) {
            selectedCharacter.value =
            selectedCharacterResult['$selectedCharacter']!;
          }
        },
        child: ValueListenableBuilder<String>(
          valueListenable: selectedCharacter,
          builder: (context, selectedCharacterValue, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Market"),
                Image.asset(
                  'assets/${selectedCharacter.value}',
                  width: 125.0,
                  height: 150.0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
