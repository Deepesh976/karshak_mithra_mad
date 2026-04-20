import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'timer_screen.dart';
import 'setting_screen.dart';
import 'recharge_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const DashboardHome(),
    const TimerScreen(),
    const RechargeScreen(),
    const SettingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// 🔥 BODY SWITCHING
      body: screens[_selectedIndex],

      /// 🔥 BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Timer",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.next_plan),
            label: "Recharge",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// 🔥 DASHBOARD HOME (YOUR UI MOVED HERE)
////////////////////////////////////////////////////////

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {

  bool motorOn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🟢 START
            _buildBigButton(
              title: "Start Motor",
              icon: Icons.power_settings_new,
              color: Colors.green,
              onTap: () {
                setState(() => motorOn = true);
              },
            ),

            const SizedBox(height: 12),

            /// 🔴 STOP
            _buildBigButton(
              title: "Stop Motor",
              icon: Icons.cancel,
              color: Colors.red,
              onTap: () {
                setState(() => motorOn = false);
              },
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [

                  _buildStatusCard(
                    "Motor Status",
                    motorOn ? "ON" : "OFF",
                    Icons.power,
                    motorOn ? Colors.green : Colors.red,
                  ),

                  _buildStatusCard(
                    "Water Level",
                    "HIGH",
                    Icons.water_drop,
                    Colors.blue,
                  ),

                  _buildStatusCard(
                    "Power",
                    "Available",
                    Icons.flash_on,
                    Colors.orange,
                  ),

                  _buildStatusCard(
                    "Last Run",
                    "10:30 AM",
                    Icons.access_time,
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔵 BUTTON
  Widget _buildBigButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📊 STATUS CARD
  Widget _buildStatusCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}