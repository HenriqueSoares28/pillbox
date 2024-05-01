import 'package:flutter/material.dart';
import 'package:pillbox/editar.dart';
import 'package:pillbox/principal.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

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
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      currentIndex: index,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.white,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/editar.');
        }
        if (index == 1) {
          Navigator.pushReplacementNamed(context, '/editar');
        }
        if (index == 2) {
          Navigator.pushReplacementNamed(context, '/editar');
        }
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.mode_edit,
            color: Colors.white,
            size: 40,
          ),
          label: 'Editar',
        ),
        BottomNavigationBarItem(
          activeIcon: NavBarIconButton(
            onPressed: () {
              // Handle button press action
            },
          ),
          icon: NavBarIconButton(
            onPressed: () {
              // Handle button press action
            },
          ),
          label: 'Menu',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: 40,
          ),
          label: 'Configurar',
        ),
      ],
    );
  }
}

class NavBarIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NavBarIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 8, 8, 8),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          '/home/lloures/Documentos/GitHub/bookbox2/pillbox/imagens/Logo.png', // Imagem do botão central
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
