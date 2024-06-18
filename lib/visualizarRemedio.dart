import 'package:flutter/material.dart';

class OvalWidget extends StatelessWidget {
  final String compartmentNumber;
  final String remedyName;
  final String schedule;
  final String days;
  final VoidCallback onClose;

  const OvalWidget({
    Key? key,
    required this.compartmentNumber,
    required this.remedyName,
    required this.schedule,
    required this.days,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 1.3,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 11, 11, 11),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 50,
              ),
              onPressed: onClose,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            compartmentNumber,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            remedyName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'HORÁRIO:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            schedule,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'DIAS:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            days,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 1),
        ],
      ),
    );
  }
}
