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
    widget.card.buttonEnabled.dispose();
    _controller.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  void setFlipped() {
    if (widget.card.isFlipped.value) return;
  
    setState(() {
      widget.card.isFlipped.value = true; // La volteamos visualmente
    });

    widget.game.onCardFlipped(widget.card);
  }


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
              child: Icon(
                Icons.question_mark, 
                color: Colors.white,
                size: 30,
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
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: null,
                  child: widget.card.icon != null
                      ? Icon(widget.card.icon, size: 30)
                      : Icon(Icons.error, size: 30),
                ),
              );
            },
          );
        },
      );
    }
  }
}