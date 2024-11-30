import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String projectName;
  final String projectDescription;
  final List<String> skillsRequired;
  final String? projectLink;
  final Timestamp createdAt;
  final String username;

  Post({
    required this.id,
    required this.userId,
    required this.projectName,
    required this.projectDescription,
    required this.skillsRequired,
    this.projectLink,
    required this.createdAt,
    required this.username,
  });

  // Convert to map to upload to Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'projectName': projectName,
      'projectDescription': projectDescription,
      'skillsRequired': skillsRequired,
      'projectLink': projectLink,
      'createdAt': createdAt,
      'username': username,
    };
  }

  // Factory method to create Post from Firestore data
  factory Post.fromMap(Map<String, dynamic> data, String id) {
    return Post(
      id: id,
      userId: data['userId'] ?? '',
      projectName: data['projectName'] ?? '',
      projectDescription: data['projectDescription'] ?? '',
      skillsRequired: List<String>.from(data['skillsRequired'] ?? []),
      projectLink: data['projectLink'],
      createdAt: data['createdAt'] ?? Timestamp.now(),
      username: data['username'] ?? 'Anonymous',
    );
  }
}
