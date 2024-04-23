import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('applicationprop').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var application = snapshot.data!.docs[index];
                var name = application['name'];
                var location = application['location'];
                return ListTile(
                  title: Text(name),
                  subtitle: Text(location),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to see more details
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApplicationDetailsPage(application: application)),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ApplicationDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> application;

  ApplicationDetailsPage({required this.application});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(application['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Location: ${application['location']}'),
          ),
          // Add more details as needed
        ],
      ),
    );
  }
}
