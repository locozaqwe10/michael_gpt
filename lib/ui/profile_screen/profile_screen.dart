import 'package:custom_chat_gpt/routes/routes_name.dart';
import 'package:custom_chat_gpt/utilities/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:Colors.white ),
          onPressed: () {Navigator.pop(context);},
        ),
        title:  Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),

        centerTitle: true,
        actions: [

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _profileImageCard(),
            const SizedBox(height: 16),
            _profileInfoCard(),
            const SizedBox(height: 16),
            _subscriptionCard(context),
            const SizedBox(height: 24),
            _logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _profileImageCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF9B5CFF), Color(0xFF5B8CFF)],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 90,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF7B61FF),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Profile Information",
                style: TextStyle(fontWeight: FontWeight.bold, color: ColorSecandory),
              ),
              Icon(Icons.edit, color:ColorSecandory),
            ],
          ),
          const SizedBox(height: 16),
          _inputField(
            icon: Icons.person_outline,
            hint: "Full Name",
          ),
          const SizedBox(height: 12),
          _inputField(
            icon: Icons.email_outlined,
            hint: "Email",
          ),
        ],
      ),
    );
  }

  Widget _subscriptionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Subscription",
            style: TextStyle(fontWeight: FontWeight.bold, color: ColorSecandory),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Free Plan",
                  style: TextStyle(fontWeight: FontWeight.w600, color: ColorPrimary),
                ),
                Text(
                  "Limited features",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: ColorPrimary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.UpgradeToPremiumScreen);

              },
              child: const Text("Upgrade to Premium",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: ColorSecandory),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout, color: ColorSecandory),
        label: const Text(
          "Log Out",
          style: TextStyle(color: ColorSecandory),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _inputField({required IconData icon, required String hint}) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: ColorPrimary),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
