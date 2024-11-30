import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Inovact")),
      body: userProfileAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text("Please update your profile"));
          }
          return Center(child: Text("Welcome, ${user.username}"));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
