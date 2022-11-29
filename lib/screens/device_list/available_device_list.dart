import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'components/available_device_connection_detail.dart';
import '../../types/types.dart';

class AvailableDeviceList extends StatefulWidget {
  final BluetoothDeviceCallback setDevice;
  final FlutterBlue flutterBlue;
  final List<BluetoothDevice> _devicesList = <BluetoothDevice>[];

  AvailableDeviceList(
      {super.key, required this.setDevice, required this.flutterBlue});

  @override
  State<AvailableDeviceList> createState() => _AvailableDeviceListState();
}

class _AvailableDeviceListState extends State<AvailableDeviceList> {
  void _addDeviceToList(final BluetoothDevice device) {
    if (!widget._devicesList.contains(device)) {
      setState(() {
        widget._devicesList.add(device);
      });
    }
  }

  void connectToDevice(final BluetoothDevice device) async {
    widget.flutterBlue.stopScan();

    try {
      await device.connect();
    } on PlatformException catch (e) {
      if (e.code != 'already_connected') {
        rethrow;
      }
    }

    widget.setDevice(device);
  }

  @override
  void initState() {
    super.initState();

    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceToList(device);
      }
    });

    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceToList(result.device);
      }
    });

    widget.flutterBlue.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      children: widget._devicesList
          .map(
            (device) => AvailableDeviceConnectionDetails("nameee", "iddddd",
                setSelectedDevice: connectToDevice, device: device),
          )
          .toList(),
    );
  }
}
