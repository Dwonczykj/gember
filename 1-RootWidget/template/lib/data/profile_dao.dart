import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template/ui/models/green_project.dart';

class ProjectDao {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('messages');

  void saveProject(GreenProject project) {
    collection.add(project.toJson());
  }

  Stream<QuerySnapshot> getProjectsStream() {
    return collection.snapshots();
  }

  Future<QuerySnapshot> getProject(String id) async {
    var project = await collection.where('uid', isEqualTo: id).get();
    return project;
  }
}
