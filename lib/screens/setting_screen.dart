import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<_SettingItem> settings = [
    _SettingItem("Min Voltage", "V", 0, 300, 180),
    _SettingItem("Max Voltage", "V", 0, 300, 240),
    _SettingItem("Dry Run Current", "A", 0, 50, 10),
    _SettingItem("Dry Run Retry", "times", 0, 10, 3),
    _SettingItem("Over Current", "A", 0, 50, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: settings.length,
                itemBuilder: (context, index) {
                  return _buildSettingCard(settings[index]);
                },
              ),
            ),

            /// Submit Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  for (var s in settings) {
                    print("${s.label}: ${s.value} ${s.unit}");
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(_SettingItem item) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          /// Input Field
          TextField(
            controller: item.controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter ${item.label}",
              suffixText: item.unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (val) {
              double? newVal = double.tryParse(val);
              if (newVal != null &&
                  newVal >= item.min &&
                  newVal <= item.max) {
                setState(() {
                  item.value = newVal;
                });
              }
            },
          ),

          const SizedBox(height: 10),

          /// Slider
          Slider(
            value: item.value,
            min: item.min,
            max: item.max,
            divisions: 100,
            label: "${item.value.toInt()} ${item.unit}",
            onChanged: (val) {
              setState(() {
                item.value = val;
                item.controller.text = val.toInt().toString();
              });
            },
          ),
        ],
      ),
    );
  }
}

/// Model Class
class _SettingItem {
  final String label;
  final String unit;
  final double min;
  final double max;
  double value;

  late TextEditingController controller;

  _SettingItem(this.label, this.unit, this.min, this.max, this.value) {
    controller = TextEditingController(text: value.toInt().toString());
  }
}