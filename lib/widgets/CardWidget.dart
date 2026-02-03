import 'package:flutter/material.dart';
import 'package:flutter_memory/classes/card.dart';
import 'package:flutter_memory/classes/game.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.card, required this.game});

  final MemoryCard card;
  final Game game;
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    widget.game.flipCards();
  }

  @override
  void dispose() {
    widget.game.recentFlippedCards.dispose();
    widget.game.totalFlippedCards.dispose();
    widget.card.buttonEnabled.dispose();
    _controller.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  void setFlipped() => {
    setState(() {
      widget.card.isFlipped.value = !widget.card.isFlipped.value;
      if ((widget.card.isFlipped.value &&
          widget.card.brother!.isFlipped.value)) {
        widget.game.totalFlippedCards.value += 2;
        widget.game.recentFlippedCards.value--;
        widget.card.buttonEnabled.value = false;
        widget.card.brother?.buttonEnabled.value = false;
      } else {
        widget.game.recentFlippedCards.value++;
      }
    }),
  };

  void setUnflipped() => {
    setState(() {
      widget.card.isFlipped.value = !widget.card.isFlipped.value;
      if (widget.game.recentFlippedCards.value == 1) {
        widget.game.recentFlippedCards.value--;
      }
    }),
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 12;
    (int, int)? coord = widget.card.coordinate;
    (int, int)? brotherCoord = widget.card.brother!.coordinate;
    bool enabled = widget.card.buttonEnabled.value;
    if (!widget.card.isFlipped.value) {
      return ValueListenableBuilder(
        valueListenable: widget.card.isFlipped,
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.all(10),
            width: width * 1.5,
            height: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueGrey,
            ),
            child: TextButton(
              onPressed: widget.card.buttonEnabled.value ? setFlipped : null,
              child: Text(
                "Estado: $value\n Coord: $coord \n Brother: $brotherCoord",
              ),
            ),
          );
        },
      );
    } else {
      return ValueListenableBuilder(
        valueListenable: widget.card.isFlipped,
        builder: (context, value, child) {
          return ValueListenableBuilder(
            valueListenable: widget.card.buttonEnabled,
            builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.all(10),
                width: width * 1.5,
                height: width,
                decoration: BoxDecoration(
                  color: widget.card.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: value ? setUnflipped : null,
                  child: Text("Estado: True\n Button enabled: $enabled"),
                ),
              );
            },
          );
        },
      );
    }
  }
}
