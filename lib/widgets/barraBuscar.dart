import 'package:flutter/material.dart';

Widget barraBuscar(estado) {
  return estado.indiceNotaRecuadro == -1 ? barra(estado) : const SizedBox();
}

@override
Widget barra(var estado) {
  return Container(
    color:estado.colorSectorTags,//Colors.red[200],
    padding: EdgeInsets.all(5),
    child: Row(
      children: [
        Icon(Icons.find_in_page,size:66,color: Color.fromARGB(255, 33, 67, 95),),
        const Text('Buscar: ',style: TextStyle(fontSize: 35),),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 80.0,left:20),
            child: TextField(
                decoration: InputDecoration(hintText: 'nota 0',hintStyle: TextStyle(fontSize: 25)),
                onChanged:(value){
                  estado.textoABuscar=value;
                  estado.buscarTexto();
                print (value);
                },
                // controller: estado.textoABuscar
                ),
          ),
        ),
      ],
    ),
  );
}
