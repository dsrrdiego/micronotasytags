// import 'package:flutter/material.dart';
// import 'package:notas/codigo/EstadoYToggles.dart';
// import 'package:notas/codigo/Nota.dart';
// import 'package:notas/main.dart';
// import 'package:notas/widgets/modales/modal.dart';
// import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:micronotasytags/codigo/EstadoYToggles.dart';
import 'package:micronotasytags/codigo/Nota.dart';
import 'package:micronotasytags/widgets/modales/modal.dart';
import 'package:provider/provider.dart';


class SectorTags extends StatelessWidget {
  final List<String> tags;
  final Function(String) addTag;
  final Nota? nota;
  final Function(Nota?, String) addNotaTag;
  final Function(String) tagRemove;
  final List<String> tagsBusqueda;

  const SectorTags({
    super.key,
    required this.tags,
    required this.addTag,
    required this.nota,
    required this.addNotaTag,
    required this.tagRemove,
    required this.tagsBusqueda,
  });

  @override
  Widget build(BuildContext context) {
    final estado = Provider.of<Estado>(context);
    TextEditingController controler = TextEditingController();

    return Container(
      color: estado.colorSectorTags,
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:0,right: 80),
            child: Container(
              child: Wrap(
                runSpacing: 3.0,
                children: tags.map((text) {
                  if (estado.esUnaFecha(text) && !estado.incluirFecha)
                    return Container();

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (nota?.getTags().contains(text) ==
                                    true ||
                                (nota == null && tagsBusqueda.contains(text)))
                            ? Color.fromARGB(255, 128, 155, 196)
                            : null,
                      ),
                      onPressed: () {
                        addNotaTag(nota, text);
                      },
                      onLongPress: () {
                        modal(context, 'el tag: ', text).then((confirmed) {
                          if (confirmed != null && confirmed) {
                            tagRemove(text);
                          }
                        });
                      },
                      child: Text(text),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            color: estado.colorSectorTags,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controler,
                    decoration: InputDecoration(
                      hintText: 'Nombre del nuevo Tag',
                    ),
                    onSubmitted: (value) {
                      addTag(controler.text);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 128, 155, 196), //
                  ),
                  child: IconButton(
                    onPressed: () {
                      addTag(controler.text);
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
