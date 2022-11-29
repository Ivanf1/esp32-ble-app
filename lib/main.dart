import 'package:esp32_ble_mqtt_app/screens/connected_device/connected_device.dart';
import 'package:esp32_ble_mqtt_app/screens/device_list/available_device_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonTheme:
              ButtonThemeData(colorScheme: Theme.of(context).colorScheme)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _connectedDevice;

  void setConnectedDevice(String deviceName) {
    setState(() {
      _connectedDevice = deviceName;
    });
  }

  void disconnectFromDevice() {
    setState(() {
      _connectedDevice = null;
    });
  }

  Widget _buildView() {
    if (_connectedDevice != null) {
      return ConnectedDevice(
        disconnectFromDevice: disconnectFromDevice,
      );
    } else {
      return AvailableDeviceList(
        setDeviceName: setConnectedDevice,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildView(),
    );
  }
}
