import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_memory/classes/card.dart';

/// Clase que representa el juego de memoria 
class Game {
    List<List<MemoryCard>> grid = [[]];
    int rows = 6;
    int columns = 6;
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
    void createGrid(){
        grid = [for(int i = 0; i < columns; i++) [for(int j = 0; j < rows; j++) MemoryCard((j, i))]];
    } 


    /// A cada carta se le asigna un hermano en una posicion aleatoria
    void assignBrothers(){
        List<(int,int)> posiciones = [];
        for(int i = 0; i < columns; i++) {
            for(int j = 0; j < rows; j++){
                posiciones.add((j,i));
            }
        }
        posiciones.shuffle();
        while(posiciones.isNotEmpty){
            (int,int) pos1 = posiciones.removeLast();
            (int,int) pos2 = posiciones.removeLast();

            MemoryCard actual = grid[pos1.$2][pos1.$1];
            MemoryCard brother = grid[pos2.$2][pos2.$1];
            actual.setBrother(brother);
            brother.setBrother(actual);
            actual.setColor(availableColors[availableColors.length - 1]);
            availableColors.removeLast();
        }
    }

    /// Construye el widget que muestra la matriz de cartas
    Column buildGrid(){
        createGrid();
        assignBrothers();
        List<Widget> rowWidgets = [];
        for(int i = 0; i < rows; i++){
            List<Widget> columnWidgets = [];
            for(int j = 0; j < columns; j++){
                columnWidgets.add(grid[j][i].build("",grid[j][i].brother));
            }
            rowWidgets.add(Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: columnWidgets,
            ));
        }
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowWidgets,
        );
    }

}