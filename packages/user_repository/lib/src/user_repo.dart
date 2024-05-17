import 'package:firebase_auth/firebase_auth.dart';
import 'models/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> setUserData(MyUser user);

  Future<void> signIn(String email, String password);

  Future<bool> isAdmin(User user);

  Future<List<MyUser>> getUsers();
  Future<List<MyUser>> getQueriedUsers(String query);

  Future<void> logOut();

  Future<MyUser> getUserDetails(User user);

  Future<MyUser> updateUserDetails(
      User user, String newName, String newAddress, String newContactNumber);

  Future<List<MyUser>> getMyUsersByUserId(String userId);

  Future<void> updateUser(MyUser user);


  //you can add options of forget password here
}