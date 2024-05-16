import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(userId: user.user!.uid);

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<List<MyUser>> getUsers() async {
    try {
      return await usersCollection.get().then((value) => value.docs
          .map((e) => MyUser.fromEntity(MyUserEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyUser>> getQueriedUsers(String search) async {
    final usersCollection = FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: search)
        .where('name', isLessThan: '${search}z');

    try {
      return await usersCollection.get().then((value) => value.docs
          .map((e) => MyUser.fromEntity(MyUserEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> isAdmin(User user) async {
    try {
      final userData = await usersCollection.doc(user.uid).get();
      final isAdmin = userData.data()?['isAdmin'] as bool? ?? false;
      return isAdmin;
    } catch (e) {
      log('Error fetching isAdmin: $e');
      throw e;
    }
  }

  @override
  Future<MyUser> getUserDetails(User user) async {
    try {
      final userData = await usersCollection.doc(user.uid).get();
      return MyUser.fromEntity(MyUserEntity.fromDocument(userData.data()!));
    } catch (e) {
      log('Error fetching user details: $e');
      throw e;
    }
  }

  @override
  Future<MyUser> updateUserDetails(User user, String newName, String newAddress,
      String newContactNumber) async {
    try {
      final userData = await usersCollection.doc(user.uid).get();
      if (userData.exists) {
        await usersCollection.doc(user.uid).update({
          'name': newName,
          'address': newAddress,
          'contactNumber': newContactNumber,
        });
        // Fetch updated user details
        final updatedUserData = await usersCollection.doc(user.uid).get();
        return MyUser.fromEntity(
            MyUserEntity.fromDocument(updatedUserData.data()!));
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      log('Error updating user details: $e');
      throw e;
    }
  }
}
