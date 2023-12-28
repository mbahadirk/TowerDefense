import 'package:flutter/material.dart';
import 'dart:async';

class Background extends StatefulWidget {
  final ValueNotifier<String> selectedBackground;

  const Background({Key? key, required this.selectedBackground}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );

    _startAutoScroll();
  }

  _startAutoScroll() {
    Timer.periodic(const Duration(milliseconds: 750), (timer) {
      _nextPage();
    });
  }

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(seconds: 20),
        curve: Curves.linear,
      );
    }
  }

  // Bu metodun eklenmesi
  void setSelectedBackground(String background) {
    widget.selectedBackground.value = background;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ValueListenableBuilder<String>(
          valueListenable: widget.selectedBackground,
          builder: (context, selectedBackground, _) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$selectedBackground'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
