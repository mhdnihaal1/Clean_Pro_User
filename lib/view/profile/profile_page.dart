// import 'package:clean_pro_user/constants/app_colors.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Profile',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 20)),
//         backgroundColor: AppColors.actionBlue,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               backgroundColor: AppColors.actionBlue,
//               child: Text(
//                 'J',
//                 style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'John Doe',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               'john.doe@example.com',
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//             const SizedBox(height: 24),
//             _buildInfoTile(
//                 Icons.location_on, 'Address', '123 Laundry St, New York'),
//             const SizedBox(height: 24),
//             _buildButton(
//               onPressed: () {
//                 // Add edit address functionality
//               },
//               icon: Icons.edit,
//               label: 'Edit Address',
//               color: AppColors.actionBlue,
//             ),
//             const SizedBox(height: 12),
//             _buildButton(
//               onPressed: () {
//                 // Add go to orders functionality
//               },
//               icon: Icons.shopping_bag,
//               label: 'My Orders',
//               color: AppColors.actionGreen,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoTile(IconData icon, String title, String value) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.actionBlue, size: 28),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildButton(
//       {required VoidCallback onPressed,
//       required IconData icon,
//       required String label,
//       required Color color}) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: onPressed,
//         icon: Icon(icon, size: 20),
//         label: Text(label),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
