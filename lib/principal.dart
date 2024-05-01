import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pillbox/horas.dart';
import 'package:pillbox/navbar.dart';
import 'dart:math' as math;
import 'package:pillbox/visualizarRemedio.dart';

// Variável global para controlar a visibilidade do contêiner

class PagPrincipal extends StatelessWidget {
  const PagPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: 'principal',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(245, 255, 249, 226),
        bottomNavigationBar: const Navbar(),
        body: Stack(
          children: [
            // Image background
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(0, 0, 0, 0), // Cor da borda
                    width: 2, // Largura da borda
                  ),
                ),
                child: Image.asset(
                  '/home/lloures/Documentos/GitHub/bookbox2/pillbox/imagens/Cartela.png',
                  width: 650,
                  height: 325,
                ),
              ),
            ),
            // Texto com borda nas laterais em cima da imagem
            const Positioned(
              top: 50, // Posição do texto ajustada para baixo
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: HorasAoVivo(),
                ),
              ),
            ),
            // Stack of buttons positioned in a circle
            Center(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(8, (index) {
                    final double angle = (2 * pi * index / 8) - (pi / 8); // Ajuste do ângulo inicial
                    const double radius = 120; // Adjust radius as needed

                    double buttonX = screenWidth / 2 + radius * cos(angle);
                    double buttonY = screenHeight / 2 + radius * sin(angle);

                    return Positioned(
                      left: buttonX - 40, // Adjust button size
                      top: buttonY - 40, // Adjust button size
                      child: ElevatedButton(
                        onPressed: () {
                          // Abra o contêiner de visualização de remédio
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const VisualizarRemedio()), // Certifique-se de ter o VisualizarRemedio implementado corretamente
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(82, 244, 67, 54), // Cor inicial
                          shape: const CircleBorder(), // Formato circular
                          minimumSize: const Size(80, 80), // Tamanho mínimo do botão
                        ),
                        child: null,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
