import '../../routes/routes_name.dart';
import '../../ui/create_account_screen/create_account_viewmodel.dart';
import '../../utilities/colors.dart';
import '../../utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as box;

import '../../data/api_urls.dart';
import '../../utilities/hive/user_hive_model.dart';
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
  final CreateAccountViewmodel createAccountViewmodel =
      CreateAccountViewmodel();
  bool _isLoading = false;
  var box = Hive.box<UserHiveModel>('userBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Column(
              children: [
                /* IconButton(
                  icon: Icon(Icons.arrow_back, color: ColorPrimary,),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 20),*/
                 SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create Account",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            SizedBox(height: 6),

                            Text(
                              "Create account to user MichealGPT",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 24),

                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _fullNameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: ColorPrimary,
                            ),
                            filled: true,
                            fillColor: SubColorSecandory,
                            hintStyle: TextStyle(color: Colors.white70),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: ColorPrimary,
                            ),
                            filled: true,
                            fillColor: SubColorSecandory,
                            hintStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: ColorPrimary,
                            ),
                            filled: true,
                            fillColor: SubColorSecandory,
                            hintStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: ColorPrimary,
                            ),
                            filled: true,
                            fillColor: SubColorSecandory,
                            hintStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white70),
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
                                  style: TextStyle(color: Colors.white70),
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
                          child: _isLoading
                              ? Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          )
                              : Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {
                                if (!agreedToTerms) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please agree to terms and policy",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                // TODO: handle account creation
                                if (_fullNameController.text.isNotEmpty &&
                                    _emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty &&
                                    _confirmPasswordController.text.isNotEmpty) {
                                  if (_confirmPasswordController.text ==
                                      _passwordController.text) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    var response = await createAccountViewmodel
                                        .createUser({
                                      "email": _emailController.text,
                                      "first_name": _fullNameController.text,
                                      "last_name": "",
                                      "password":
                                      _confirmPasswordController.text,
                                    });
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (response.code == 200) {
                                      final user = UserHiveModel(
                                        userId: response.data["user_id"],
                                        email: response.data["user_email"],
                                        userName: response.data["user_name"],
                                        subscriptionId: int.parse(
                                          response.data["subscription_type"]
                                              .toString(),
                                        ),
                                        subscriptionInTokenAllowed: 0,
                                        subscriptionOutTokenAllowed: 0,
                                        userInToken: 0,
                                        userOutToken: 0,
                                        token: response
                                            .data["token"]["access_token"],
                                        subscriptionFriendlyName: response
                                            .data["subscription_type_name"],
                                        imageUrl:
                                        ApiUrls.BASE_URL +
                                            response!.data["image_url"]
                                                .toString()
                                                .replaceFirst("/", ""),
                                        create_at: DateTime.parse(
                                          response.data["created_at"],
                                        ),
                                      );
                                      await box.put('currentUser', user);

                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.ChatScreen,
                                      );
                                    } else {
                                      mUtils.toastMessage(response.message);
                                    }
                                  } else {
                                    mUtils.toastMessage(
                                      "Password and confirm password does not match ",
                                    );
                                    return;
                                  }
                                } else {
                                  mUtils.toastMessage(
                                    "Please fill all the fields",
                                  );
                                  return;
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: SubColorSecandory,
                                    fontWeight: FontWeight.bold,
                                  ),
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


              ],
            ),
          ),
        ),
      ),
    );
  }
}
