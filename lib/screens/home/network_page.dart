import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class NetworkPage extends StatelessWidget {
  final String userId;

  const NetworkPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('My Network'),
      ),
      body: FutureBuilder<MyUser>(
        future: FirebaseUserRepository().getMyUser(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            MyUser user = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: _buildUserNode(user),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: Text('No recruits found.'));
          }
        },
      ),
    );
  }

  Widget _buildUserNode(MyUser user) {
    return FutureBuilder<List<MyUser>>(
      future: FirebaseUserRepository().getRecruitedUsers(user.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildUserCard(user, isLoading: true);
        } else if (snapshot.hasData) {
          List<MyUser> recruitedUsers = snapshot.data!;
          if (recruitedUsers.isEmpty) {
            return _buildUserCard(user, hasNoRecruits: true);
          } else {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundImage: user.picture != null && user.picture!.isNotEmpty
                      ? NetworkImage(user.picture!)
                      : null,
                  child: user.picture == null || user.picture!.isEmpty
                      ? Text(user.username[0].toUpperCase())
                      : null,
                ),
                title: Text(user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('User name: ${user.name}'),
                children: recruitedUsers.map((recruit) => _buildUserNode(recruit)).toList(),
              ),
            );
          }
        } else {
          return _buildUserCard(user, isError: true);
        }
      },
    );
  }

  Widget _buildUserCard(MyUser user, {bool isLoading = false, bool hasNoRecruits = false, bool isError = false}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: user.picture != null && user.picture!.isNotEmpty
              ? NetworkImage(user.picture!)
              : null,
          child: user.picture == null || user.picture!.isEmpty
              ? Text(user.username[0].toUpperCase())
              : null,
        ),
        title: Text(user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: isLoading
            ? const Text('Loading recruits...')
            : hasNoRecruits
                ? const Text('No recruits')
                : isError
                    ? const Text('Error loading recruits')
                    : Text('User ID: ${user.id}'),
      ),
    );
  }
}
