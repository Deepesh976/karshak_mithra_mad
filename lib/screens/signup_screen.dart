import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  void signup() {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account Created")),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [

            /// 🌄 BACKGROUND
            Positioned.fill(
              child: Image.asset(
                'assets/bg.jpg',
                fit: BoxFit.cover,
              ),
            ),

            /// 🌑 OVERLAY
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),

            /// 🔝 HEADER
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      ClipOval(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Join Smart Pump Control",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔥 FORM CARD
            AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(bottom: keyboardHeight),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),

                  /// ✅ CLEAN STRUCTURE
                  child: Column(
                    children: [

                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// 🔥 SCROLLABLE FIELDS
                      Expanded(
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          thickness: 5,
                          radius: const Radius.circular(10),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [

                                _buildField("First Name", Icons.person, firstNameController),
                                const SizedBox(height: 10),

                                _buildField("Last Name", Icons.person_outline, lastNameController),
                                const SizedBox(height: 10),

                                _buildField("Phone Number", Icons.phone, phoneController, type: TextInputType.phone),
                                const SizedBox(height: 10),

                                _buildField("Email Address", Icons.email, emailController, type: TextInputType.emailAddress),
                                const SizedBox(height: 10),

                                _buildField("Address", Icons.location_on, addressController),
                                const SizedBox(height: 10),

                                _buildField("Password", Icons.lock, passwordController, isPassword: true),
                                const SizedBox(height: 10),

                                _buildField("Confirm Password", Icons.lock_outline, confirmPasswordController, isPassword: true),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// 🔵 BUTTON
                      GestureDetector(
                        onTap: signup,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF2F80ED),
                                Color(0xFF56CCF2),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Already have an account? Login"),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, TextEditingController controller,
      {bool isPassword = false, TextInputType type = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}