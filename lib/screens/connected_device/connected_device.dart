import 'package:esp32_ble_mqtt_app/screens/connected_device/components/service_characteristic.dart';
import 'package:esp32_ble_mqtt_app/types/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectedDevice extends StatefulWidget {
  final BluetoothDeviceCallback disconnectFromDevice;
  final BluetoothDevice device;

  const ConnectedDevice(
      {super.key, required this.disconnectFromDevice, required this.device});

  @override
  State<ConnectedDevice> createState() => _ConnectedDeviceState();
}

class _ConnectedDeviceState extends State<ConnectedDevice> {
  List<BluetoothService> _services = [];

  @override
  void initState() async {
    super.initState();
    _services = await widget.device.discoverServices();
  }

  void _disconnectDevice() {
    widget.disconnectFromDevice(widget.device);
  }

  List<Widget> _buildServicesView() {
    final List<Widget> serviceContainers = <Widget>[];

    for (BluetoothService service in _services) {
      List<Widget> characteristics = <Widget>[];

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristics.add(
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(134, 187, 186, 186),
                  width: 0.5,
                ),
              ),
            ),
            child: ServiceCharacteristic(
              characteristic: characteristic,
            ),
          ),
        );
      }

      serviceContainers.add(
        ExpansionTile(
          title: Text(service.uuid.toString()),
          children: [...characteristics],
        ),
      );
    }

    serviceContainers.add(
      Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ElevatedButton(
          onPressed: () => _disconnectDevice(),
          child: const Text("Disconnect"),
        ),
      ),
    );

    return serviceContainers;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildServicesView(),
    );
  }
}
