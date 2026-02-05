import 'package:flutter/material.dart';
// Importamos el main para poder saltar a la pantalla del juego (MyHomePage)
import '../main.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WELCOME TO FLUTTER\nMEMORY",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Courier New',
                fontSize: 60,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 154, 175, 188),
                letterSpacing: 4,
                shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 40, 138, 138),
                      blurRadius: 20,
                      offset: Offset(0, 0),
                    ),
                  ],

              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 5, 207, 218),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(title: 'Flutter Memory'),
                  ),
                );
              },
              child: Text(
                "COMENZAR A JUGAR",
                style: TextStyle(
                  fontSize: 22,                    
                  fontWeight: FontWeight.w700,     
                  color: Colors.black,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
