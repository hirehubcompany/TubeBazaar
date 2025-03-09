import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChannelDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot job;

  const ChannelDetailsPage({super.key, required this.job});

  Future<void> applyForJob(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must be logged in to apply.')),
      );
      return;
    }

    String userId = user.uid;
    String jobId = job.id;

    // Ensure the job has a postedBy field
    if (!job.data().toString().contains('userId')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Job data is incomplete.')),
      );
      return;
    }

    String ownerId = job['userId']; // Fetch postedBy (User who posted the job)

    try {
      // Check if user already applied
      var existingApplication = await FirebaseFirestore.instance
          .collection('AppliedJobs')
          .where('channelId', isEqualTo: jobId)
          .where('userId', isEqualTo: userId)
          .get();

      if (existingApplication.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You have already applied for this channel.')),
        );
        return;
      }

      await FirebaseFirestore.instance.collection('AppliedJobs').add({
        'channelId': jobId,
        'channelName': job['channelName'],
        'category': job['category'],
        'price': job['price'],
        'isMonetized': job['isMonetized'],
        'appliedBy': userId, // User applying for the job
        'userId': ownerId, // Owner of the job
        'status': 'pending', // Default status
        'appliedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application submitted successfully!')),
      );
    } catch (e) {
      print("Error: ${e.toString()}"); // Debugging output
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to apply. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job['channelName'] ?? 'Channel Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: ${job['category']}", style: TextStyle(fontSize: 18)),
            Text("Price: \$${job['price']}", style: TextStyle(fontSize: 18)),
            Text(
              "Monetized: ${job['isMonetized'] ? 'Yes' : 'No'}",
              style: TextStyle(fontSize: 18, color: job['isMonetized'] ? Colors.green : Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => applyForJob(context),
              child: Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }
}
