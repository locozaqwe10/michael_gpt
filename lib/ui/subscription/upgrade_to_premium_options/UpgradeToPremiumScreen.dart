import 'package:customchatgpt/model/general_response.dart';
import 'package:customchatgpt/model/payment_model.dart';
import 'package:customchatgpt/routes/routes_name.dart';
import 'package:customchatgpt/ui/subscription/upgrade_to_premium_options/subscription_viewmodel.dart';
import 'package:customchatgpt/utilities/colors.dart';
import 'package:customchatgpt/utilities/utils.dart';
import 'package:customchatgpt/ui/subscription/upgrade_to_premium_options/subscription_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/hive/user_hive_model.dart';
import '../../splash_screen/spashscreen_viewmodel.dart';


class UpgradeToPremiumScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _UpgradeToPremiumScreen();

}


class _UpgradeToPremiumScreen extends State {

  late Box userBox = Hive.box<UserHiveModel>('userBox');

  var KeyBox =  Hive.box<dynamic>('keybox');
  SubscriptionViewmodel viewmodel = SubscriptionViewmodel();
  int UsercurrentSubscription = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callUserSubScription();
    checkStripe();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Upgrade to Premium',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Premium badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.amber.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: const [
                    Icon(Icons.workspace_premium, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Premium Features',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            const Text(
              'Unlock the Full Power of\nAI',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: ColorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),



            // Subtitle
            const Text(
              'Get unlimited access and premium features',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // Feature grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [

                Stack(
                    children: [
                     SizedBox(
                       width: 230,
                       child: PremiumFeatureCard(
                        icon: Icons.chat_bubble_outline,
                        title: '14 days Free Trail',
                        color: Colors.purple,
                        onTap:() {
                          if (UsercurrentSubscription != 1)
                            {
                            mUtils.toastMessage(
                                "You opt the free tier and your package has been downgraded if any updated. ");

                            showBottomModal(context, "You are opting 14 Day free Trail, it will downgrade if you have any other subcription with Miachle GPT", 1,0
                            );
                        }else {
                            mUtils.toastMessage(
                                "You  have the same package");
                          }
                          // Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen);
                        },
                                           ),
                     ),
                      UsercurrentSubscription==1?Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 5),
                        child: Align(
                          alignment: Alignment.topLeft,

                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: CupertinoColors.activeGreen,size: 30,),
                              Text("Your active package", style: TextStyle(color: CupertinoColors.activeGreen,),)
                            ],
                          ),
                        ),
                      ):SizedBox(height: 0,),
                    ]
                  ),

                Stack(
                  children: [
                    SizedBox(
                      width: 230,
                      child: PremiumFeatureCard(
                        icon: Icons.flash_on,
                        title: "\99/month \n 10,000,000 input and output token per day",
                        color: Colors.blue,
                        onTap:(){
                          if (UsercurrentSubscription != 2)
                          {
                            showBottomModal(context,"Do you really want to subscribed for the Standard Package access at \$99",2, 99);
                          }else {
                            mUtils.toastMessage(
                                "You already have this package scripted ");
                          }

                         // Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen);
                          },
                      ),
                    ),

                    UsercurrentSubscription==2?Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,

                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: CupertinoColors.activeGreen,size: 30,),
                            Text("Your active package", style: TextStyle(color: CupertinoColors.activeGreen,),)
                          ],
                        ),
                      ),
                    ):SizedBox(height: 0,),
                  ],
                ),

                Stack(
                  children: [
                    SizedBox(
                      width: 230,
                      child: PremiumFeatureCard(
                        icon: Icons.image_outlined,
                        title: ' "\$199/month \n Unlimited access',
                        color: Colors.pink,
                        onTap:(){
                          if (UsercurrentSubscription == 3){
                            mUtils.toastMessage(
                                "You already have this package scripted ");


                          }else{

                            showBottomModal(context,"Do you really want to subscribed for the Unlimited access at \$199",3, 199);
                       //     Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen);
                          }
                         },
                      ),
                    ),

                    UsercurrentSubscription==3?Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,

                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: CupertinoColors.activeGreen,size: 30,),
                            Text("Your active package", style: TextStyle(color: CupertinoColors.activeGreen,),)
                          ],
                        ),
                      ),
                    ):SizedBox(height: 0,),
                  ],
                ),
                PremiumFeatureCard(
                  icon: Icons.arrow_forward,
                  title: 'Read More',
                  color: Colors.green,
                  onTap:(){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> callUserSubScription() async {

    print("sdfdsfdsfsdfs");
    UserHiveModel hiveUser = await userBox.get("currentUser");
       GeneralResponse response = await   viewmodel.getSubscription(hiveUser.getUserId);


       if (response.code == 200){

         UsercurrentSubscription = response.data["subscription_type"];
         print(UsercurrentSubscription);
         setState(() {

         });
       }else{
         mUtils.toastMessage(response.message);

       }

  }

  void showBottomModal(BuildContext context, String text, int packageSubcriped, int amount ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Confirm Change",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close modal
                      },
                      child: const Text("No"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context); // Close modal
                        // API call
                        amount = amount *100;
                        getKeyFromAPI(amount, packageSubcriped);
                      },
                      child: const Text("Yes"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  getKeyFromAPI(int amount, int subscriptionpakage) async {
   GeneralResponse response = await  viewmodel.getKeyFromAPI(amount);
   if (response.code == 200){
     String client_secrete = response.data["clientSecret"];

     if (kDebugMode){
       print(client_secrete);
     }

     makePayment(client_secrete, amount, subscriptionpakage);
   }else {

     mUtils.toastMessage(response.message);
   }

  }

  Future<void> makePayment(String  clientSecret, int amount, int subscriptionpakage) async {
    try {
      amount = amount *10000;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Michale GPT',
        ),
      );

      await Stripe.instance.presentPaymentSheet();



      callupgradeDBapi( amount,  subscriptionpakage);
    } catch (e) {
      print("Payment Failed: $e");
      mUtils.toastMessage(e.toString().substring(0,25));

    }
  }


  callupgradeDBapi(int amount, int subscriptionpakage) async {
    UserHiveModel hiveUser = await userBox.get("currentUser");

 var model =   PaymentModel(paymentType: 1, amount: amount, transactionId: '', transCreatedAt: DateTime.now(), transStatus: 0, subscriptionId:subscriptionpakage , userId: hiveUser.getUserId);
      GeneralResponse response = await viewmodel.upgradeSubscription(model);

 if (response!=null){
   if (response.code == 200){

     if (response.data!= {}) {
       PaymentModel pmodel = PaymentModel.fromJson(response.data);
       UsercurrentSubscription = pmodel.subscriptionId;
       setState(() {

       });
      hiveUser.setSubscriptionId(UsercurrentSubscription);
      hiveUser.setSubscriptionFriendlyName(UsercurrentSubscription==1?"Free Trail":UsercurrentSubscription==2?"Standard":UsercurrentSubscription==3?"Premium+":"");

     }
     Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen, arguments: {"subscription": UsercurrentSubscription});

   }else {
     mUtils.toastMessage(response.message);
   }
 }

  }

  Future<void> checkStripe() async {
    var box2 = await Hive.openBox<dynamic>('keybox');
    if (box2.containsKey(Constants.STRIPE_PUBLISH_KEY)) {
      Stripe.publishableKey = box2.get(Constants.STRIPE_PUBLISH_KEY);
      await Stripe.instance.applySettings();
    }else {
      var keyResponse = await SplashScreenViewmodel().getAPIkey(Constants.STRIPE_PUBLISH_KEY);


      if (keyResponse.code == 200) {
        var keyData = keyResponse.data;
     //  Map<String, dynamic> jsonArray = jsonDecode(keyData);
        await box2.put(Constants.STRIPE_PUBLISH_KEY, (keyData["key_value"]));
        Stripe.publishableKey = box2.get(Constants.STRIPE_PUBLISH_KEY);
        await Stripe.instance.applySettings();
      } else {
        mUtils.toastMessage(keyResponse.message);
      }
    }
  }
}

class PremiumFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const PremiumFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),

        decoration: BoxDecoration(
          border: Border.all(color: ColorPrimary),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade100
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 26),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }
}



