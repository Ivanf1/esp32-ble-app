import 'package:esp32_ble_mqtt_app/screens/connected_device/components/service_characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectedDevice extends StatefulWidget {
  final VoidCallback disconnectFromDevice;
  final BluetoothDevice device;

  const ConnectedDevice(
      {super.key, required this.disconnectFromDevice, required this.device});

  @override
  State<ConnectedDevice> createState() => _ConnectedDeviceState();
}

class _ConnectedDeviceState extends State<ConnectedDevice> {
  List<BluetoothService> _services = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Widget>> _buildServicesView() async {
    final List<Widget> serviceContainers = <Widget>[];
    _services = await widget.device.discoverServices();

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
          onPressed: () => widget.disconnectFromDevice(),
          child: const Text("Disconnect"),
        ),
      ),
    );

    return Future.value(serviceContainers);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder<List<Widget>>(
          future: _buildServicesView(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: snapshot.data,
              );
            }
          },
        )
      ],
    );
  }
}
