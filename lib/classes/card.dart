import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_memory/classes/game.dart';
import 'package:flutter_memory/widgets/CardWidget.dart';

class MemoryCard {
  MemoryCard? brother;
  IconData? icon;
  ValueNotifier<bool> isFlipped = ValueNotifier<bool>(true);
  ValueNotifier<bool> buttonEnabled = ValueNotifier<bool>(true);
  (int, int)? coordinate = (-1, -1);

  MemoryCard(this.coordinate);

  /// Verifica si la carta ya tiene un hermano asignado
  bool hasBrother() {
    return brother != null;
  }

  /// Asigna un color a la carta y a su hermano si no tiene color asignado
  void setIcon(IconData iconToSet) {
    icon = iconToSet;
    if (brother != null && brother!.icon == null) {
      brother!.icon = iconToSet;
    }
  }

  /// Asigna un hermano a la carta
  void setBrother(MemoryCard brotherToSet) {
    brother = brotherToSet;
    /*if (brotherToSet.brother == null){
            brotherToSet.setBrother(this);
        }*/
  }

  /// Construye el widget que representa la carta
  StatefulWidget build(String imagePath, Game game) {
    return CardWidget(card: this, game: game);
  }

  void main() {}
}
