import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/material.dart';

class UpgradeToPremiumScreen extends StatelessWidget {
  const UpgradeToPremiumScreen({super.key});

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
                PremiumFeatureCard(
                  icon: Icons.chat_bubble_outline,
                  title: '14 days Free Trail',
                  color: Colors.purple,
                  onTap:(){

                    Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen);
                  },
                ),
                PremiumFeatureCard(
                  icon: Icons.flash_on,
                  title: "\$999/Year \n Unlimited access and discount on year payment ",
                  color: Colors.blue,
                  onTap:(){Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen);},
                ),
                PremiumFeatureCard(
                  icon: Icons.image_outlined,
                  title: ' "\$99/month \n Unlimited access',
                  color: Colors.pink,
                  onTap:(){Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen);},
                ),
                PremiumFeatureCard(
                  icon: Icons.arrow_forward,
                  title: 'Read More',
                  color: Colors.green,
                  onTap:(){Navigator.pushNamed(context, RouteNames.PremiumSuccessScreen);},
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 26),
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
