import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(11, 15, 15, 15),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.mode_edit,
            color: Colors.white,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          activeIcon: Image.asset(
          'imagens/LogoAtivo.png',
           width: 30,
           ),
           icon: Image.asset(
          'imagens/Logo.png',
          width: 30,
          ),
  ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
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
          borderRadius: BorderRadius.circular(30),
        ),
        child: Image.asset(
          'imagens/Logo.png', // Imagem do botão central
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
