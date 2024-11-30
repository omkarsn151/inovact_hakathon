import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inovact_social/models/user_models.dart';
import '../models/post_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all posts
  Future<List<Post>> getPosts() async {
    try {
      final snapshot = await _db
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) {
        return Post.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  // Fetch user posts
  Future<List<Post>> getUserPosts(String userId) async {
    try {
      final snapshot = await _db.collection('posts').where('userId', isEqualTo: userId).get();
      return snapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      throw Exception('Error fetching user posts: $e');
    }
  }

  // Fetch liked posts for a user
  Future<List<Post>> getLikedPosts(String userId) async {
    try {
      final snapshot = await _db.collection('likes').where('userId', isEqualTo: userId).get();
      List<String> likedPostIds = snapshot.docs.map((doc) => doc['postId'] as String).toList();

      final postsSnapshot = await _db.collection('posts').where(FieldPath.documentId, whereIn: likedPostIds).get();
      return postsSnapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      throw Exception('Error fetching liked posts: $e');
    }
  }

  // Fetch user profile
  Future<UserModel?> getUserProfile(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  // Add a new post
  Future<void> addPost(Post post) async {
    try {
      await _db.collection('posts').add(post.toMap());
    } catch (e) {
      throw Exception('Error adding post: $e');
    }
  }
}
