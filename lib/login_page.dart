import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Key to identify and manage the form state
  final _formKey = GlobalKey<FormState>();

  // Controllers to access the input values
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Show/hide password toggle
  bool _obscurePassword = true;

  // Function to validate form and navigate to dashboard
  void _login() {
    if (_formKey.currentState!.validate()) {
      // If form is valid, navigate to dashboard and pass the username
      Navigator.pushNamed(
        context,
        '/dashboard',
        arguments: _usernameController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FBN-themed background color
      backgroundColor: const Color(0xFF002147),

      // Top app bar with title
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFF002147),
      ),

      // Padding around the form
      body: Padding(
        padding: const EdgeInsets.all(20),

        // Form for username and password input
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Text(
                'Login to FBNMobile',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Username Input Field
              TextFormField(
                controller: _usernameController,
                decoration: _buildInputDecoration('Username'),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password Input Field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _buildInputDecoration('Password', isPassword: true),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  } else if (!value.contains(RegExp(r'[A-Za-z]'))) {
                    return 'Include at least one letter';
                  } else if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Include at least one number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB89C3E),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  InputDecoration _buildInputDecoration(
    String label, {
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white38),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFB89C3E)), // gold border
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white70,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            )
          : null,
    );
  }
}
