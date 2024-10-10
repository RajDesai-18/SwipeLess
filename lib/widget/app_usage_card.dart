// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppUsageCard extends StatelessWidget {
  final String appName;
  final String usageTime;
  final IconData icon;
  final Color color;

  const AppUsageCard({
    super.key,
    required this.appName,
    required this.usageTime,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          appName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text('Usage time: $usageTime minutes'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigate to detailed app usage stats or settings
        },
      ),
    );
  }
}
