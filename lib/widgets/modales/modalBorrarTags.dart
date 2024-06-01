import 'package:flutter/material.dart';

Widget mostrarBorrarTodosLosTags(var estado, clave,texto,delta,constraints ) {
  return estado.mostrarBorrarTodosLosTags
      ? Padding(
          padding:  EdgeInsets.symmetric(vertical: constraints.maxHeight*0.2,horizontal: constraints.maxWidth*0.1),
          child: Card(
              elevation: 7.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(top:constraints.maxHeight*0.07, left: delta*0, right: delta*0, bottom: constraints.maxHeight*0.07),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '$texto',
                      style: TextStyle(
                          fontSize: delta*0.4, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: delta*0.3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: delta*0.40,
                                  vertical: delta*0.25), // Ajusta el padding del botón
                              textStyle: TextStyle(
                                  fontSize: delta*0.3,
                                  fontWeight: FontWeight
                                      .w900), // Ajusta el tamaño del texto del botón
                              minimumSize: Size(
                                  10, 10), // Ajusta el tamaño mínimo del botón
                            ),
                            onPressed: () {
                              if (clave == 'TAGSTODOS') {
                                estado.borrarTodosLosTags();
                                estado.toggleBorrarTodosLosTags();
                                estado.cualesTagsSeBorraran = '';
                              } else if (clave == 'TAGSALGUNOS') {
                                estado.borrarAlgunosLosTags();
                                estado.toggleBorrarTodosLosTags();
                                estado.cualesTagsSeBorraran = '';
                              } else if (clave == 'NOTAS'){
                                estado.borrarTodasLasNotas();
                                estado.toggleBorrarTodosLosTags();
                                estado.cualesTagsSeBorraran = '';
                              }
                            },
                            child: Text('Si')),
                        SizedBox(width: delta*0.2),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: delta*0.35,
                                  vertical: delta*0.25), // Ajusta el padding del botón
                              textStyle: TextStyle(
                                  fontSize: delta*0.3,
                                  fontWeight: FontWeight
                                      .w900), // Ajusta el tamaño del texto del botón
                              minimumSize: Size(
                                  10, 10), // Ajusta el tamaño mínimo del botón
                            ),
                            onPressed: estado.toggleBorrarTodosLosTags,
                            child: Text('No')),
                      ],
                    ),
                  ],
                ),
              )),
        )
      : Container();
}
