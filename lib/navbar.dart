import 'package:flutter/material.dart';
import 'package:pillbox/editar.dart';
import 'package:pillbox/principal.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int index = 1;
  final pages = [
    Container(
      color: Colors.black,
      child: const Center(
        child: Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    ),
    const PagPrincipal(),
    const PagEdit(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: index,
              children: pages,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color.fromARGB(255, 15, 15, 15),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.mode_edit,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        index = 0;
                      });
                    },
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        'imagens/Logo.png',
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {
                        // Handle button press action
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        index = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
