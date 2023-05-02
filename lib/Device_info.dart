import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  WindowsDeviceInfo? windowsDeviceInfo;
  AndroidDeviceInfo? androidDeviceInfo;
  String ip = "";

  Future<WindowsDeviceInfo> getWindowsInfo() async {
    return await deviceInfo.windowsInfo;
  }

  Future<AndroidDeviceInfo> getAndroidInfo() async {
    return await deviceInfo.androidInfo;
  }

  Widget showCard(String name, String value) {
    return Card(
      child: ListTile(
        title: Text("$name: $value"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<WindowsDeviceInfo>(
      future: getWindowsInfo(),
      builder: (context, snapshot) {
        return Column(
          children: [
            showCard('Device Id', "${snapshot.data!.deviceId}"),
            showCard('Device Name', "${snapshot.data!.computerName}"),
//showCard('Device Model',"${snapshot.data!.}"),
            showCard('Network Ip', "${ip}"),

            TextButton(
                onPressed: () async {
                  final ipv4 = await Ipify.ipv4();
                  ip = ipv4;
                  setState(() {});
                },
                child: Text("Get Ip")),
          ],
        );
      },
    ));
  }
}
