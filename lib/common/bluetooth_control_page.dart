import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert';
import 'package:logger/logger.dart'; // Import the logger package


class BluetoothControlPage extends StatefulWidget {
  @override
  _BluetoothControlPageState createState() => _BluetoothControlPageState();
}

class _BluetoothControlPageState extends State<BluetoothControlPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> _devicesList = [];
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

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _getPairedDevices();
  }

  void _getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        _devicesList = devices;
      });
      _autoConnectHC06(devices);
    } catch (e) {
      print("Error getting paired devices: $e");
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

    await BluetoothConnection.toAddress(device.address).then((_connection) {
      print('Connected to the device');
      setState(() {
        _connectedDevice = device;
        this._connection = _connection;
        isConnected = true;
        isConnecting = false;
      });

      _connection.input?.listen(null).onDone(() {
        print('Disconnected by remote request log');
        setState(() {
          isConnected = false;
        });
      });
    }).catchError((error) {
      print('Cannot connect, exception occurred log');
      print(error);
      setState(() {
        isConnecting = false;
      });
    });
  }


  void _sendColorCommand(String command) async {
    if (_connection == null || !isConnected) {
      Logger().w("No connection or not connected medication "); // Use the logger
      return;
    }
    try {
      _connection!.output.add(utf8.encode(command));
      await _connection!.output.allSent;
      Logger().i('Command sent: $command medication '); // Use the logger
    } catch (e) {
      Logger().e("Failed to send command medication : $e"); // Use the logger
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
    }
  }

  @override
  void dispose() {
    _disconnectFromDevice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de LEDs via Bluetooth'),
        actions: [
          if (_connectedDevice != null)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _disconnectFromDevice,
            ),
        ],
      ),
      body: isConnecting
          ? const Center(child: CircularProgressIndicator())
          : _connectedDevice == null
              ? _buildDeviceList()
              : _buildControlPanel(),
    );
  }

  Widget _buildDeviceList() {
    return ListView.builder(
      itemCount: _devicesList.length,
      itemBuilder: (context, index) {
        var device = _devicesList[index];
        return ListTile(
          title: Text(device.name ?? device.address),
          onTap: () => _connectToDevice(device),
        );
      },
    );
  }

  Widget _buildControlPanel() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: colors.keys.map((color) {
          return ElevatedButton(
            onPressed: () => _sendColorCommand(colors[color]!),
            child: Text(color),
          );
        }).toList(),
      ),
    );
  }
}
