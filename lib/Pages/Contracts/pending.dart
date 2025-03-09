import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please log in to see pending applications.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Pending Applications")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('AppliedJobs')
            .where(Filter.or(
            Filter('appliedBy', isEqualTo: user!.uid), // Applicants
            Filter('userId', isEqualTo: user!.uid) // Job posters
        ))
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No pending applications."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var application = snapshot.data!.docs[index];
              bool isJobPoster = application['userId'] == user!.uid;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(application['channelName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category: ${application['category']}"),
                      Text("Price: \$${application['price']}"),
                      Text("Applied by: ${application['appliedBy']}"),
                      Text("Posted by: ${application['userId']}"),
                    ],
                  ),
                  trailing: isJobPoster
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () => _updateApplicationStatus(application.id, 'approved'),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () => _updateApplicationStatus(application.id, 'rejected'),
                      ),
                    ],
                  )
                      : null, // Applicants cannot approve/reject
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _updateApplicationStatus(String docId, String newStatus) async {
    await FirebaseFirestore.instance.collection('AppliedJobs').doc(docId).update({'status': newStatus});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Application $newStatus")));
  }
}
