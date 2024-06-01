
import 'package:flutter/material.dart';

Widget botonesFlotantes(estado) {
  return 
  estado.mostrarBotonesFlotantes
  ?
  Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 120.0),
          child: FloatingActionButton(
            onPressed: () {
              estado.rec();
            },
            child: Icon(Icons.mic),
            tooltip: 'Grabar Nota',
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {
              estado.toggleAbrir(null, -1);
            },
            child: Icon(Icons.find_in_page),
            tooltip: 'Buscar Nota',
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            estado.mostrarMenu();
          },
          child: Icon(Icons.menu),
          tooltip: 'Menu',
        ),
      ),
    ],
  )
  :Container();
}
