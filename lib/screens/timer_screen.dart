import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  DateTime startTime = DateTime.now();
  DateTime stopTime = DateTime.now();

  String selectedMode = "One Time";

  /// 🔥 FORMAT TIME (AM/PM)
  String formatTime(DateTime time) {
    int hour = time.hour;
    String period = hour >= 12 ? "PM" : "AM";

    hour = hour % 12;
    if (hour == 0) hour = 12;

    String minute = time.minute.toString().padLeft(2, '0');

    return "$hour:$minute $period";
  }

  /// 🔥 TIME PICKER
  void openTimePicker(bool isStart) {
    DateTime tempTime = isStart ? startTime : stopTime;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Select Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  initialDateTime: tempTime,
                  onDateTimeChanged: (DateTime newTime) {
                    tempTime = newTime;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    setState(() {
                      if (isStart) {
                        startTime = tempTime;
                      } else {
                        stopTime = tempTime;
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Set Time"),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  /// ⏱ TIME CARD
  Widget buildTimeCard(String label, DateTime time, bool isStart) {
    return GestureDetector(
      onTap: () => openTimePicker(isStart),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
            Text(
              formatTime(time),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 🔘 MODE BUTTON
  Widget buildModeButton(String title) {
    bool isSelected = selectedMode == title;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedMode = title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// 🏗 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            buildTimeCard("Start Time", startTime, true),
            buildTimeCard("Stop Time", stopTime, false),

            const SizedBox(height: 25),

            Row(
              children: [
                buildModeButton("One Time"),
                buildModeButton("Repeated"),
              ],
            ),

            const Spacer(),

            /// 🔥 SUBMIT BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                // TODO: API call or logic
                print("Start: ${formatTime(startTime)}");
                print("Stop: ${formatTime(stopTime)}");
                print("Mode: $selectedMode");
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}