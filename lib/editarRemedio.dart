import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pillbox/horas.dart';
import 'package:pillbox/navbar.dart';
import 'dart:math' as math;

class editarRemedio extends StatelessWidget {
  const editarRemedio({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    );
  }
}

class EditarRemedio extends StatelessWidget {
  const EditarRemedio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 255, 249, 226),
      appBar: AppBar(
        title: const Text('Hello World'),
      ),
      body: const Center(
        child: Text(
          'Hello World!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}