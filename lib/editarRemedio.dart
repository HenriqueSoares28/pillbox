import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pillbox/horas.dart';
import 'package:pillbox/navbar.dart';
import 'dart:math' as math;

import 'package:pillbox/principal.dart';

class editarRemedio extends StatelessWidget {
  const editarRemedio({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}

class EditarRemedio extends StatelessWidget {
  const EditarRemedio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
              size: 50,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromARGB(255, 11, 11, 11),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: const Color.fromARGB(245, 255, 249, 226),
              borderRadius: BorderRadius.circular(150),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'NOME DO REMÉDIO:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'DIAS:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'VEZES POR DIA:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '1,2...',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'PILULAS POR VEZ:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '1,2...',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'HORÁRIO:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '00:00',
                          ),
                        ),
                      ),
                    
                      IconButton(
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 80,
                        ),
                        onPressed: () {
                          // Abra o contêiner de visualização de remédio
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PagPrincipal()), // Certifique-se de ter o VisualizarRemedio implementado corretamente
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
