import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:micronotasytags/codigo/Nota.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Estado with ChangeNotifier {
  bool playing = false;
  int nroDeAudio = 0;
  bool grabando = false;
  FlutterSoundRecorder? grabador;
  FlutterSoundPlayer? player;
  String ultimoPath = '';
  var notas = <Nota>[];
  var notasResguardo = <Nota>[];
  var notasFiltradas = <Nota>[];
  var tagsBusqueda = <String>[];
  var tags = <String>[];
  var cualesTagsSeBorraran = '';
  var cualesTagsSeBorraranTexto = '';

  @override
  Estado() {
    grabador = FlutterSoundRecorder();
    player = FlutterSoundPlayer();
    ini();
    // GestorArchivos.cargarTags(tags);
    // GestorArchivos.cargarNotas(notas);
  }

  Future<void> ini() async {
    await grabador?.openRecorder();
    await player?.openPlayer();
    await pedirPermisos();
  }

  Future<void> pedirPermisos() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<String> damePath() async {
    final carpetaSistema = await getExternalStorageDirectory();
    final miCarpeta = Directory('${carpetaSistema?.path}/MicroNotesYTags');
    if (!miCarpeta.existsSync()) {
      miCarpeta.createSync();
    }
    return '${miCarpeta.path}/MNYT_${DateTime.now().millisecondsSinceEpoch}.aac';
  }

  Future<void> rec() async {
    String path = await damePath();
    ultimoPath = path;
    await grabador?.startRecorder(toFile: path);
    grabando = true;
    notasResguardo = List.from(notasFiltradas);
    notasFiltradas = [];
    abrir = false;
    if (indiceNotaRecuadro == -1) indiceNotaRecuadro = 0;
    toggleBotonesFlotantes();

    notifyListeners();
  }

  Future<void> stop() async { //stop grabacion
    print('stop');
    await grabador?.stopRecorder();
    grabando = false;
    toggleBotonesFlotantes();
    agregar(ultimoPath);
    notifyListeners();
  }

  Future<void> play(var path) async {
    await player?.startPlayer(fromURI: path);
    //   // print('abriendo $arch');
    //   try {
    //     print ('$path play!!!');
    //     await player?.play(path);
    playing = true;
    // player?.audioPlayerFinished(1).listen((event) {
    //   playing = false;
    //   notifyListeners();
    // });
    notifyListeners();
    //   } catch (e) {
    //     print('error en play $path');
    //   }
  }

  stopPlaying() {
    player?.stopPlayer();
    playing = false;
    notifyListeners();
  }

  bool getPlaying() {
    return playing;
  }

  void agregar(var path) {
    print(path);
    Nota nota = Nota();
    nota.path = path;
    nroDeAudio++;
    nota.texto = 'nota $nroDeAudio';
    // DateTime now = DateTime.now();

    // String dia = dias[now.weekday];
    // addTag(dia);
    // nota.addTag(dia);

    // String mes = meses[now.month];
    // addTag(mes);
    // nota.addTag(mes);

    // String anio = now.year.toString();
    // addTag(anio);
    // nota.addTag(anio);

    notas.add(nota);
    notasFiltradas.addAll(List.from(notasResguardo));
    notasFiltradas.add(nota);

    indiceNotaRecuadro = notasFiltradas.length - 1;
    this.nota = nota;
    // GestorArchivos.grabarAudio(nota);
    // GestorArchivos.grabarNotas(notas);
    notifyListeners();
    // downloadFileFromBlobUrl(path,'hh.wav');
  }

  final dias = [
    'Domingo',
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado'
  ];
  final meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  bool esUnaFecha(String tag) {
    int? anio = int.tryParse(tag);
    if (dias.contains(tag) ||
        meses.contains(tag) ||
        (anio != null && anio > 2020 && anio < 2050)) return true;
    return false;
  }

  Future<void> borrarNota(Nota n) async {
    // stopPlaying();
    notas.remove(n);
    // GestorArchivos.grabarNotas(notas);
    notasFiltradas = List.from(notas);
    notifyListeners();
    // LINUX
    // print('borrando');
    // final file = File(n.path);

    // try {
    //   if (await file.exists()) {
    //     stopPlaying();
    //     await file.delete();
    //     GestorArchivos.grabarNotas(notas);
    //     print('Archivo borrado exitosamente');
    //   } else {
    //     print('El archivo no existe');
    //   }
    // } catch (e) {
    //   print('Error al borrar el archivo: $e');
    // }
    // notas.remove(n);
    // notasFiltradas = List.from(notas);
    // notifyListeners();
  }

  void borrarTodasLasNotas() {
    for (Nota n in respaldo) {
      borrarNota(n);
    }
    respaldo = List.from(notas);
  }

  void addNotaTag(Nota? nota, String tag) {
    if (nota != null) {
      nota.addTag(tag);
      // GestorArchivos.grabarNotas(notas);
    } else {
      if (tagsBusqueda.contains(tag)) {
        tagsBusqueda.remove(tag);
      } else {
        tagsBusqueda.add(tag);
      }
      notasFiltradas = dameFiltradas(notas, tagsBusqueda);
    }
    notifyListeners();
  }

  void buscarTexto() {
    notasFiltradas = dameFiltradas(notas, tagsBusqueda);
    notifyListeners();
  }

  List<Nota> dameFiltradas(List<Nota> notas, List<String> tags) {
    notasFiltradas = List.from(notas);
    textoABuscar = textoABuscar.toLowerCase();
    var respuesta = <Nota>[];
    for (Nota n in notas) {
      bool estaEnTags = false;
      for (String t in n.tags) {
        if (t.toLowerCase().contains(textoABuscar)) {
          estaEnTags = true;
          break;
        }
      }

      if (!n.texto.toLowerCase().contains(textoABuscar) && !estaEnTags) {
        notasFiltradas.remove(n);
        // borrar = true;
        continue;
      }

      for (String t in tags) {
        if (!n.tags.contains(t)) {
          notasFiltradas.remove(n);
          break;
        }
      }
    }
    return notasFiltradas;
  }

  void addTag(tag) {
    if (!tags.contains(tag) && tag != '') {
      tags.add(tag);
      // GestorArchivos.grabarTags(tags);
      notifyListeners();
    }
  }

  void tagRemove(tag) {
    tags.remove(tag);
    for (Nota n in notas) {
      if (n.tags.contains(tag)) n.tags.remove(tag);
    }
    // GestorArchivos.grabarTags(tags);
    notifyListeners();
  }

  void borrarTodosLosTags() {
    var exTags = List.from(tags);
    for (String t in exTags) {
      tagRemove(t);
    }
    // GestorArchivos.grabarTags(tags);
  }

  void borrarAlgunosLosTags() {
    print('algunos');
    var copiaTags = List.from(tags);
    for (var t in copiaTags) {
      bool borrar = true;
      for (Nota n in notas) {
        if (n.tags.contains(t)) {
          borrar = false;
          break;
        }
      }
      if (borrar) {
        tags.remove(t);
      }
      // GestorArchivos.grabarTags(tags);
    }
  }

// visual
  bool incluirFecha = true;
  void toggleIncluirFecha() {
    incluirFecha = !incluirFecha;
    notifyListeners();
  }

  var respaldo = <Nota>[];
  bool mostrarBorrarTodosLosTags = false;
  void toggleBorrarTodosLosTags() {
    mostrarBorrarTodosLosTags = !mostrarBorrarTodosLosTags;
    if (mostrarBorrarTodosLosTags) {
      respaldo = List.from(notasFiltradas);
      notasFiltradas = [];
      abrir = false;
      mostrarBotonesFlotantes = false;
    } else {
      mostrarBotonesFlotantes = true;
      notasFiltradas = List.from(respaldo);
    }

    muestroMenu = false;
    notifyListeners();
  }

  bool mostrarBotonesFlotantes = false;
  toggleBotonesFlotantes() {
    mostrarBotonesFlotantes = !mostrarBotonesFlotantes;
    notifyListeners();
  }

  bool mostrarAbout = true;
  toggleAbout() {
    if (mostrarAbout) {
      notasFiltradas = List.from(notas);
      toggleBotonesFlotantes();
    } else {
      mostrarEstadoVisualInicial();
    }
    mostrarAbout = !mostrarAbout;
    notifyListeners();
  }

  bool muestroMenu = false;
  mostrarMenu() {
    muestroMenu = !muestroMenu;
    // mostrarBotonesFlotantes=!mostrarBotonesFlotantes;
    abrir = false;
    if (indiceNotaRecuadro == -1) indiceNotaRecuadro = 0;
    notifyListeners();
  }

  bool abrir = false;
  Nota? nota = Nota();
  int exIndex = 0;
  Color colorSectorTags = const Color.fromARGB(255, 54, 244, 63);
  Color colorSectorTagsNoBusqueda = Color.fromARGB(255, 245, 174, 195);
  Color colorSectorTagsBusqueda = Color.fromARGB(255, 171, 171, 189);
  void toggleAbrir(Nota? nota, index) {
    muestroMenu = false;
    if (index == -1 && indiceNotaRecuadro == -1) {
      abrir = !abrir;
      index = exIndex;
    } else {
      exIndex = indiceNotaRecuadro;
      _inputToggle = false;
      abrir = true;
    }
    ;
    print('index  $index indice $indiceNotaRecuadro abrir $abrir');
    if (index == -1)
      colorSectorTags = colorSectorTagsNoBusqueda;
    else
      colorSectorTags = colorSectorTagsBusqueda;
    this.nota = nota;
    int i = index;
    if (index >= 0) {
      i = notas.indexOf(notasFiltradas[index]);
    } else {
      notasFiltradas = [];
      // i = -1;
    }
    notasFiltradas = List.from(notas);
    indiceNotaRecuadro = i;
    notifyListeners();
  }

  bool _inputToggle = false;
  bool getInputToggle() {
    return _inputToggle;
  }

  void inputToggle() {
    _inputToggle = !_inputToggle;
    notifyListeners();
  }

  int indiceNotaRecuadro = 0;
  final TextEditingController controler = TextEditingController();
  String textoABuscar = "";

  void mostrarEstadoVisualInicial() {
    _inputToggle = false;
    mostrarAbout = false;

    muestroMenu = false;
    mostrarBotonesFlotantes = false;
  }

  @override
  void dispose() {
    grabador?.closeRecorder();
    player?.closePlayer();
    super.dispose();
  }
}
