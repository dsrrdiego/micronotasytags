// import 'dart:convert';
// import 'dart:io';

// import 'package:notas/codigo/Nota.dart';
// import 'package:notas/main.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:universal_html/html.dart' as html;

import 'dart:convert';
import 'dart:io';

import 'package:micronotasytags/codigo/Nota.dart';
import 'package:path_provider/path_provider.dart';

class GestorArchivos {
  // static Future<String> dameCarpetaDeTrabajo() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return '${directory.path}/microNotasYTytags';
  // }
  // Future<String> notasTxtPath() async {
  //   final directory = await getApplicationDocumentsDirectory();

  //   return '${directory.path}/my_file.txt';
  // }
   static Future<String> notasTxtPath() async {
    final carpetaSistema = await getExternalStorageDirectory();
    final miCarpeta = Directory('${carpetaSistema?.path}/MicroNotesYTags');
    if (!miCarpeta.existsSync()) {
      miCarpeta.createSync();
    }
    return '${miCarpeta.path}/notas.txt';
  }
   static Future<String> tagsTxtPath() async {
    final carpetaSistema = await getExternalStorageDirectory();
    final miCarpeta = Directory('${carpetaSistema?.path}/MicroNotesYTags');
    if (!miCarpeta.existsSync()) {
      miCarpeta.createSync();
    }
    return '${miCarpeta.path}/tags.txt';
  }

  static Future<void> grabarNotas(var notas) async {
    print('\n\n\nGRABO\n\n');
    final texto = todasLasNotasATexto(notas);
    String filePath = await notasTxtPath();
    final file = File(filePath);
    await file.writeAsString(texto);
  }

  static Future<void> grabarTags(tags) async {
    String path = await tagsTxtPath();

    final file = File(path);
    try {
      final texto = jsonEncode(tags);
      await file.writeAsString(texto);
    } catch (e) {
      print('Error al guardar el objeto: $e');
    }
  }

  static void cargarNotas(notas) async {
    String path = await notasTxtPath();

    final file = File(path);

    try {
      // Leer el JSON del archivo
      var texto = await file.readAsString();
      texto.trim();
      List<dynamic> array = jsonDecode(texto);
      for (var n in array) {
        Nota nueva = fromMap(n);
        notas.add(nueva);
      }
      // Estado.toggleAbrir(null, -2);
    } catch (e) {
      print('Error al cargar el objeto: $e');
    }
  }

  static void cargarTags(tags) async {
    String path = await tagsTxtPath();

    final file = File(path);

    try {
      //     // Leer el JSON del archivo
      var texto = await file.readAsString();
      texto.trim();
      List<dynamic> array = jsonDecode(texto);
      for (var n in array) {
        tags.add(n);
      }
    } catch (e) {
      print('Error al cargar el objeto: $e');
      // Si hay un error, puedes devolver un objeto predeterminado o lanzar una excepción según tu lógica.
    }
  }
}

// auxiliares
String todasLasNotasATexto(notas) {
  String r = '[';
  for (Nota n in notas) {
    r += n.aStringParaGuardar();
    if (n != notas[notas.length - 1]) {
      r += ',';
    }
  }
  r += ']';
  return r;
}

Nota fromMap(Map<String, dynamic> map) {
  Nota n = Nota();
  n.texto = map['texto'];
  n.path = map['path'];
  var tags = map['tags'];
  for (String t in tags) {
    n.addTag(t);
  }
  return n;
}
