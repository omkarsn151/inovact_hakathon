import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_models.dart';
import '../services/auth_services.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getUserProfile();  // Fetch user profile from Firestore
});

// auth_provider.dart
final userPostsProvider = FutureProvider<List<String>>((ref) async {
  // Replace with your method to fetch user posts
  return await ref.read(authServiceProvider).fetchUserPosts();
});

final userLikedPostsProvider = FutureProvider<List<String>>((ref) async {
  // Replace with your method to fetch liked posts
  return await ref.read(authServiceProvider).fetchUserLikedPosts();
});
