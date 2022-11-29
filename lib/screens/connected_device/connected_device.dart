import 'package:esp32_ble_mqtt_app/screens/connected_device/components/service_characteristic.dart';
import 'package:flutter/material.dart';

class ConnectedDevice extends StatelessWidget {
  final VoidCallback disconnectFromDevice;

  const ConnectedDevice({super.key, required this.disconnectFromDevice});

  List<Widget> _buildServicesView() {
    final List<Widget> services = <Widget>[];
    for (int service = 0; service < 2; service++) {
      List<Widget> characteristics = <Widget>[];

      for (int characteristic = 0; characteristic < 5; characteristic++) {
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
            child: const ServiceCharacteristic(
              isNotifiable: true,
              isReadable: true,
              isWritable: true,
              characteristicUUUID: "bleaasdg",
            ),
          ),
        );
      }

      services.add(
        ExpansionTile(
          title: const Text("Service UUID"),
          children: [...characteristics],
        ),
      );
    }

    services.add(
      Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ElevatedButton(
          onPressed: () => disconnectFromDevice(),
          child: const Text("Disconnect"),
        ),
      ),
    );

    return services;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildServicesView(),
    );
  }
}
