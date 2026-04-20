import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool showEditProfile = false;
  bool showChangePassword = false;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🔥 SCROLLABLE CONTENT
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                radius: const Radius.circular(10),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [

                      /// 👤 PROFILE IMAGE
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "User Name",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "+91 9999999999",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 EDIT PROFILE
                      _buildExpandableTile(
                        icon: Icons.person,
                        title: "Edit Profile",
                        isExpanded: showEditProfile,
                        onTap: () {
                          setState(() {
                            showEditProfile = !showEditProfile;
                          });
                        },
                        child: Column(
                          children: [
                            _buildField("First Name"),
                            _buildField("Last Name"),
                            _buildField("Phone Number"),
                            _buildField("Email Address"),
                            _buildField("Address"),
                          ],
                        ),
                      ),

                      /// 🔹 CHANGE PASSWORD
                      _buildExpandableTile(
                        icon: Icons.lock,
                        title: "Change Password",
                        isExpanded: showChangePassword,
                        onTap: () {
                          setState(() {
                            showChangePassword = !showChangePassword;
                          });
                        },
                        child: Column(
                          children: [
                            _buildField("Current Password", isPassword: true),
                            _buildField("New Password", isPassword: true),
                            _buildField("Confirm Password", isPassword: true),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔴 LOGOUT BUTTON (ALWAYS FIXED)
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 EXPANDABLE TILE
  Widget _buildExpandableTile({
    required IconData icon,
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [

          ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(Icons.keyboard_arrow_down),
            ),
            onTap: onTap,
          ),

          /// 🔥 ANIMATED EXPAND
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: Padding(
              padding: const EdgeInsets.all(12),
              child: child,
            ),
            crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  /// 🔧 INPUT FIELD
  Widget _buildField(String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}