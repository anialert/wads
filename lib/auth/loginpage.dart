import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController _mobileController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController(); 
  bool _isLoading = false;  // For handling loading state during login

  // Validation logic for mobile number
  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    return null;
  }

  // Validation logic for password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Show loading indicator while submitting
      });

      // Simulate a delay for login process (e.g., API call)
      await Future.delayed(Duration(seconds: 2));

      // Perform the login logic (mock success for now)
      setState(() {
        _isLoading = false; // Stop the loading indicator
      });

      // If successful, you can navigate to the home screen or perform other actions
      print('Form is valid, login successful!');
    } else {
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Removing the title from the AppBar
        appBar: AppBar(
          backgroundColor: Colors.teal[50],  // Light green background for the AppBar
          elevation: 0, 
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Light background with a gradient shade for depth
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade100, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // UI elements overlay
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 100, 40, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title: Centering "Login" text
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.teal[900],  // Dark teal for a classy look
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Mobile Number TextField with light theme
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Mobile Number
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: TextFormField(
                              controller: _mobileController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,  // Light grey for the field background
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.teal[600]!),
                                ),
                                labelText: "Mobile Number",
                                labelStyle: TextStyle(color: Colors.teal[600]),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: _validateMobile,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Password TextField with light theme
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,  // Light grey for the field background
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.teal[600]!),
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.teal[600]),
                              ),
                              obscureText: true,
                              validator: _validatePassword,
                            ),
                          ),
                          SizedBox(height: 40),
                          // Login Button
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(5),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              backgroundColor: MaterialStateProperty.all(Colors.teal[600]),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              fixedSize: MaterialStateProperty.all(Size(double.infinity, 55)),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Login", style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
