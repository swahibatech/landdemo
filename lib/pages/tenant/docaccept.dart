import 'package:flutter/material.dart';

void main() {
  runApp(AcceptTermsPage());
}

class AcceptTermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Accept Terms and Conditions'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Documents:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                DocumentItem(icon: Icons.description, name: 'Lease Agreement'),
                DocumentItem(icon: Icons.description, name: 'Deposit Security'),
                DocumentItem(icon: Icons.description, name: 'Rental Policy'),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle accept button press
                        print('Accepted');
                      },
                      child: Text('Accept'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle decline button press
                        print('Declined');
                      },
                      child: Text('Decline'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DocumentItem extends StatelessWidget {
  final IconData icon;
  final String name;

  const DocumentItem({
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
