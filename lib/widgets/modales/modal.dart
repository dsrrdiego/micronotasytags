 import 'package:flutter/material.dart';

Future<dynamic> modal(BuildContext context, texto, nombre) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Estas a punto de Borrar $texto $nombre'),
          content: const Text('¿Estás seguro de continuar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Acción cuando se presiona "Sí"
                Navigator.of(context)
                    .pop(true); // Cierra el diálogo y devuelve true
              },
              child: const Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                // Acción cuando se presiona "No"
                Navigator.of(context)
                    .pop(false); // Cierra el diálogo y devuelve false
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }