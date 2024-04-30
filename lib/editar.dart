import 'package:flutter/material.dart';
import 'package:pillbox/navbar.dart';
import 'dart:math' as math; // Adicionando o apelido 'math' para o pacote dart:math

class PagPrincipal extends StatelessWidget {
  const PagPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editar',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(245, 241, 229, 181),
        bottomNavigationBar: const Navbar(),
        body: Stack(
          children: [
             const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Texto superior e centralizado',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(11, 15, 15, 15),
                  ),
                ),
              ),
            ),
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
