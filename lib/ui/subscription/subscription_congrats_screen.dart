import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class PremiumSuccessScreen extends StatefulWidget {
  const PremiumSuccessScreen({super.key});

  @override
  State<PremiumSuccessScreen> createState() => _PremiumSuccessScreenState();
}

class _PremiumSuccessScreenState extends State<PremiumSuccessScreen> {
  late ConfettiController _topController;
  late ConfettiController _bottomController;

  @override
  void initState() {
    super.initState();
    _topController = ConfettiController(duration: const Duration(seconds: 3));
    _bottomController = ConfettiController(duration: const Duration(seconds: 3));

    // Trigger animation
    Future.delayed(const Duration(milliseconds: 300), () {
      _topController.play();
      _bottomController.play();
    });
  }

  @override
  void dispose() {
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: Stack(
        children: [
          // 🎉 Top confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _topController,
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              shouldLoop: false,
            ),
          ),

          // 🎉 Bottom confetti
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _bottomController,
              blastDirection: -pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.3,
              shouldLoop: false,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Crown icon
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.pink],
                      ),
                    ),
                    child: const Icon(
                      Icons.workspace_premium,
                      color: Colors.white,
                      size: 44,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  const Text(
                    'Congratulations! 🎉',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "You're Now a Premium Member",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Your payment has been successfully processed and your subscription has been upgraded!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  // Payment received card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green),
                      color: Colors.green.withOpacity(0.08),
                    ),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.check, color: Colors.white),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Received',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Your premium features are now active',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Features
                  const Text(
                    'Your Premium Features Are Ready',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _featureTile(
                    icon: Icons.chat_bubble_outline,
                    color: Colors.purple,
                    title: 'Unlimited Messages',
                    subtitle: 'Chat as much as you want, no daily limits',
                  ),

                  _featureTile(
                    icon: Icons.flash_on,
                    color: Colors.blue,
                    title: 'Priority Speed',
                    subtitle: 'Faster responses anytime',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
