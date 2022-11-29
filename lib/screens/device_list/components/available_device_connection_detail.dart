import 'package:flutter/material.dart';

import '../../../types/types.dart';

class AvailableDeviceConnectionDetails extends StatelessWidget {
  final String _name;
  final String _id;

  final StringCallback setSelectedDeviceName;

  const AvailableDeviceConnectionDetails(this._name, this._id,
      {super.key, required this.setSelectedDeviceName});

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      height: 60,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Color.fromARGB(134, 187, 186, 186), width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name),
                Text(_id),
              ],
            ),
            TextButton(
                onPressed: () => {setSelectedDeviceName(_name)},
                child: const Text("Connect"))
          ],
        ),
      ),
    ));
  }
}
