import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ServiceCharacteristic extends StatefulWidget {
  final BluetoothCharacteristic characteristic;

  const ServiceCharacteristic({super.key, required this.characteristic});

  @override
  State<ServiceCharacteristic> createState() => _ServiceCharacteristicState();
}

class _ServiceCharacteristicState extends State<ServiceCharacteristic> {
  String _value = "";

  List<Widget> _makeButtonContainer() {
    List<Widget> buttonContainers = <Widget>[];

    if (widget.characteristic.properties.write) {
      buttonContainers.add(
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Write"),
          ),
        ),
      );
    }
    if (widget.characteristic.properties.read) {
      buttonContainers.add(
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              var sub = widget.characteristic.value.listen((value) {
                // remove trailing zeroes
                var filteredList =
                    value.where((element) => element != 0).toList();
                setState(() {
                  _value = String.fromCharCodes(filteredList);
                });
              });

              await widget.characteristic.read();
              sub.cancel();
            },
            child: const Text("Read"),
          ),
        ),
      );
    }
    if (widget.characteristic.properties.notify) {
      buttonContainers.add(
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              if (!widget.characteristic.isNotifying) {
                widget.characteristic.value.listen((value) {
                  var v = ByteData.sublistView(
                          Uint8List.fromList(value.reversed.toList()))
                      .getUint32(0);
                  setState(() {
                    _value = v.toString();
                  });
                });
                await widget.characteristic.setNotifyValue(true);
              } else {
                await widget.characteristic.setNotifyValue(false);
              }
            },
            child: Text(widget.characteristic.isNotifying
                ? 'Stop notification'
                : 'Notify'),
          ),
        ),
      );
    }

    return buttonContainers;
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom:
              BorderSide(color: Color.fromARGB(134, 187, 186, 186), width: 0.5),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: [Text(widget.characteristic.uuid.toString())],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Row(
                children: [
                  Text("Value: $_value"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _makeButtonContainer(),
            ),
          ],
        ),
      ),
    ));
  }
}
