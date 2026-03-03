import '../../model/login_model.dart';
import '../../routes/routes_name.dart';
import '../../ui/login_screen/login_screen_viewmodel.dart';
import '../../utilities/colors.dart';
import '../../utilities/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utilities/hive/user_hive_model.dart';
import '../../widgets/social_button.dart';


class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginScreen();

}

class _LoginScreen extends State {


   TextEditingController _emailController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();
   var  box =Hive.box<UserHiveModel>('userBox');
   bool _isLoading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(

            height: MediaQuery.of(context).size.height-50,


            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  const SizedBox(height: 10),


                  SizedBox(
                    height: 110,
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset("assets/images/logo_nobg.png",
                            width: 300,),
                        ),
                       const SizedBox(height: 10,),
                        Container(

                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: ColorSecandory,
                          ),
                          child: Text(
                            'The Lonely Entrepreneure is the solution for every entrepreneur. Our resrouces save your time, money and pain.',
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
                          controller: _emailController ,
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
                          controller: _passwordController,
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
                          child: _isLoading?Center(child: CircularProgressIndicator(color: Colors.white,)): Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {

                                if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                  try {

                                    if (!mUtils.isValidEmail(_emailController.text)){
                                      mUtils.toastMessage("Enter valid email");
                                      return ;
                                    }
                                    print ("emails is ${mUtils.isValidEmail(_emailController.text)}");
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    var resposne = await LoginScreenViewmodel()
                                        .UserLogin({
                                      "email": _emailController.text,
                                      "password": _passwordController.text
                                    });
                                    if (resposne != null) {
                                      if (kDebugMode) {
                                        print(resposne.code);
                                      }
                                      if (resposne.code == 200) {
                                        final user = UserHiveModel(
                                          userId: resposne.data["user_id"],
                                          email: resposne.data["user_email"],
                                          userName: resposne.data["user_name"],
                                          subscriptionId: int.parse( resposne
                                              .data["subscription_type"].toString()),
                                          subscriptionInTokenAllowed: 0,
                                          subscriptionOutTokenAllowed: 0,
                                          userInToken: 0,
                                          userOutToken: 0,
                                          token: resposne
                                              .data["token"]["access_token"],
                                          subscriptionFriendlyName: resposne
                                              .data["subscription_type_name"],
                                        );
                                        await box.put('currentUser', user);


                                        Navigator.pushNamed(
                                            context, RouteNames.ChatScreen);
                                      } else {
                                        mUtils.toastMessage(
                                            resposne.message + "0x00001");
                                      }
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }catch(ex){
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    mUtils.toastMessage(ex.toString() +"    loginscree 0*00001");
                                  }
                                  }else {
                                  mUtils.toastMessage("Please fill all required fields");
                                }


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
                            onPressed: () {


                              Navigator.pushNamed(context, RouteNames.CreateAccountScreen);},
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
        ),
      ),
    );
  }

}
