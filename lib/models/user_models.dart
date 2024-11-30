// class UserModel {
//   final String uid;
//   final String username;
//   final List<String> skills;
//   final String bio;
//
//   UserModel({
//     required this.uid,
//     required this.username,
//     required this.skills,
//     required this.bio,
//   });
//
//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       uid: data['uid'] ?? '',
//       username: data['username'] ?? 'Unknown',
//       skills: data['skills'] != null
//           ? List<String>.from(data['skills'] as List)
//           : [],
//       bio: data['bio'] ?? 'No bio available', // Default to a placeholder bio
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'username': username,
//       'skills': skills,
//       'bio': bio,
//     };
//   }
//
//   UserModel copyWith({
//     String? uid,
//     String? username,
//     List<String>? skills,
//     String? bio,
//   }) {
//     return UserModel(
//       uid: uid ?? this.uid,
//       username: username ?? this.username,
//       skills: skills ?? this.skills,
//       bio: bio ?? this.bio,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'UserModel(uid: $uid, username: $username, skills: $skills, bio: $bio)';
//   }
// }

class UserModel {
  final String? name;
  final String? username;
  final String? profileImageUrl;
  final List<String>? skills;

  UserModel({
    this.name,
    this.username,
    this.profileImageUrl,
    this.skills,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      skills: List<String>.from(data['skills'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'skills': skills,
    };
  }
}
