import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_realtime/model/model.dart';

class FirebaseService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('users');

  // Add user with product
  Future<void> addUser(UserModel user) async {
    DatabaseReference newUserRef = _dbRef.push();
    await newUserRef.set(user.toMap());
  }

  // Fetch users with product details
  Stream<List<UserModel>> fetchUsers() {
    return _dbRef.onValue.map((event) {
      final usersData = event.snapshot.value as Map<dynamic, dynamic>?;
      if (usersData == null) {
        return [];
      }
      return usersData.entries.map((entry) {
        return UserModel.fromMap(entry.value as Map, entry.key);
      }).toList();
    });
  }

  // Delete user
  Future<void> deleteUser(String id) async {
    await _dbRef.child(id).remove();
  }

  // Update user with product
  Future<void> updateUser(String id, UserModel user) async {
    await _dbRef.child(id).update(user.toMap());
  }
}
