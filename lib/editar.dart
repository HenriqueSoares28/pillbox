import 'package:flutter/material.dart';
import 'package:pillbox/editar_remedio.dart';
import 'package:pillbox/navbar.dart';
import 'dart:math' as math;

class PagEdit extends StatelessWidget {
  const PagEdit({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: 'Editar Remédio',
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
                  'imagens/Cartela.png',
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
                  child: Text(
                    'SELECIONE UM COMPARTIMENTO PARA ADICIONAR OU DELETAR UM REMÉDIO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(8, (index) {
                    final double angle = (2 * math.pi * index / 8) - (math.pi / 8); // Ajuste do ângulo inicial
                    const double radius = 115; // Adjust radius as needed

                    double buttonX = screenWidth / 2 + radius * math.cos(angle);
                    double buttonY = screenHeight / 2 + radius * math.sin(angle);

                    return Positioned(
                      left: buttonX - 40, // Adjust button size
                      top: buttonY - 40, // Adjust button size
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditarRemedio(compartmentNumber: (index + 1) % 8 + 1)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(47, 20, 68, 128),
                          backgroundColor: const Color.fromARGB(0, 0, 0, 0), // Cor do botão quando pressionado
                          shape: const CircleBorder(), // Formato circular
                          minimumSize: const Size(50, 60), // Tamanho mínimo do botão
                        ),
                        child: const SizedBox(
                          width: 30,
                          height: 60,
                        ),
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
