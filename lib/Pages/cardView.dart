import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCard extends StatelessWidget {
  final QueryDocumentSnapshot user;
  const UserCard(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blueAccent,
              child: Text(
                user["name"].substring(0, 2).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user["title"]} ${user["name"]}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(user["email"], style: TextStyle(color: Colors.grey[700])),
                  Text(user["mobile"], style: TextStyle(color: Colors.grey[700])),
                  Text(user["website"], style: const TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueAccent),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.email, color: Colors.blueAccent),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.schedule, color: Colors.blueAccent),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
