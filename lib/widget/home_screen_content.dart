// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/material.dart';
//
// class HomeScreenContent extends StatelessWidget {
//   const HomeScreenContent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Tracked Apps',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           SizedBox(height: 12),
//           AppUsageCard(
//             appName: 'Instagram',
//             usageTime: '35', // Example usage time in minutes
//             icon: Icons.photo_camera,
//             color: Colors.purpleAccent,
//           ),
//           SizedBox(height: 12),
//           AppUsageCard(
//             appName: 'Facebook',
//             usageTime: '20',
//             icon: Icons.facebook,
//             color: Colors.blueAccent,
//           ),
//           SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () {
//               // Functionality to refresh app usage time
//             },
//             icon: Icon(Icons.refresh),
//             label: Text('Refresh Data'),
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AppUsageCard extends StatelessWidget {
//   final String appName;
//   final String usageTime;
//   final IconData icon;
//   final Color color;
//
//   const AppUsageCard({
//     super.key,
//     required this.appName,
//     required this.usageTime,
//     required this.icon,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: color.withOpacity(0.2),
//           child: Icon(
//             icon,
//             color: color,
//           ),
//         ),
//         title: Text(
//           appName,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//           ),
//         ),
//         subtitle: Text('Usage time: $usageTime minutes'),
//         trailing: Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: () {
//           // Navigate to detailed app usage stats or settings
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  static const platform = MethodChannel('com.example.app_usage_tracker/usage');
  String gmailUsageTime = '0.00';

  Future<void> getAppUsageTime(String appName) async {
    try {
      final int usageTime = await platform.invokeMethod('getUsageStats', {'appName': appName});
      setState(() {
        gmailUsageTime = (usageTime / (1000 * 60)).toStringAsFixed(2); // Convert milliseconds to minutes
      });
    } on PlatformException catch (e) {
      setState(() {
        gmailUsageTime = "Error: ${e.message}";
      });
    }
  }

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
            appName: 'Gmail',
            usageTime: gmailUsageTime,
            icon: Icons.email,
            color: Colors.redAccent,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              getAppUsageTime('com.google.android.gm');
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
        onTap: () {},
      ),
    );
  }
}
