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
                    icon: const Icon(Icons.delete)),
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
