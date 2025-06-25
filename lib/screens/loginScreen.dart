import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:gtr/provider/userProvider.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var key = GlobalKey<FormState>();
  bool isobscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void login() async {
    final provider = Provider.of<Userprovider>(context, listen: false);
    bool success = await provider.login(emailController.text, passController.text);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Login Successful!', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Wrong email or password', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var providers = Provider.of<Userprovider>(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667eea),
                Color(0xFF764ba2),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.08),
      
                    // Logo/Header Section
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/images/gtrLogo.png")
                        ),
                       const SizedBox(height: 24),
                       const Text(
                          'Welcome To gtr',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                       const SizedBox(height: 8),
                       const Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
      
                    SizedBox(height: size.height * 0.08),
      
                    // Login Form
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
      
                      ),
                      child: Form(
                        key: key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Email Field
                            TextFormField(
                              controller: emailController,
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "Enter your email",
                                labelText: "Email",
                                prefixIcon: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF667eea).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Color(0xFF667eea),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Color(0xFF667eea), width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red, width: 2),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red, width: 2),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
      
                            SizedBox(height: 20),
      
      
                            TextFormField(
                              obscureText: isobscure,
                              controller: passController,
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                                labelText: "Password",
                                prefixIcon: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF667eea).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:const Icon(
                                    Icons.lock_outline,
                                    color: Color(0xFF667eea),
                                  ),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isobscure = !isobscure;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    child: Icon(
                                      isobscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Color(0xFF667eea), width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red, width: 2),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red, width: 2),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
      
                            SizedBox(height: 32),
      
      
                            Container(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    login();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF667eea),
                                  foregroundColor: Colors.white,
      
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
      
                                ),
                                child:
                                   const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
      
      
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
