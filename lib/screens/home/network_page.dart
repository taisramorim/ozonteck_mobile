import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class NetworkPage extends StatelessWidget {
  // Sample data for demonstration purposes
  final List<NetworkUser> users = [
    NetworkUser(
      name: 'John Doe',
      rank: 'Jasper',
      pictureUrl: 'https://source.unsplash.com/random/',
      nickname: 'JD',
      dateJoined: DateTime.now(),
    ),
    NetworkUser(
      name: 'Jane Doe',
      rank: 'Dream Red',
      pictureUrl: 'https://source.unsplash.com/random/',
      nickname: 'Jane',
      dateJoined: DateTime.now(),
    ),
    NetworkUser(
      name: 'Alice',
      rank: 'Jade',
      pictureUrl: 'https://source.unsplash.com/random/',
      nickname: 'Alice',
      dateJoined: DateTime.now(),
    ),];

  NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final totalConnections = calculateTotalConnections(users); // Calculate total connections
    final directConnections = users.length; // Number of users in the list

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('My Network'),
      ),
      body: SafeArea( 
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.emoji_people, color: Colors.white),
                      const SizedBox(width: 8.0),
                      Text(
                        'Direct: $directConnections',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people_rounded, color: Colors.white), 
                      const SizedBox(width: 8.0),
                      Text(
                        'Total: $totalConnections',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return NetworkUserCard(user: user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Replace this with your actual logic to calculate total connections
  int calculateTotalConnections(List<NetworkUser> users) {
    return users.length * 6; // Placeholder for estimated connections
  }
}

class NetworkUserCard extends StatelessWidget {
  final NetworkUser user;

  const NetworkUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Set a light grey background color
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.0,
            spreadRadius: 0.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container( // Placeholder for profile image (optional)
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade300, // Lighter grey for placeholder
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(child: Icon(Icons.person, color: Colors.grey)), // Optional icon
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,),
                Text(user.rank, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.yMMMd().format(user.dateJoined), style: const TextStyle(fontSize: 10.0)),
                    const Icon(Icons.push_pin, color: Colors.grey),
                  ],
                ),
                Text(user.nickname, style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class NetworkUser {
  final String name;
  final String rank;
  final String pictureUrl;
  final String nickname;
  final DateTime dateJoined;

  NetworkUser({
    required this.name,
    required this.rank,
    required this.pictureUrl,
    required this.nickname,
    required this.dateJoined,
  });
}