import 'package:flutter/material.dart';

class ServiceCharacteristic extends StatefulWidget {
  final bool isWritable;
  final bool isReadable;
  final bool isNotifiable;
  final String characteristicUUUID;

  const ServiceCharacteristic(
      {super.key,
      required this.isWritable,
      required this.isReadable,
      required this.isNotifiable,
      required this.characteristicUUUID});

  @override
  State<ServiceCharacteristic> createState() => _ServiceCharacteristicState();
}

class _ServiceCharacteristicState extends State<ServiceCharacteristic> {
  bool _isNotifying = false;
  String _value = "";

  void _updateValue(dynamic value) {
    _value = "$value";
  }

  List<Widget> _makeButtonContainer() {
    List<Widget> buttonContainer = <Widget>[];

    if (widget.isWritable) {
      buttonContainer.add(
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Write"),
          ),
        ),
      );
    }
    if (widget.isReadable) {
      buttonContainer.add(
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Read"),
          ),
        ),
      );
    }
    if (widget.isNotifiable) {
      buttonContainer.add(
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isNotifying = !_isNotifying;
              });
            },
            child: Text(_isNotifying ? 'Stop notification' : 'Notify'),
          ),
        ),
      );
    }

    return buttonContainer;
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
                children: [Text(widget.characteristicUUUID)],
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
