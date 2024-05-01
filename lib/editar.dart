import 'package:flutter/material.dart';
import 'package:pillbox/navbar.dart';
import 'dart:math' as math; // Adicionando o apelido 'math' para o pacote dart:math

class PagEdit extends StatelessWidget {
  const PagEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editar',
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
                  child: Text(
                    'SELECIONE UM COMPARTIMENTO PARA ADICIONAR OU DELETAR UM REMEDIO',
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
            // Stack of buttons positioned in a circle
            Stack(
              children: List.generate(8, (index) {
                final double angle = 2 * math.pi * index / 8;
                const double radius = 75; // Adjust radius as needed

                return Positioned(
                  left: radius * math.cos(angle) + 100, // Offset by image padding
                  top: radius * math.sin(angle) + 100, // Offset by image padding
                  child: GestureDetector(
                    child: Container(
                      width: 40, // Adjust button size as needed
                      height: 40, // Adjust button size as needed
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
