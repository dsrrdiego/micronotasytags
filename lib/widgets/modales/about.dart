import 'package:flutter/material.dart';

Widget mostrarAbout(estado, delta,constraints) {
  return estado.mostrarAbout
      ? Padding(
          padding: EdgeInsets.only(
              top: constraints.maxHeight*0.2,
              left: delta,
              right: delta),

          child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: delta*0.25,
                    left:   delta * 0.05,
                    right:  delta * 0.1,
                    bottom: delta * 0.04),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Micro - Notes & Tags',
                      style: TextStyle(
                          fontSize: delta*0.5,//constraints.maxHeight * 0.05,
                          fontWeight: FontWeight.w900,

                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Aplicacion multiplataforma\nRealizada con FLUTTER\nPor Diego Rodriguez',
                      style: TextStyle(fontSize: delta * 0.25),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '\nhttps://dsrrdiego.github.io/Portfolio/',
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    RichText(
                        text: TextSpan(
                            // style: TextStyle(fontSize: 15.0),
                            children: [
                          TextSpan(
                            text: 'dsrrdiego@hotmail.com   ',
                            style: TextStyle(color: Colors.black54),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.phone,
                              color: Colors.green[400],
                            ),
                          ),
                          const TextSpan(
                            text: '  +5492983606824\n\n',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ])),
                    ElevatedButton(
                        onPressed: estado.toggleAbout, child: Text('Ok')),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text('\nv1.1  4-2024')),
                  ],
                ),
              )),
        )
      : Container();
}
