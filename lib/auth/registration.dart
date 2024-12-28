import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wads/auth/loginpage.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  bool isLoading = false;
  bool otpSent = false;
  String verificationId = '';
  late PhoneAuthCredential phoneAuthCredential;

  // Function to register the user after OTP verification
  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      String email =
          mobileController.text + "@example.com"; // Placeholder email
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: 'your_password_here'); // Password setup

      // Save user info to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'name': nameController.text,
        'mobile': mobileController.text,
      });

      // Handle successful registration
    } on FirebaseAuthException catch (e) {
      // Handle error
      print(e.message);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to send OTP
  Future<void> sendOtp() async {
    setState(() {
      otpSent = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: mobileController.text.toString(),
      verificationCompleted: (PhoneAuthCredential credential) {
        // When verification is complete, sign in automatically
        FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException ex) {
        print(ex);
        // Handle verification failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ex.message ?? 'OTP verification failed'),
        ));
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID to use later
        setState(() {
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }

  // Function to verify OTP
  Future<void> verifyOtp() async {
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length == 4) {
      try {
        // Use the verificationId and the OTP to create a credential
        phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp);

        // Sign in with the phone credential
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

        // Register the user if OTP is correct
        await registerUser();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registration successful"),
        ));
      } on FirebaseAuthException catch (e) {
        // Handle invalid OTP or other errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid OTP. Please try again."),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid OTP."),
      ));
    }
  }

  // Resend OTP
  void resendOtp() {
    sendOtp();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("OTP resent! Please check your phone."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade100, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // UI Elements Overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title: Registration Text at the Top
                  Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.teal[800],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Name Field
                  _buildTextField(
                    controller: nameController,
                    label: "Full Name",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),

                  // Mobile Field
                  _buildTextField(
                    controller: mobileController,
                    label: "Mobile Number",
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),

                  // Send OTP Button
                  if (!otpSent)
                    ElevatedButton(
                      onPressed: sendOtp,
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.teal[600],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      ),
                      child: Text("Send OTP"),
                    ),
                  SizedBox(height: 20),

                  // OTP Fields (4 boxes)
                  if (otpSent) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: SizedBox(
                            width: 60,
                            child: TextField(
                              controller: otpControllers[index],
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.teal[600]!),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 3) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 30),
                  ],

                  // Loading indicator
                  if (isLoading)
                    CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  SizedBox(height: 30),

                  // Register Button
                  Visibility(
                    visible: otpSent,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : verifyOtp,
                      style: ElevatedButton.styleFrom(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.teal[600],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: Text(isLoading ? "Registering..." : "Register"),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Resend OTP option
                  if (otpSent)
                    TextButton(
                      onPressed: resendOtp,
                      child: Text("Resend OTP"),
                    ),

                  SizedBox(height: 20),

                  // Have an account? Login text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.teal[600]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom method to build TextField with modern styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.teal[600]),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.teal[600]!),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
