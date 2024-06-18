import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pillbox/horas.dart';
import 'package:pillbox/navbar.dart';
import 'package:pillbox/visualizarRemedio.dart';
import 'package:pillbox/helper/database_helper.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert';
import 'dart:async';
import 'package:logger/logger.dart';

// Configurar o logger
final logger = Logger();

class PagPrincipal extends StatefulWidget {
  PagPrincipal({Key? key}) : super(key: key);

  @override
  _PagPrincipalState createState() => _PagPrincipalState();
}

class _PagPrincipalState extends State<PagPrincipal> {
  bool _showOverlay = false;
  int _currentCompartment = 1;
  String _remedyName = '';
  String _schedule = '';
  String _days = '';

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BluetoothDevice? _connectedDevice;
  BluetoothConnection? _connection;
  bool isConnecting = false;
  bool isConnected = false;

  final Map<String, String> colors = {
    'Vermelho': '1',
    'Verde': '2',
    'Azul': '3',
    'Amarelo': '4',
    'Ciano': '5',
    'Magenta': '6',
    'Laranja': '7',
    'Branco': '8',
  };

  @override
  void initState() {
    super.initState();
    // Iniciar a conexão Bluetooth
    _initializeBluetoothConnection();
  }

  void _initializeBluetoothConnection() {
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
      if (state == BluetoothState.STATE_ON) {
        _getPairedDevices();
      } else {
        logger.w('Bluetooth is not enabled');
      }
    });

    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
      if (state == BluetoothState.STATE_ON) {
        _getPairedDevices();
      } else {
        logger.w('Bluetooth state changed to ${state.toString()}');
      }
    });
  }

  void _getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      logger.i('Paired devices: ${devices.map((d) => d.name).toList()}');
      _autoConnectHC06(devices);
    } catch (e) {
      logger.e("Error getting paired devices: $e");
    }
  }

  void _autoConnectHC06(List<BluetoothDevice> devices) {
    for (var device in devices) {
      if (device.name == 'HC-06') {
        _connectToDevice(device);
        break;
      }
    }
  }

  void _connectToDevice(BluetoothDevice device) async {
    setState(() {
      isConnecting = true;
    });

    logger.i('Attempting to connect to ${device.name}');

    await BluetoothConnection.toAddress(device.address).then((_connection) {
      logger.i('Connected to the device');
      setState(() {
        _connectedDevice = device;
        this._connection = _connection;
        isConnected = true;
        isConnecting = false;
      });

      _connection.input?.listen(null).onDone(() {
        logger.i('Disconnected by remote request');
        setState(() {
          isConnected = false;
        });
        // Try to reconnect
        _connectToDevice(device);
      });

      _startMedicationSchedule(); // Inicia o agendamento dos remédios
    }).catchError((error) {
      logger.e('Cannot connect, exception occurred', error);
      setState(() {
        isConnecting = false;
      });
      // Retry connection after a delay
      Future.delayed(Duration(seconds: 5), () {
        _connectToDevice(device);
      });
    });
  }

  void _sendColorCommand(String command) async {
    if (_connection == null || !isConnected) {
      logger.w("No connection or not connected");
      return;
    }
    try {
      _connection!.output.add(utf8.encode(command + "\r\n"));
      await _connection!.output.allSent;
      logger.i('Command sent: $command');
    } catch (e) {
      logger.e("Failed to send command: $e");
    }
  }

  void _disconnectFromDevice() async {
    if (_connection != null) {
      await _connection!.close();
      setState(() {
        _connectedDevice = null;
        _connection = null;
        isConnected = false;
      });
      logger.i('Disconnected from device');
    }
  }

  void _startMedicationSchedule() {
    Timer.periodic(Duration(minutes: 1), (timer) async {
      List<Map<String, dynamic>> remedios = await DatabaseHelper().getRemedios();
      String currentDay = _getCurrentDay();
      String currentTime = _getCurrentTime();

      logger.i('Checking medications for $currentDay at $currentTime');

      for (var remedy in remedios) {
        logger.i('Checking remedy: ${remedy['name']} at ${remedy['time']} on ${remedy['days']}');
        if (remedy['days'].contains(currentDay) && remedy['time'] == currentTime) {
          logger.i('Time to take medication: ${remedy['name']}');
          _sendColorCommand(colors['Vermelho']!);  // Ajuste a cor ou comando conforme necessário
        }
      }
    });
  }

  String _getCurrentDay() {
    DateTime now = DateTime.now();
    switch (now.weekday) {
      case 1:
        return 'Segunda';
      case 2:
        return 'Terça';
      case 3:
        return 'Quarta';
      case 4:
        return 'Quinta';
      case 5:
        return 'Sexta';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _loadRemedyData(int compartmentNumber) async {
    final remedy = await DatabaseHelper().getRemedyByCompartment(compartmentNumber);
    setState(() {
      _currentCompartment = compartmentNumber;
      _remedyName = remedy['name'];
      _schedule = remedy['time'];
      _days = remedy['days'];
      _showOverlay = true;
    });
  }

  void _closeOverlay() {
    setState(() {
      _showOverlay = false;
    });
  }

  @override
  void dispose() {
    _disconnectFromDevice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 255, 249, 226),
      bottomNavigationBar: const Navbar(),
      body: Stack(
        children: [
          // Image background
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(0, 0, 0, 0), // Cor da borda
                  width: 2, // Largura da borda
                ),
              ),
              child: Image.asset(
                'imagens/Cartela2.png',
                width: 650,
                height: 325,
              ),
            ),
          ),
          // Texto com borda nas laterais em cima da imagem
          const Positioned(
            top: 50, // Posição do texto ajustada para baixo
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: HorasAoVivo(),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: _showOverlay,
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: OvalWidget(
                  compartmentNumber: _currentCompartment.toString(),
                  remedyName: _remedyName,
                  schedule: _schedule,
                  days: _days,
                  onClose: _closeOverlay,
                ),
              ),
            ),
          ),
          // Stack of buttons positioned in a circle
          Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(8, (index) {
                  final double angle = (2 * pi * index / 8) - (pi / 8); // Ajuste do ângulo inicial
                  const double radius = 115; // Adjust radius as needed

                  // Ajuste para garantir que os índices correspondam aos compartimentos
                  int compartmentNumber = (index + 1) % 8 + 1;

                  double buttonX = screenWidth / 2 + radius * cos(angle);
                  double buttonY = screenHeight / 2 + radius * sin(angle);

                  return Positioned(
                    left: buttonX - 40, // Adjust button size
                    top: buttonY - 40, // Adjust button size
                    child: ElevatedButton(
                      onPressed: _showOverlay
                          ? null
                          : () {
                              _loadRemedyData(compartmentNumber);
                            },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent, // Cor do botão quando pressionado
                        elevation: 0, // Remove a sombra do botão
                        shape: const CircleBorder(), // Formato circular
                        minimumSize: const Size(50, 60), // Tamanho mínimo do botão
                      ),
                      child: const SizedBox(
                        width: 30,
                        height: 60,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
