import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart'; // Import for date formatting

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
      body: FutureBuilder<List<MyUser>>(
        future: FirebaseUserRepository().getUserNetwork(userId), // Adjust this line to your repository instance
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recruits found.'));
          } else {
            List<MyUser> network = snapshot.data!;
            return ListView.builder(
              itemCount: network.length,
              itemBuilder: (context, index) {
                MyUser user = network[index];
                return ListTile(
                  title: Text(user.username),
                  subtitle: Text('User ID: ${user.id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}