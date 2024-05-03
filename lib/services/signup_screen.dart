import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String _email = "";
  String _password = "";
  bool _showSuccessMessage = false;
  String? _errorMessage;

  void _handleSignUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      setState(() {
        _showSuccessMessage = true;
      });
      _emailController.clear();
      _passController.clear();
      print("User Registered: ${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
      print("Error During Registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _showSuccessMessage
                    ? Column(
                        children: [
                          Text(
                            "Congratulations, your account has been successfully created.",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text("Login"),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    errorText: _errorMessage,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Email";
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      _showSuccessMessage = false;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                      _errorMessage = null;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Password";
                    }
                    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
                    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
                    final hasDigits = RegExp(r'[0-9]').hasMatch(value);
                    final hasSpecialCharacters =
                        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

                    if (!hasUppercase) {
                      return "Password must contain at least one uppercase letter.";
                    }
                    if (!hasLowercase) {
                      return "Password must contain at least one lowercase letter.";
                    }
                    if (!hasDigits) {
                      return "Password must contain at least one digit.";
                    }
                    if (!hasSpecialCharacters) {
                      return "Password must contain at least one special character.";
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      _showSuccessMessage = false;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                      _showSuccessMessage = false;
                    });
                  },
                ),
                Column(
                  children: [
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _handleSignUp();
                        }
                      },
                      child: Text("Sign Up"),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do you have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
