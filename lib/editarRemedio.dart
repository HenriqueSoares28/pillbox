import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pillbox/horas.dart';
import 'package:pillbox/navbar.dart';
import 'dart:math' as math;

import 'package:pillbox/principal.dart';

class EditarRemedio extends StatelessWidget {
  const EditarRemedio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(245, 255, 249, 226),
        appBar: AppBar(
          title: const Text('Remédio'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'NOME DO REMÉDIO:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                      // Suas propriedades do TextField aqui
                      ),
                ),
              ],
            ),
            new Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'DIAS:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                      // Suas propriedades do TextField aqui
                      ),
                ),
              ],
            ),
            new Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'VEZES POR DIA:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                      // Suas propriedades do TextField aqui
                      ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'PILULAS POR VEZ:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                      // Suas propriedades do TextField aqui
                      ),
                ),
              ],
            ),
            Text(
              'HORÁRIO:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
                // Suas propriedades do TextField aqui
                ),
            ElevatedButton(
              onPressed: () {
                // Abra o contêiner de visualização de remédio
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const PagPrincipal()), // Certifique-se de ter o VisualizarRemedio implementado corretamente
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(47, 20, 68, 128),
                backgroundColor: const Color.fromARGB(
                    0, 0, 0, 0), // Cor do botão quando pressionado
                shape: const CircleBorder(), // Formato circular
                minimumSize: const Size(50, 60), // Tamanho mínimo do botão
              ),
              child: const SizedBox(
                width: 30,
                height: 60,
              ),
            ),
          ],
        ));
  }
}
