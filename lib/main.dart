import 'package:flutter/material.dart';
import 'package:micronotasytags/codigo/EstadoYToggles.dart';
import 'package:micronotasytags/widgets/botonesFlotantes.dart';
import 'package:micronotasytags/widgets/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Estado(),
      child: MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final estado = Provider.of<Estado>(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          // width: constraints.maxWidth,
          // height: constraints.maxHeight,
          child: layout(estado, constraints));
    });
  }

  MaterialApp layout(Estado estado, constraint) {
    return MaterialApp(
      title: 'MicroNotes&Tags',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 56, 133)),
      ),
      home: Scaffold(
          body: Stack(
            children: [
              // Imagen de fondo
              Positioned.fill(
                child: Opacity(
                  opacity:
                      0.2, // Ajusta la opacidad para que actúe como una marca de agua
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250.0),
                    child: Image.asset(
                      'assets/notas.webp', // Ruta a tu imagen de fondo
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Contenido principal
              Center(
                child: home(),
              )
            ],
          ),
          floatingActionButton: botonesFlotantes(estado)),
    );
  }
}
