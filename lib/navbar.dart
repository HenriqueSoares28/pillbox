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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 0, 0, 0),
        shape: const CircularNotchedRectangle(),
        elevation: 0, // Set elevation to zero to remove shadow
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PagEdit()),
                    );
                  },
                  icon: const Icon(
                    Icons.mode_edit,
                    color: Colors.white,
                    size: 40,
                  ),
                  tooltip: 'Editar',
                ),
                
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PagPrincipal()),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 40,
                  ),
                  tooltip: 'Notificações',
                ),
                
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 90, // Ajuste o tamanho conforme necessário
        height: 90, // Ajuste o tamanho conforme necessário
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PagPrincipal()),
            );
          },
          backgroundColor: const Color.fromARGB(255, 8, 6, 8), // Cor do botão
          mini: false,
          shape: const CircleBorder(),
          materialTapTargetSize: MaterialTapTargetSize.padded, // Define se o botão é mini ou não (false para tamanho normal)
          child: Image.asset(
            '/home/lloures/Documentos/GitHub/bookbox2/pillbox/imagens/Logo.png',
            width: 50, // Tamanho da imagem
            height: 50, // Tamanho da imagem
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
