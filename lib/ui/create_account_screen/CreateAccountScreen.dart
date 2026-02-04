import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/material.dart';

import '../../widgets/social_button.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool agreedToTerms = false;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: ColorPrimary,),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: 20),
              Text(
                "Create account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: ColorPrimary,),
              ),
              SizedBox(height: 0),
              Text(
                "Join us and start chatting with AI",
                style: TextStyle(fontSize: 16, color: ColorPrimary,),
              ),
              SizedBox(height: 24),
              // Social buttons
              socialButton(
                icon: Icons.g_mobiledata,
                text: "Continue with Google",

              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 20),
              // Input fields
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person_outline, color: ColorPrimary,),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined,color: ColorPrimary, ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock_outline, color: ColorPrimary,),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock_outline,color: ColorPrimary,),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: agreedToTerms,
                    checkColor: ColorPrimary,
                    focusColor: ColorPrimary,
                    onChanged: (value) {
                      setState(() {
                        agreedToTerms = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: ColorPrimary),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: ColorPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Create Account button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [ColorPrimary, ColorSecandory],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      if (!agreedToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                              Text("Please agree to terms and policy")),
                        );
                        return;
                      }
                      // TODO: handle account creation
                    },
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
