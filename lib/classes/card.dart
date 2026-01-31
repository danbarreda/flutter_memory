import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_memory/widgets/CardWidget.dart';

class MemoryCard {
    MemoryCard? brother;
    Color? color;
    (int,int)? coordinate = (-1,-1);

    MemoryCard(this.coordinate);

    /// Verifica si la carta ya tiene un hermano asignado
    bool hasBrother(){
        return brother != null;
    }

    /// Asigna un color a la carta y a su hermano si no tiene color asignado
    void setColor(Color colorToSet){
        color = colorToSet;
        if (brother != null && brother!.color == null){
            brother!.color = colorToSet;
        }
    }

    /// Asigna un hermano a la carta
    void setBrother(MemoryCard brotherToSet){
        brother = brotherToSet;
        /*if (brotherToSet.brother == null){
            brotherToSet.setBrother(this);
        }*/
    }

    /// Construye el widget que representa la carta
    StatefulWidget build(String image,MemoryCard? brother){
        return CardWidget(
            color: this.color!,
        );
    }

    void main(){

    }
}  
