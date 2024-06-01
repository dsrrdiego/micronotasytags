// import 'package:flutter/material.dart';
// import 'package:notas/codigo/EstadoYToggles.dart';
// import 'package:notas/main.dart';
// import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:micronotasytags/codigo/EstadoYToggles.dart';
import 'package:provider/provider.dart';

Widget modalGrabando(estado, delta, constraints) {
  return estado.grabando
      ? Padding(
          padding: EdgeInsets.only(top:constraints.maxHeight*0.1),
          child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: delta * 0.4, left: delta * 0.1, right: delta * 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: delta * 0.2,
                          bottom: delta * 0.2,
                          left: delta * 0.4,
                          right: delta * 0.4),
                      child: Text(
                        'GRABANDO ! ! ! ',
                        style: TextStyle(
                            fontSize: delta * 0.4, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(delta * 0.5),
                      child: AnimatedButton(delta),
                    ),
                  ],
                ),
              )),
        )
      : Container();
}

class AnimatedButton extends StatefulWidget {
  var delta;
  AnimatedButton(delta){
    this.delta=delta;
  }
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState(delta);
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  var delta;
  _AnimatedButtonState(delta) {
    this.delta = delta;
  }
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = Provider.of<Estado>(context);

    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _colorAnimation.value, // Aquí se aplica el color animado
            padding: EdgeInsets.symmetric(
                horizontal: delta*0.25, vertical: delta*0.3), // Ajusta el padding del botón
          ),
          onPressed: estado.stop,
          child: Icon(
            Icons.stop,
            size: delta*1,
          ),
        );
      },
    );
  }
}
