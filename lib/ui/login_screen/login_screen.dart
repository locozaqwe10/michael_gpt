import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/material.dart';

import '../../widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// Back button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                color: ColorPrimary,
              ),

              SizedBox(height: 10,),
              SizedBox(
                height: 110,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset("assets/images/logo_nobg.png",
                        width: 300,),
                    ),
                    SizedBox(height: 10,),
                    Container(

                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: ColorSecandory,
                      ),
                      child: Text(
                        'The Lonely Entrepreneure is the solution for every entrepreneur. Ourresrouces save your time, money and pain.',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                           
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 50,),
              /// Title
              Flexible(
                child: Column(
                  children: [
                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: ColorPrimary,
                      ),
                    ),

                    const SizedBox(height: 0),

                    const Text(
                      "Sign in to continue your conversations",
                      style: TextStyle(color: ColorPrimary),
                    ),

                    const SizedBox(height: 32),

                    /// Google button
                    socialButton(
                      icon: Icons.g_mobiledata,
                      text: "Continue with Google",

                    ),

                    const SizedBox(height: 12),


                    const SizedBox(height: 24),

                    /// OR Divider
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("or"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// Email field
                    TextField(
                      decoration: InputDecoration(
                        hintText: "your@email.com",
                        prefixIcon: const Icon(Icons.email_outlined, color: ColorPrimary,),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Password field
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline, color: ColorPrimary,),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: ColorSecandory),
                        ),
                      ),
                    ),

                    const Spacer(),

                    /// Sign in button
                    ///
                    ///
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
                            Navigator.pushNamed(context, RouteNames.ChatScreen);
                            // TODO: handle account creation
                          },
                          child:Center(
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight:  FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 24),

                    /// Sign up
                    Center(
                      child: TextButton(
                        onPressed: () {Navigator.pushNamed(context, RouteNames.CreateAccountScreen);},
                        child: const Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: ColorSecandory),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(color: ColorPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
                ],
              ),


        ),
      ),
    );
  }

}
