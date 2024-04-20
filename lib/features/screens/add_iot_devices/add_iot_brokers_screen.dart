import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/features/controllers/add_iot_devices_controller.dart';
import 'package:weathershare/features/screens/add_iot_devices/add_iot_devices_screen.dart';

class AddIoTBrokersScreen extends StatefulWidget {
  const AddIoTBrokersScreen({super.key});

  @override
  State<AddIoTBrokersScreen> createState() => _AddIoTBrokersScreenState();
}

class _AddIoTBrokersScreenState extends State<AddIoTBrokersScreen> {
  final controller = Get.put(IoTDevicesController());
  String?
      selectedBroker; // Nullable type to handle initial null condition properly

  List<String> brokers = [
    "",
    "Add New MQTT Broker"
  ]; // Include an empty string for a blank option

  @override
  void initState() {
    super.initState();
    loadBrokers();
  }

  void loadBrokers() async {
    var fetchedBrokers = await controller.fetchBrokerNames();
    setState(() {
      brokers = ["Add New MQTT Broker"] + fetchedBrokers.toSet().toList();
      brokers.insert(0, ""); // Insert a blank option at the start
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Add MQTT Broker",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultSize),
        child: Form(
          key: controller.iotDeviceFormKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedBroker,
                icon: const Icon(Icons.arrow_downward),
                decoration: const InputDecoration(
                  labelText: "Select Broker",
                  enabledBorder: OutlineInputBorder(),
                ),
                items: brokers.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child:
                        Text(value.isEmpty ? "Please select an option" : value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBroker = newValue ?? "";
                  });
                },
              ),
              const SizedBox(height: 16),
              if (selectedBroker == "Add New MQTT Broker") ...[
                TextFormField(
                  controller: controller.mqttHost,
                  decoration: const InputDecoration(
                    labelText: "MQTT Broker Host",
                    hintText: "e.g., mqtt.broker.org",
                    prefixIcon: Icon(Icons.link),
                  ),
                ),
                TextFormField(
                  controller: controller.mqttPort,
                  decoration: const InputDecoration(
                    labelText: "Port",
                    hintText: "e.g., 1883",
                    prefixIcon: Icon(Icons.settings_input_component),
                  ),
                ),
                TextFormField(
                  controller: controller.mqttUsername,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextFormField(
                  controller: controller.mqttPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.saveBrokerDetails();
                    // Optionally navigate to the next page if needed here
                  },
                  child: const Text("SAVE NEW BROKER"),
                ),
              ],
              if (selectedBroker?.isNotEmpty == true &&
                  selectedBroker != "Add New MQTT Broker")
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddIoTDevicesScreen(
                              initialBroker: selectedBroker!)),
                    );
                  },
                  child: const Text("NEXT"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}