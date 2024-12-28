import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignUpOrLoginPage(),
  ));
}

class SignUpOrLoginPage extends StatefulWidget {
  @override
  _SignUpOrLoginPageState createState() => _SignUpOrLoginPageState();
}

class _SignUpOrLoginPageState extends State<SignUpOrLoginPage> {
  bool isLogin = true; // Track whether it's login or sign up
  bool isLoading = false;
  
  // Text controllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Handle user login
  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged in successfully!")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed: ${e.message}")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Handle user sign up
  Future<void> signUpUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign Up successful!")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign Up failed: ${e.message}")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Sign Up"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: isLogin ? loginUser : signUpUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    ),
                    child: Text(
                      isLogin ? "Login" : "Sign Up",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Login",
                style: TextStyle(color: Colors.teal, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
