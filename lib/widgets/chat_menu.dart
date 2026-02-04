import 'package:flutter/material.dart';

class ChatMenu extends StatelessWidget {
  const ChatMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blue,
                child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to PTCL!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'How may I help you today?',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Menu buttons
          _menuButton('Get new services'),
          _menuButton('Register a new complaint'),
          _menuButton('Latest Bill Information'),
          _menuButton('Know about service offering'),
          _menuButton('Check complaint status'),
          _menuButton('Charji (Wireless Internet AJK)'),
          _menuButton('Broadband Usage Information'),
          _menuButton('WHT Statement'),
        ],
      ),
    );
  }

  Widget _menuButton(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            debugPrint('$title clicked');
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFFD0D8E6),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
