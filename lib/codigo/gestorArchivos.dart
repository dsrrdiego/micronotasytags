// import 'dart:convert';
// import 'dart:io';

// import 'package:notas/codigo/Nota.dart';
// import 'package:notas/main.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:universal_html/html.dart' as html;

import 'package:micronotasytags/codigo/Nota.dart';

class GestorArchivos {
  static grabarAudio(Nota nota) {
    // String nombre = 'notas_$nota.path.wav';
    // // nota.path = nombre;
    // final anchor = html.AnchorElement(href: nota.path)
    //   ..setAttribute('download', nota.path)
    //   ..click();
  }

  static Future<void> grabarNotas(var notas) async {
    print('\n\n\nGRABO\n\n');
    final texto = todasLasNotasATexto(notas);
    // void setCookie(String MicriNotesAndTags, String value, int days) {
    final espira = DateTime.now().add(Duration(days: 30));
    final espiraString = espira.toUtc().toIso8601String();
    // html.document.cookie =
    //     'MicroNotesYTags=$texto;expires=$espiraString;path=/';
  }

  // final bytes = utf8.encode(texto); // Convierte el contenido a bytes
  // final blob = html.Blob([bytes]); // Crea un Blob a partir de los bytes
  // final url = html.Url.createObjectUrlFromBlob(
  //     blob); // Crea una URL temporal para el Blob

  // final anchor = html.AnchorElement(href: url)
  //   ..setAttribute('download',
  //       'notas.txt') // Establece el nombre del archivo para la descarga
  //   ..click(); // Simula un clic para iniciar la descarga

  // html.Url.revokeObjectUrl(url); // Libera la URL temporal

  // var path =
  //     (await getApplicationDocumentsDirectory()).path + '/notas/notas.txt';
  // final file = File(path);

  // try {
  //   // Convertir el objeto a JSON
  //   final texto = todasLasNotasATexto(notas);

  //   // Escribir el JSON en el archivo
  //   await file.writeAsString(texto);
  // } catch (e) {
  //   print('Error al guardar el objeto: $e');
  // }
  // }

  static Future<void> grabarTags(tags) async {
    // final texto = jsonEncode(tags);

    // final espira = DateTime.now().add(Duration(days: 30));
    // final espiraString = espira.toUtc().toIso8601String();
    // html.document.cookie =
    //     'MicroNotesYTagsTags=$texto;expires=$espiraString;path=/';

    // codigo para LINUX
    // var path =
    //     (await getApplicationDocumentsDirectory()).path + '/notas/tags.txt';
    // final file = File(path);
    // try {
    //   final texto = jsonEncode(tags);

    //   // Escribir el JSON en el archivo
    //   await file.writeAsString(texto);
    // } catch (e) {
    //   print('Error al guardar el objeto: $e');
    // }
  }

  static void cargarNotas(notas) async {
    // String? getCookie(String name) {
    // String texto = '';
    // final cookies = html.document.cookie?.split('; ') ?? [];
    // for (var cookie in cookies) {
    //   final cookieParts = cookie.split('=');
    //   if (cookieParts[0] == 'MicroNotesYTags') {
    //     texto += cookieParts.sublist(1).join('=');
    //   }
    // }
    // print('cookie');
    // print(texto);
    // texto.trim();
    // List<dynamic> array = jsonDecode(texto);
    // for (var n in array) {
    //   Nota nueva = fromMap(n);
    //   notas.add(nueva);
    // }
    // codigo para LINUX

    // var path =
    //     (await getApplicationDocumentsDirectory()).path + '/notas/notas.txt';

    // final file = File(path);

    // try {
    //   // Leer el JSON del archivo
    //   var texto = await file.readAsString();
    //   texto.trim();
    //   List<dynamic> array = jsonDecode(texto);
    //   for (var n in array) {
    //     Nota nueva = fromMap(n);
    //     notas.add(nueva);
    //   }
    //   // Estado.toggleAbrir(null, -2);
    // } catch (e) {
    //   print('Error al cargar el objeto: $e');
    // }
    // }
  }

  static void cargarTags(tags) async {
    String texto = '';
    // final cookies = html.document.cookie?.split('; ') ?? [];
    // for (var cookie in cookies) {
    //   final cookieParts = cookie.split('=');
    //   if (cookieParts[0] == 'MicroNotesYTagsTags') {
    //     texto += cookieParts.sublist(1).join('=');
    //   }
    // }
    // print('\ncookie Tags');
    // print(texto);
    // texto.trim();
    // List<dynamic> array = jsonDecode(texto);
    // for (var n in array) {
    //   tags.add(n);
    // }
    // Codigo para LINUX
    // List<dynamic> array = jsonDecode(texto);
    // for (var n in array) {
    //   Nota nueva = fromMap(n);
    //   notas.add(nueva);
    // }
    //   var path =
    //       (await getApplicationDocumentsDirectory()).path + '/notas/tags.txt';

    //   final file = File(path);

    //   try {
    //     // Leer el JSON del archivo
    //     var texto = await file.readAsString();
    //     texto.trim();
    //     List<dynamic> array = jsonDecode(texto);
    //     for (var n in array) {
    //       tags.add(n);
    //     }
    //   } catch (e) {
    //     print('Error al cargar el objeto: $e');
    //     // Si hay un error, puedes devolver un objeto predeterminado o lanzar una excepción según tu lógica.
    //   }
    // }
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
