import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../services/firestore_service.dart';
import '../models/post_model.dart';
import '../widgets/post_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);
    final postsFuture = FirestoreService().getPosts(); // Fetch posts

    return Scaffold(
      body: userProfileAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text("Please update your profile"));
          }
          return DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.32,
                          child: Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.blueAccent, Colors.purpleAccent],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(35),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.14,
                                left: MediaQuery.of(context).size.width * 0.5 - 75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 5,
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 65,
                                    backgroundImage:
                                    AssetImage('assets/images/user_image.png'),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                right: 20,
                                child: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'Edit Profile') {
                                      Navigator.pushNamed(context, '/edit-profile');
                                    } else if (value == 'Logout') {
                                      _confirmSignOut(context, ref);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'Edit Profile',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color: Colors.blueAccent),
                                          SizedBox(width: 10),
                                          Text('Edit Profile'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'Logout',
                                      child: Row(
                                        children: [
                                          Icon(Icons.logout, color: Colors.redAccent),
                                          SizedBox(width: 10),
                                          Text('Logout'),
                                        ],
                                      ),
                                    ),
                                  ],
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            children: [
                              const Text(
                                'Omkar Nimbalkar',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Student',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Aspiring Engineering Student',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  _buildSkillChip('Flutter'),
                                  _buildSkillChip('WebDev'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _TabBarDelegate(
                      TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.green.withOpacity(0.2),
                        ),
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(child: Text('Posts', style: TextStyle(fontWeight: FontWeight.w600))),
                          Tab(child: Text('Likes', style: TextStyle(fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  // Posts Tab: Show Feed
                  FutureBuilder<List<Post>>(
                    future: postsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No posts available"));
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return PostTile(post: snapshot.data![index]);
                        },
                      );
                    },
                  ),
                  // Likes Tab: Show message if no likes
                  Center(
                    child: Text(
                      "You have not liked any posts",
                      style: TextStyle(color: Colors.grey[600], fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text("Error: $error")),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.blue.withOpacity(0.1),
      labelStyle: TextStyle(color: Colors.blue[700]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  void _confirmSignOut(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(authServiceProvider).signOut();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}


