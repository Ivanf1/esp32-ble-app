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
      title: 'ESP32 BLE MQTT',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonTheme:
              ButtonThemeData(colorScheme: Theme.of(context).colorScheme)),
      home: MyHomePage(title: 'ESP32 BLE MQTT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BluetoothDevice? connectedDevice;

  void setConnectedDevice(BluetoothDevice? deviceName) {
    setState(() {
      connectedDevice = deviceName;
    });
  }

  void disconnectFromDevice() async {
    await connectedDevice!.disconnect();
    setState(() {
      connectedDevice = null;
    });
  }

  Widget _buildView() {
    if (connectedDevice != null) {
      return ConnectedDevice(
        disconnectFromDevice: disconnectFromDevice,
        device: connectedDevice!,
      );
    } else {
      return AvailableDeviceList(
        setDevice: setConnectedDevice,
        flutterBlue: widget.flutterBlue,
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
