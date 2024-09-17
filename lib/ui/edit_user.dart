
//For initial testing purpose only

// import 'package:flutter/material.dart';

// class EditUserDetails extends StatefulWidget {
//   final String currentName;
//   final String currentEmail;
//   final String currentPhone;

//   const EditUserDetails({
//     super.key,
//     required this.currentName,
//     required this.currentEmail,
//     required this.currentPhone,
//   });

//   @override
//   State<EditUserDetails> createState() => _EditUserDetailsState();
// }

// class _EditUserDetailsState extends State<EditUserDetails> {
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;

//   @override
//   void initState() {
//     _nameController = TextEditingController(text: widget.currentName);
//     _emailController = TextEditingController(text: widget.currentEmail);
//     _phoneController = TextEditingController(text: widget.currentPhone);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit User Details')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: const InputDecoration(labelText: 'Phone'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Update user details logic goes here
//               },
//               child: const Text('Update Details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
