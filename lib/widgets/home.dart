import 'package:flutter/material.dart';
import 'package:micronotasytags/codigo/EstadoYToggles.dart';
import 'package:micronotasytags/codigo/gestorArchivos.dart';
import 'package:micronotasytags/widgets/barraBuscar.dart';
import 'package:micronotasytags/widgets/menu.dart';
import 'package:micronotasytags/widgets/modales/about.dart';
import 'package:micronotasytags/widgets/modales/modal.dart';
import 'package:micronotasytags/widgets/modales/modalBorrarTags.dart';
import 'package:micronotasytags/widgets/modales/modalGrabando.dart';
import 'package:micronotasytags/widgets/sectorTags.dart';
import 'package:provider/provider.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final estado = Provider.of<Estado>(context);

    return LayoutBuilder(builder: (context, constraints) {
      var delta = constraints.maxHeight * constraints.maxWidth * 0.00015;

      return Column(
        children: [
          mostrarBorrarTodosLosTags(estado, estado.cualesTagsSeBorraran,
              estado.cualesTagsSeBorraranTexto,delta,constraints),
          mostrarAbout(estado, delta,constraints),
          modalGrabando(estado, delta,constraints),
          barraBuscar(estado),
          Expanded(
            child: ListView.builder(
              itemCount: estado.notasFiltradas.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: estado.indiceNotaRecuadro == index
                      ? BoxDecoration(
                          border: Border.all(
                              color: Colors
                                  .blueGrey), // Define el color y el grosor del borde
                          borderRadius: BorderRadius.circular(10.0), // Defi
                        )
                      : null,
                  child: ListTile(
                    leading: estado.getPlaying() &&
                            estado.indiceNotaRecuadro == index
                        ? IconButton(
                            onPressed: () {
                              estado.stopPlaying();
                            },
                            icon: const Icon(Icons.stop))
                        : IconButton(
                            onPressed: () {
                              estado.play(estado.notasFiltradas[index].path);
                              // print (estado.notasFiltradas[index].path);
                              estado.indiceNotaRecuadro = index;
                            },
                            icon: const Icon(Icons.play_arrow)),
                    title: Wrap(
                      children: [
                      
                        estado.getInputToggle() &&
                                estado.indiceNotaRecuadro == index
                            ? Container(
                                  constraints: const BoxConstraints(maxWidth: 250),
                                  child: TextField(
                                    maxLines: 1,
                                    maxLength: 15,
                                    controller: estado.controler,
                                    decoration: InputDecoration(
                                      hintText:
                                          estado.notasFiltradas[index].texto,
                                    ),
                                    onSubmitted: (value) {
                                      if (estado.controler.text != "")
                                        estado.notasFiltradas[index].texto =
                                            estado.controler.text;
                                            GestorArchivos.grabarNotas(estado.notas);
                                      estado.inputToggle();
                                    },
                                  ),
                                // ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  estado.toggleAbrir(
                                      estado.notasFiltradas[index], index);
                                  estado.inputToggle();
                                },
                                child:
                                    Text(estado.notasFiltradas[index].texto)),
                        
                          estado.getInputToggle() &&
                                estado.indiceNotaRecuadro == index
                            ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: IconButton(
                                  onPressed: () {
                                    if (estado.controler.text != "")
                                      estado.notasFiltradas[index].texto =
                                          estado.controler.text;
                                            GestorArchivos.grabarNotas(estado.notas);

                                    estado.inputToggle();
                                  },
                                  icon: Icon(Icons.check)),
                            )
                            : const SizedBox(width: 20),
                        ...estado.notasFiltradas[index].tags.map((text) {
                          if (estado.esUnaFecha(text) && !estado.incluirFecha)
                            return SizedBox();
                          return ElevatedButton(
                            onPressed: () {},
                            onLongPress: () {
                              estado.addNotaTag(
                                  estado.notasFiltradas[index], text);
                            },
                            child: Text(text),
                          );
                        })
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              modal(context, 'la nota',
                                      estado.notasFiltradas[index].texto)
                                  .then((confirmed) {
                                if (confirmed != null && confirmed) {
                                  estado
                                      .borrarNota(estado.notasFiltradas[index]);
                                }
                              });
                            },
                            icon: Icon(Icons.delete_forever)),
                      ],
                    ),
                    // const Icon(Icons.play_arrow),
                    onTap: () {
                      // Manejar la acción al tocar el elemento
                      estado.toggleAbrir(estado.notasFiltradas[index], index);
                    },
                  ),
                );
              },
            ),
          ),
          menuBusqueda(estado),
          estado.muestroMenu ? Container(child: menu(context)) : Container(),
        ],
      );
    });
  }
}

Widget menuBusqueda(estado) {
  return estado.abrir
      ? SizedBox(
          // height: 300,
          child: SectorTags(
          tags: estado.tags,
          addTag: estado.addTag,
          nota: estado.nota,
          addNotaTag: estado.addNotaTag,
          tagRemove: estado.tagRemove,
          tagsBusqueda: estado.tagsBusqueda,
        ))
      : Container();
}


// scroll
/*
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Scrollable Row Example')),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.red,
                width: 200,
                height: 200,
              ),
              Container(
                color: Colors.green,
                width: 200,
            */