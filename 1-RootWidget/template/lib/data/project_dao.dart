import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:template/ui/models/green_project.dart';

void defaultFunction<T>(T arg) {
  return;
}

class ProjectDao extends ChangeNotifier {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('projects');

  void saveProject(GreenProject project) {
    collection
        .add(project.toJson())
        .then((value) => print('${project.name} added'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // StreamSubscription getProjectsStreamSubsription(
  //     {String? nameLike,
  //     void Function(GreenProject) projectChangeCB = defaultFunction}) {
  //   final unsubscribeSub =
  //       getProjectsStream(nameLike: nameLike, projectChangeCB: projectChangeCB)
  //           .listen((querySnapshot) {
  //     querySnapshot.docChanges.forEach((element) {
  //       var project =
  //           GreenProject.fromJson(element.doc.data() as Map<String, Object>);
  //       projectChangeCB(project);
  //     });
  //   });
  //   return unsubscribeSub;
  // }

  Stream<Iterable<GreenProject>> getProjectsStream(
      {String? nameLike,
      void Function(GreenProject) projectChangeCB = defaultFunction}) {
    Query reference;
    if (nameLike == null) {
      reference = collection;
    } else {
      reference = collection.where('name',
          arrayContains:
              nameLike); // https://stackoverflow.com/questions/46568142/google-firestore-query-on-substring-of-a-property-value-text-search/52715590#52715590
    }
    final unsubscribe = reference.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map<GreenProject>((doc) =>
            GreenProject.fromJson(doc.data() as Map<String, dynamic>)));

    return unsubscribe;
  }

  Future<Iterable<GreenProject>> getProjects_Temporary(
      {String? nameLike}) async {
    if (nameLike == null) {
      final projects = await collection.get().then((value) => value.docs
          .map<GreenProject>((doc) =>
              GreenProject.fromJson((doc.data() as Map<String, dynamic>))));
      return projects;
    } else {
      final projects = await collection
          .where('name',
              arrayContains:
                  nameLike) // https://stackoverflow.com/questions/46568142/google-firestore-query-on-substring-of-a-property-value-text-search/52715590#52715590
          .get()
          .then((value) => value.docs.map<GreenProject>((doc) =>
              GreenProject.fromJson((doc.data() as Map<String, dynamic>))));
      return projects;
    }
  }

  Future<QuerySnapshot> getProject(String id) async {
    var project = await collection.where('uid', isEqualTo: id).get();
    return project;
  }
}
