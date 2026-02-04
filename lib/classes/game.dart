import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_memory/classes/card.dart';

/// Clase que representa el juego de memoria
class Game {
  List<List<MemoryCard>> grid = [[]];
  int rows = 6;
  int columns = 6;
  int timeToStart = 6;
  dynamic timer;
  late Column gridWidget = buildGrid();
  ValueNotifier<int> recentFlippedCards = ValueNotifier<int>(0);
  ValueNotifier<int> totalFlippedCards = ValueNotifier<int>(0);
  List<dynamic> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.teal,
    Colors.lime,
    Colors.indigo,
    Colors.amber,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.lightBlue,
    Colors.deepPurple,
  ];

  /// Genera una matriz bidimensional de cartas con las dimensiones dadas (en este casos siempre sera 6x6)
  void createGrid() {
    grid = [
      for (int i = 0; i < columns; i++)
        [for (int j = 0; j < rows; j++) MemoryCard((j, i))],
    ];
  }

  /// A cada carta se le asigna un hermano en una posicion aleatoria
  void assignBrothers() {
    List<(int, int)> posiciones = [];
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        posiciones.add((j, i));
      }
    }
    posiciones.shuffle();
    while (posiciones.isNotEmpty) {
      (int, int) pos1 = posiciones.removeLast();
      (int, int) pos2 = posiciones.removeLast();

      MemoryCard actual = grid[pos1.$2][pos1.$1];
      MemoryCard brother = grid[pos2.$2][pos2.$1];
      actual.setBrother(brother);
      brother.setBrother(actual);
      actual.setColor(availableColors[availableColors.length - 1]);
      availableColors.removeLast();
    }
  }

  /// Construye el widget que muestra la matriz de cartas
  Column buildGrid() {
    createGrid();
    assignBrothers();
    List<Widget> rowWidgets = [];
    for (int i = 0; i < rows; i++) {
      List<Widget> columnWidgets = [];
      for (int j = 0; j < columns; j++) {
        columnWidgets.add(
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: grid[j][i].build("", this),
          ),
        );
      }
      rowWidgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: columnWidgets,
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowWidgets,
    );
  }

  bool checkWin() {
    return totalFlippedCards.value / (rows * columns) == 1;
  }

  Widget gameData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _scoreItem("CARTAS TOTALES", totalFlippedCards, Colors.cyanAccent),
        const SizedBox(width: 20),
        _scoreItem("CARTAS RECIENTES", recentFlippedCards, Colors.orangeAccent),
      ],
    );
  }

  void flipCards() {
    Timer(Duration(seconds: 6), () {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
          grid[j][i].isFlipped.value = false;
        }
      }
    });
  }

  Widget _scoreItem(
    String title,
    ValueListenable<int> listenable,
    Color color,
  ) {
    return ValueListenableBuilder<int>(
      valueListenable: listenable,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.5), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$value",
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
