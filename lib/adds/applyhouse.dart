import 'package:auctionwesbank/components/submit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class AddApplication extends StatefulWidget {
  const AddApplication({Key? key}) : super(key: key);

  @override
  State<AddApplication> createState() => _AddApplicationState();
}

class _AddApplicationState extends State<AddApplication> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();

  String imageUrl = '';

  CollectionReference _reference = FirebaseFirestore.instance.collection('applicationprop'); // Collection reference

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.apartment,
                size: 100,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _controllerName,
                decoration: InputDecoration(hintText: 'Enter Your Name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerLocation,
                decoration: InputDecoration(hintText: 'Employer/employment Role'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the place of work';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerPrice,
                decoration: InputDecoration(hintText: 'Enter Avarage Salary'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Salary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              
              Submit(
                onTap: 
                  
                  _addApplication
               
                
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addApplication() {
    if (_controllerName.text.isNotEmpty &&
        _controllerLocation.text.isNotEmpty &&
        _controllerPrice.text.isNotEmpty
       ) {
      // Create a Map of property data
      Map<String, dynamic> propertyData = {
        'name': _controllerName.text,
        'location': _controllerLocation.text,
        'price': double.parse(_controllerPrice.text),
        
      };

      // Add the property to Firestore
      _reference.add(propertyData).then((value) {
        // Successfully added property
        // You can add any additional logic here, such as showing a confirmation message
        print('application added successfully');
      }).catchError((error) {
        // Error occurred while adding property
        // Handle the error
        print('Failed to Apply: $error');
      });
    } else {
      // Show error message if any of the fields are empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
