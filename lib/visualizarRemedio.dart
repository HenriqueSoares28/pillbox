import 'package:flutter/material.dart';

class OvalWidget extends StatelessWidget {
  const OvalWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        color: const Color.fromARGB(245, 255, 249, 226),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '1',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'NOME DO REMÉDIO',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'HORÁRIO:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'DIAS:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
