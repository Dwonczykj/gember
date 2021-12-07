import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:template/ui/models/green_project.dart';
import 'package:template/ui/models/models.dart';

class UserDao extends ChangeNotifier {
  bool _userDetailsDocExists = false;

  GemberUser? _hydratedUserDetails;

  final auth = FirebaseAuth.instance;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('user_details');

  String get userId => auth.currentUser?.uid ?? '';

  GemberUser? get userDetails => isLoggedIn()
      ? _userDetailsDocExists
          ? _hydratedUserDetails
          : GemberUser(
                  uid: userId,
                  name: auth.currentUser?.displayName,
                  email: auth.currentUser?.email)
              .withProfilePicture(auth.currentUser?.photoURL)
      : null;

  String? get email {
    return auth.currentUser?.email;
  }

  String get name => auth.currentUser?.displayName ?? '';

  // String get photo_url => auth.currentUser?.photoURL ?? '';

  bool get emailVerified => auth.currentUser?.emailVerified ?? false;

  List<String> get priorities => userDetails?.priorities ?? [];

  String get profilePicture => (auth.currentUser?.photoURL?.isNotEmpty ?? false)
      ? auth.currentUser!.photoURL!
      : 'https://loremflickr.com/320/240/art,abstract/all';

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  bool userDetailsExist() {
    return _userDetailsDocExists;
  }

  Future updateEmail(String newEmail) async {
    if (recentlyAuthenticated) {
      await auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      return Future.value();
    }
  }

  Future updateName(String displayName) async {
    if (isLoggedIn()) {
      return auth.currentUser!.updateDisplayName(displayName);
    }
  }

  Future updatePassword(String newPassword) async {
    if (recentlyAuthenticated) {
      auth.currentUser?.updatePassword(newPassword);
    }
  }

  Future resetPassword(String email) async {
    auth.sendPasswordResetEmail(email: email);
  }

  Future updatePhotoUrl(String profilePictureUrl) async {
    if (isLoggedIn() && profilePictureUrl.isNotEmpty) {
      return auth.currentUser
          ?.updatePhotoURL(profilePictureUrl)
          .then((_) => true);
    } else {
      return Future.value(false);
    }
  }

  Future addPriority(String priorityId) {
    if (_userDetailsDocExists) {
      var userDetails = _hydratedUserDetails!;
      if (!userDetails.priorities.contains(priorityId)) {
        userDetails.priorities.add(priorityId);
        return updateUserDetails(userDetails);
      }
    }
    return Future.value();
  }

  Future deletePriority(String priorityId) {
    if (_userDetailsDocExists) {
      var userDetails = _hydratedUserDetails!;
      userDetails.priorities.removeWhere((element) => element == priorityId);
      return updateUserDetails(userDetails);
    }
    return Future.value();
  }

  // UserDao() {}

  Future<Map<String, dynamic>?> _getUserDetails() async {
    return await collection.doc(userId).get().then((value) {
      if (value.exists) {
        return value.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    }).catchError((error) {
      print(error);
      return null;
    });
  }

  Future refreshCurrentUserDetails() async {
    if (isLoggedIn()) {
      return await _getUserDetails().then((value) {
        _userDetailsDocExists = value != null;
        _hydratedUserDetails = value != null
            ? GemberUser.fromJson(auth.currentUser!, value)
            : GemberUser(
                    uid: userId,
                    name: auth.currentUser?.displayName,
                    email: auth.currentUser?.email)
                .withProfilePicture(auth.currentUser?.photoURL);

        notifyListeners();
      }).catchError((e) {
        print(e);
      });
    } else {
      _hydratedUserDetails = null;
      _userDetailsDocExists = false;
      notifyListeners();
    }
  }

  bool _password_requirements_satisfied(String password) {
    // TODO: Implement password complexity validation.
    return true;
  }

  // UserDaoUpdater updateUser(String uid) {
  //   if (isLoggedIn() && auth.currentUser?.uid == uid) {
  //     return UserDaoUpdater();
  //   }
  // }

  Future updateUserDetails(GemberUser user) {
    if (!isLoggedIn()) return Future.value();
    return collection
        .doc(user.uid)
        .update(user.toJson())
        .then((value) => print('${user.name} updated at ${collection.path}'))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // Future updateProfilePicture(String fileUrl) {
  //   if (!isLoggedIn()) return Future.value();
  //   collection
  //       .doc(auth.currentUser!.uid)
  //       .update({'profile_picture': fileUrl}).catchError(
  //           (error) => print("Failed to update user: $error"));
  //   auth.currentUser?.updatePhotoURL(fileUrl);
  //   return Future.value();
  // }

  Future addUserDetails(GemberUser user) {
    if (!isLoggedIn()) return Future.value();
    return collection
        .add(user.toJson())
        .then((value) => print('${user.name} added to ${collection.path}'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  bool delete_my_account() {
    if (!recentlyAuthenticated) {
      return false; //please resign in to auth this action.
    }
    collection
        .doc(auth.currentUser?.uid)
        .delete()
        .then((value) =>
            print('${auth.currentUser?.uid} deleted from ${collection.path}'))
        .then((_) => _delete_my_account())
        .catchError((error) => print("Failed to delete user: $error"));
    return true;
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
      if (!emailVerified) {
        auth.currentUser?.sendEmailVerification();
      }

      refreshCurrentUserDetails().then((_) {
        if (!_userDetailsDocExists) {
          debugger();
          addUserDetails(GemberUser(
                  uid: auth.currentUser!.uid,
                  name: auth.currentUser!.displayName,
                  email: auth.currentUser!.email)
              .withProfilePicture(auth.currentUser?.photoURL));
        }
      }).catchError((error) {
        print('Error fetching current user details: $error');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('JD, handle this excpetion better: $e');
    }
  }

  bool get recentlyAuthenticated =>
      isLoggedIn() &&
      auth.currentUser!.metadata.lastSignInTime != null &&
      DateTime.now()
              .difference(auth.currentUser!.metadata.lastSignInTime!)
              .inMinutes <
          5;

  Future _delete_my_account() async {
    if (recentlyAuthenticated) {
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

// class UserDaoUpdater {
//   // UserDaoUpdater withPriorities(GemberUser user){

//   // }

//   // UserDaoUpdater withAuth(GemberUser user){

//   // }

//   UserDaoUpdater() {}

//   UserDaoUpdater setEmail(String newEmail) {}

//   UserDaoUpdater setDisplayName(String newEmail) {}

//   UserDaoUpdater setProfilePhoto(String newEmail) {}
// }
