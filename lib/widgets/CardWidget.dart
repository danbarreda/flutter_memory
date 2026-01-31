import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.color});

  final Color color;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isFlipped = false;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
  double width = MediaQuery.of(context).size.width / 8;
    return Container(
      width: width,
      height: width,
      color: widget.color,
      child: TextButton(
        onPressed: () {
          setState(() {
            isFlipped = !isFlipped;
          });
        },
        child: Text("Estado: $isFlipped ")
      ),
    );
  }
}