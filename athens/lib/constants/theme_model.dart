// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeModel {
  ThemeModel._();
  static final ThemeModel instance = ThemeModel._();

  final Color maincolor = const Color.fromRGBO(36, 196, 133, 1);
  final Color secondaryColor = const Color.fromRGBO(17, 153, 142, 1);

  final LinearGradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(17, 153, 142, 1), // Verde scuro
      Color.fromRGBO(36, 196, 133, 1), // Verde chiaro
      Color.fromRGBO(56, 239, 125, 1), // Verdino
    ],
  );

  final Shader textshader = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(0, 127, 255, 1),
      Color.fromRGBO(2, 178, 250, 1),
      Color.fromRGBO(91, 230, 200, 1),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final List<LinearGradient> gradientList = const [
    LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color.fromRGBO(0, 127, 255, 1),
        Color.fromRGBO(2, 178, 250, 1),
        Color.fromRGBO(91, 230, 200, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(214, 41, 118, 1), // Viola
        Color.fromRGBO(250, 126, 30, 1), // Arancione
        Color.fromRGBO(254, 218, 117, 1), // Giallino
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(5, 102, 141, 1), // Blu chiaro
        Color.fromRGBO(2, 128, 144, 1), // Blu un po piu chiaro
        Color.fromRGBO(2, 195, 154, 1), // Verdino
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(214, 41, 118, 1), // Viola
        Color.fromRGBO(150, 47, 191, 1), // Viola scuro
        Color.fromRGBO(79, 91, 213, 1), // Blu
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(250, 126, 30, 1), // Arancione
        Color.fromRGBO(214, 41, 118, 1), // Viola
        Color.fromRGBO(150, 47, 191, 1), // Viola scuro
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(17, 153, 142, 1), // Verde scuro
        Color.fromRGBO(36, 196, 133, 1), // Verde chiaro
        Color.fromRGBO(56, 239, 125, 1), // Verdino
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(141, 153, 255, 1), // Blu tendente al viola
        Color.fromRGBO(205, 0, 255, 1), // Viola
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(42, 255, 150, 1), // Verde
        Color.fromRGBO(0, 158, 255, 1), // Blu
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(220, 28, 19, 1),
        Color.fromRGBO(234, 76, 70, 1),
        Color.fromRGBO(240, 116, 112, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(111, 123, 247, 1), // Blu
        Color.fromRGBO(155, 248, 244, 1), // Verde
      ],
    ),
  ];

  final List<Color?> colorList = [
    Color.fromRGBO(91, 230, 200, 1),
    Colors.amberAccent[700],
    Colors.purpleAccent[700],
    Colors.yellow[700],
    Colors.indigoAccent[700],
    Colors.teal,
    Colors.blueAccent[100],
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.lime[700],
    Colors.cyanAccent[400],
    Colors.deepPurpleAccent[100],
    Colors.lightGreenAccent[700],
    Colors.pink,
    Colors.blueGrey,
  ];

  final BoxShadow shadow = BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      offset: const Offset(0, 2),
      spreadRadius: 1,
      blurRadius: 3);
}

//How to use shader in text
//TextStyle(foreground: Paint()..shader = theme.textshader),
