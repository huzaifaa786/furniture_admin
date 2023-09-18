import 'package:cloud_firestore/cloud_firestore.dart';

class BugModel {
  String? id;
  String? userId;
  String? image;
  String? description;
  bool? seen;

  BugModel({
    this.id,
    this.userId,
    this.image,
    this.description,
    this.seen
  });

  BugModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    userId = data['userId'] ?? '';
    id = data["id"] ?? '';
    image = data['image'] ?? '';
    description = data['description'] ?? '';
    seen = data['seen'];
  }
}
