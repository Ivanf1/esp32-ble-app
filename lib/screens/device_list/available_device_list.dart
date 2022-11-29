import 'package:flutter/material.dart';
import '../../types/types.dart';
import 'components/available_device_connection_detail.dart';

class AvailableDeviceList extends StatelessWidget {
  final StringCallback setDeviceName;

  const AvailableDeviceList({super.key, required this.setDeviceName});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      children: [
        AvailableDeviceConnectionDetails("Device name", "Device id",
            setSelectedDeviceName: setDeviceName),
        AvailableDeviceConnectionDetails("Device name", "Device id",
            setSelectedDeviceName: setDeviceName),
        AvailableDeviceConnectionDetails("Device name", "Device id",
            setSelectedDeviceName: setDeviceName),
      ],
    );
  }
}
