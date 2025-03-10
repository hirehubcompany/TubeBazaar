import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Approved extends StatefulWidget {
  const Approved({super.key});

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Approved Applications")),
        body: Center(child: Text("Please log in to see approved applications.")),
      );
    }

    return Scaffold(

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('AppliedJobs')
            .where('status', isEqualTo: 'approved')
            .where(Filter.or(
            Filter('appliedBy', isEqualTo: user!.uid), // Applied by user
            Filter('userId', isEqualTo: user!.uid) // Posted by user
        ))
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No approved applications."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var application = snapshot.data!.docs[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(application['channelName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category: ${application['category']}"),
                      Text("Price: \$${application['price']}"),

                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context){
                        return Container();
                      });
                      // Handle channel transfer process
                    },
                    child: Text("Complete Here"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

