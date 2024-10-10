// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:swipe_less/widget/app_usage_card.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tracked Apps',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12),
          AppUsageCard(
            appName: 'Instagram',
            usageTime: '35', // Example usage time in minutes
            icon: Icons.photo_camera,
            color: Colors.purpleAccent,
          ),
          SizedBox(height: 12),
          AppUsageCard(
            appName: 'Facebook',
            usageTime: '20',
            icon: Icons.facebook,
            color: Colors.blueAccent,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Functionality to refresh app usage time
            },
            icon: Icon(Icons.refresh),
            label: Text('Refresh Data'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
