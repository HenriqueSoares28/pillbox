import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class HorasAoVivo extends StatefulWidget {
  const HorasAoVivo({Key? key}) : super(key: key);

  @override
  _HorasAoVivoState createState() => _HorasAoVivoState();
}

class _HorasAoVivoState extends State<HorasAoVivo> {
  late final StreamController<DateTime> _dateTimeController =
      StreamController<DateTime>();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    _dateTimeController.close();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (kDebugMode) {
        print('Adicionando evento ao stream: $now');
      }
      _dateTimeController.add(now);
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _dateTimeController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final dateTime = snapshot.data!;
          if (kDebugMode) {
            print('Recebido novo dado do stream: $dateTime');
          }
          return Text(
            DateFormat('HH:mm').format(dateTime),
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          );
        } else if (snapshot.hasError) {
          return const Text(
            'Erro ao carregar os dados',
            style: TextStyle(fontSize: 24, color: Colors.red),
          );
        } else {
          return const Text(
            'Carregando...',
            style: TextStyle(fontSize: 24),
          );
        }
      },
    );
  }
}
