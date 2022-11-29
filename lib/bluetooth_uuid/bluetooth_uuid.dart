final Map<String, String> _bluetoothUUIDToStringMap = {
  "0000180a": "Device Information",
  "00002a23": "System ID",
  "00002a24": "Model Number String",
  "00002a25": "Serial Number String",
  "00002a26": "Firmware Revision String",
  "00002a27": "Hardware Revision String",
  "00002a28": "Software Revision String",
  "00002a29": "Manufacturer Name String",
  "00002a2a": "IEEE 11073-20601 Regulatory Certification Data List",
  "00002a50": "PnP ID",
  "000000ff": "Analog Service",
  "0000ff01": "Analog Reading",
};

/// Maps the UUID of a Service or Characteristic to the corresponding String
/// representation.
/// String representations are only defined for a subset of UUID, specifically the
/// ones used by this application.
/// If [uuid] does not correspond to any defined String representation, [uuid]
/// is returned.
String bluetoothUUIDToString(String uuid) {
  String prefix = uuid.substring(0, 8);
  return _bluetoothUUIDToStringMap.containsKey(prefix)
      ? _bluetoothUUIDToStringMap[prefix]!
      : uuid;
}
