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
  final GlobalKey<GridWidgetState> gridKey = GlobalKey<GridWidgetState>();
  late Widget gridWidget = buildGrid();
  ValueNotifier<int> recentFlippedCards = ValueNotifier<int>(0);
  ValueNotifier<int> totalFlippedCards = ValueNotifier<int>(0);
  List<IconData> availableIcons = [
  Icons.favorite,
  Icons.star,
  Icons.home,
  Icons.pets,
  Icons.book,
  Icons.cake,
  Icons.music_note,
  Icons.sports_soccer,
  Icons.computer,
  Icons.phone,
  Icons.sports_soccer,
  Icons.computer,
  Icons.phone,
  Icons.email,
  Icons.cloud,
  Icons.sunny,
  Icons.flag,
  Icons.book,
  Icons.diamond,
  Icons.bolt,
  Icons.airplanemode_active,
];

Widget buildGrid() {
    createGrid();
    assignBrothers();
    return GridWidget(key: gridKey, game: this);
  }

  // MÉTODO 2: Para actualizarlo después de cambios
  void refreshBoard() {
    gridKey.currentState?.refresh();
  }

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
  
  // MEZCLA LOS ICONOS TAMBIÉN
  List<IconData> shuffledIcons = List.from(availableIcons);
  shuffledIcons.shuffle();
  
  int iconIndex = 0;
  while (posiciones.isNotEmpty) {
    (int, int) pos1 = posiciones.removeLast();
    (int, int) pos2 = posiciones.removeLast();

    MemoryCard actual = grid[pos1.$2][pos1.$1];
    MemoryCard brother = grid[pos2.$2][pos2.$1];
    actual.setBrother(brother);
    brother.setBrother(actual);
    
    // CORRECCIÓN: Usa el índice módulo la longitud de la lista
    actual.setIcon(shuffledIcons[iconIndex % shuffledIcons.length]);
    iconIndex++;
  }
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
    Timer(Duration(seconds: 3), () {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
          grid[j][i].isFlipped.value = false;
        }
      }
      refreshBoard();
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
                style: TextStyle(
                  fontFamily: 'Impact',
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$value",
                style: TextStyle(
                  fontFamily: 'Impact',
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


class GridWidget extends StatefulWidget {
  final Game game;
  const GridWidget({super.key, required this.game});

  @override
  State<GridWidget> createState() => GridWidgetState();
}

class GridWidgetState extends State<GridWidget> {
  
  /// Método público para actualizar el tablero
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    
    for (int i = 0; i < widget.game.rows; i++) {
      List<Widget> columnWidgets = [];
      for (int j = 0; j < widget.game.columns; j++) {
        columnWidgets.add(
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: widget.game.grid[j][i].build("", widget.game),
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
}