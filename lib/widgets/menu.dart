// import 'package:flutter/material.dart';
// import 'package:notas/codigo/EstadoYToggles.dart';
// import 'package:notas/main.dart';
// import 'package:notas/widgets/modales/modal.dart';
// import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:micronotasytags/codigo/EstadoYToggles.dart';
import 'package:provider/provider.dart';

Widget menu(BuildContext context) {
  final estado = Provider.of<Estado>(context);
  return AnimatedOpacity(
    opacity: 1,
    duration: Duration(milliseconds: 3000),
    child: Material(
      color: Color.fromARGB(255, 220, 219, 226),
      // type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(left:8,top:15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(Icons.accessibility_new_rounded),
                  ),
                  Text('Acerca de'),
                ],
              ),
              onTap: () {
                estado.toggleAbout();
              },
            ),
            ListTile(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Icon(Icons.date_range),
                    ),
                    Text('Mostrar Fechas'),
                    estado.incluirFecha
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(Icons.date_range, color: Colors.red),
                          )
                        : Container(),
                  ],
                ),
                onTap: estado.toggleIncluirFecha),
            ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(Icons.delete),
                  ),
                  Text('Remover Tags sin uso'),
                ],
              ),
              onTap: () {
                estado.cualesTagsSeBorraran = 'TAGSALGUNOS';
                estado.cualesTagsSeBorraranTexto =
                    'Borrar los Tags que no se estan usando';
                estado.toggleBorrarTodosLosTags();
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(Icons.delete_forever),
                  ),
                  Text('Borrar todos los tags'),
                ],
              ),
              onTap: () {
                estado.cualesTagsSeBorraran = 'TAGSTODOS';
                estado.cualesTagsSeBorraranTexto = 'Borrar todos los Tags';
                estado.toggleBorrarTodosLosTags();
              },
            ),
            ListTile(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    Text('Borrar Notas Seleccionadas'),
                  ],
                ),
                onTap: () {
                  estado.cualesTagsSeBorraran = 'NOTAS';
                  estado.cualesTagsSeBorraranTexto = 'Borrar todas las NOTAS';
                  estado.toggleBorrarTodosLosTags();
                }),
            ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(Icons.close),
                  ),
                  Text('Cerrar'),
                ],
              ),
              onTap: estado.mostrarMenu,
            ),
          ],
        ),
      ),
    ),
  );
}
