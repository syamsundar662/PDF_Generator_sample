// import 'package:firebase_realtime/model/model.dart';
// import 'package:firebase_realtime/services/firebase.dart';
// import 'package:firebase_realtime/ui/user_detail.dart';
// import 'package:flutter/material.dart';

// class UserScreen extends StatefulWidget {
//   const UserScreen({super.key});

//   @override
//   UserScreenState createState() => UserScreenState();
// }

// class UserScreenState extends State<UserScreen> {
//   final FirebaseService _firebaseService = FirebaseService();

//   @override
//   void initState() {
//     _firebaseService.fetchUsers();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('users')),
//       body: StreamBuilder<List<UserModel>>(
//         stream: _firebaseService.fetchUsers(),
//         builder: (context, snapshot) {
//     print(snapshot.data);
//           print(snapshot.data);
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Error fetching users'));
//           }

//           final users = snapshot.data ?? [];
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return ListTile(
//                 title: Text(user.name),
//                 subtitle: Text(user.email),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () => _firebaseService.deleteUser(user.id!),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => UserDetails(
//                         user: user,
//                         // name: user.name,
//                         // email: user.email,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_realtime/model/model.dart';
import 'package:firebase_realtime/services/firebase.dart';
import 'package:firebase_realtime/ui/user_detail.dart';

class UserScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: StreamBuilder<List<UserModel>>(
        stream: _firebaseService.fetchUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: IconButton(
                    onPressed: () {
                      _firebaseService.deleteUser(user.id!);
                    },
                    icon: Icon(Icons.delete)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetails(
                        user: user,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
