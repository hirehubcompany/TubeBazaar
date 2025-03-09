import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'details.dart'; // Import the new details page

class FinalHomepage extends StatefulWidget {
  const FinalHomepage({super.key});

  @override
  State<FinalHomepage> createState() => _FinalHomepageState();
}

class _FinalHomepageState extends State<FinalHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('TubeBazaar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        'Jobs',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Icon(Icons.menu)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "All JOBS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No jobs available"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var job = snapshot.data!.docs[index];

                      return GestureDetector(
                        onTap: () {
                          // Navigate to the details page when clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChannelDetailsPage(job: job),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['channelName'] ?? 'No Channel Name',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Category: ${job['category'] ?? 'N/A'}",
                                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Price: \$${job['price'] ?? 'N/A'} ${job['isNegotiable'] ? '(Negotiable)' : ''}",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Monetized: ${job['isMonetized'] ? 'Yes' : 'No'}",
                                  style: TextStyle(fontSize: 14, color: job['isMonetized'] ? Colors.green : Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
