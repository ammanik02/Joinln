import 'package:flutter/material.dart';
import '../../map/screens/home_map_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildPage(
            context,
            title: 'See Plans Nearby',
            description: 'Discover what verified people around you are planning.',
            icon: Icons.map,
            isLast: false,
          ),
          _buildPage(
            context,
            title: 'Join Real Meetups',
            description: 'Request to join plans and make new connections.',
            icon: Icons.people,
            isLast: false,
          ),
          _buildPage(
            context,
            title: 'Safety First',
            description: 'Only verified users can create plans. Your location is only shared when active.',
            icon: Icons.security,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context,
      {required String title, required String description, required IconData icon, required bool isLast}) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Theme.of(context).primaryColor),
          const SizedBox(height: 32),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 48),
          if (isLast)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeMapScreen()),
                );
              },
              child: const Text('Get Started'),
            ),
        ],
      ),
    );
  }
}
