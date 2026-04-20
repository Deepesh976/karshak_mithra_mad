import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> plan;

  const PaymentScreen({super.key, required this.plan});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  bool isPaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UPI Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// PLAN DETAILS
            Text(
              widget.plan["title"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "${widget.plan["price"]} • ${widget.plan["time"]}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            /// 🔥 QR IMAGE (replace later with real QR)
            Container(
              height: 220,
              width: 220,
              color: Colors.grey.shade300,
              child: const Center(child: Text("QR CODE")),
            ),

            const SizedBox(height: 20),

            const Text("Scan & Pay using UPI"),

            const SizedBox(height: 30),

            /// ✅ SIMULATE SUCCESS
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isPaid = true;
                });

                _showResultDialog(true);
              },
              child: const Text("I Have Paid"),
            ),

            const SizedBox(height: 10),

            /// ❌ SIMULATE FAILURE
            TextButton(
              onPressed: () {
                _showResultDialog(false);
              },
              child: const Text("Payment Failed"),
            ),

          ],
        ),
      ),
    );
  }

  void _showResultDialog(bool success) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(success ? "Success ✅" : "Failed ❌"),
        content: Text(
          success
              ? "Recharge Successful!"
              : "Payment Failed. Try again.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog

              if (success) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                      (route) => false,
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}