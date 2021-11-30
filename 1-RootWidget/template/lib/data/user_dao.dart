import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:template/ui/models/green_project.dart';
import 'package:template/ui/models/models.dart';

class UserDao extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('user_details');

  // 1
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

// 2
  String? userId() {
    return auth.currentUser?.uid;
  }

//3
  String? get email {
    return auth.currentUser?.email;
  }

  void updateEmail(String newEmail) {
    if (isLoggedIn()) auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
  }

  String get name => auth.currentUser?.displayName ?? '';

  set name(String displayName) {
    if (isLoggedIn()) auth.currentUser!.updateDisplayName(displayName);
  }

  bool get email_verified => auth.currentUser?.emailVerified ?? false;

  String get photo_url => auth.currentUser?.photoURL ?? '';

  set photo_url(String profile_picture_url) {
    if (isLoggedIn()) auth.currentUser?.updatePhotoURL(profile_picture_url);
  }

  Future<Map<String, dynamic>> _getUserDetails(String userId) async {
    return await (collection
            .doc(userId)
            .get()
            .then((value) => value.data() as Map<String, dynamic>))
        .catchError((error) => null);
  }

  Future<GemberUser?> CurrentUserDetails() async {
    if (isLoggedIn()) {
      return await _getUserDetails(auth.currentUser!.uid).then((value) {
        return value != null ? GemberUser.fromJson(value) : null;
      });
    } else {
      return Future.value(null);
    }
  }

  Future<List<String>> getPriorities(String userId) async {
    return _getUserDetails(userId).then((map) => map['priorities']);
  }

  Future<String> getProfilePicture(String userId) async {
    return _getUserDetails(userId).then((map) => map['profile_picture']);
  }

  Future<String> getCoverPicture(String userId) async {
    return _getUserDetails(userId).then((map) => map['cover_picture']);
  }

  bool _password_requirements_satisfied(String password) {
    // TODO: Implement password complexity validation.
    return true;
  }

  void updateUserDetails(GemberUser user) {
    if (!isLoggedIn()) return;
    collection
        .doc(user.uid)
        .update(user.toJson())
        .then((value) => print('${user.name} updated at ${collection.path}'))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future updateProfilePicture(String fileUrl) {
    if (!isLoggedIn()) return Future.value();
    return collection
        .doc(auth.currentUser!.uid)
        .update({'profile_picture': fileUrl}).catchError(
            (error) => print("Failed to update user: $error"));
  }

  void addUserDetails(GemberUser user) {
    if (!isLoggedIn()) return;
    collection
        .add(user.toJson())
        .then((value) => print('${user.name} added to ${collection.path}'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void deleteUserDetails(String userUid) {
    if (!isLoggedIn()) return;
    collection
        .doc(userUid)
        .delete()
        .then((value) => print('${userUid} deleted from ${collection.path}'))
        .then((_) => delete_user(userUid))
        .catchError((error) => print("Failed to delete user: $error"));
  }

// 1
  void signup(String email, String password) async {
    try {
      // 2
      // TODO: Make sure password is satisfactory and email is in email format.
      if (password == null ||
          _password_requirements_satisfied(password) == false) {
        print('Password doesn\'t meet the complexity requirements.');
      }
      print('creating account with email: ${email}');
      final creds = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('account created with email: ${email}');
      // 3
      notifyListeners();

      auth.currentUser?.sendEmailVerification();

      addUserDetails(GemberUser(
          uid: auth.currentUser!.uid,
          name: auth.currentUser!.displayName,
          email: auth.currentUser!.email ?? ''));
    } on FirebaseAuthException catch (e) {
      // 4
      print(e.code);

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      // 5
      print(e);
    }
  }

// 1
  void login(String email, String password) async {
    try {
      // 2
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 3
      notifyListeners();
      if (!email_verified) {
        auth.currentUser?.sendEmailVerification();
      }
      //TODO: Fix the line below, promise fails when there is no User Details collection, fix the promise to allow it.
      CurrentUserDetails().then((value) => {
            if (value == null)
              {
                addUserDetails(GemberUser(
                    uid: auth.currentUser!.uid,
                    name: auth.currentUser!.displayName,
                    email: auth.currentUser!.email ?? ''))
              }
          });
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future delete_user(String userUid) async {
    if (isLoggedIn() &&
        auth.currentUser!.metadata.lastSignInTime != null &&
        DateTime.now()
                .difference(auth.currentUser!.metadata.lastSignInTime!)
                .inMinutes <
            5) {
      return await auth.currentUser!
          .delete()
          .whenComplete(() => null)
          .catchError((error) => print("Failed to delete user: $error"));
    }
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   if(isLoggedIn())
  //   super.dispose();
  // }
}
