import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class AddProp extends StatefulWidget {
  const AddProp({Key? key}) : super(key: key);

  @override
  State<AddProp> createState() => _AddPropState();
}

class _AddPropState extends State<AddProp> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();

  String imageUrl = '';

  CollectionReference _reference = FirebaseFirestore.instance.collection('property'); // Collection reference

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.house_rounded,
                size: 100,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _controllerName,
                decoration: InputDecoration(hintText: 'Enter Property Name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the property name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerLocation,
                decoration: InputDecoration(hintText: 'Enter Property Location'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the property location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerDescription,
                decoration: InputDecoration(hintText: 'Enter Property Description'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the property description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerPrice,
                decoration: InputDecoration(hintText: 'Enter Property Price'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the property price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              IconButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

                  if (pickedImage != null) {
                    // Upload image to Firebase Storage
                    Reference ref = FirebaseStorage.instance.ref().child('property_images').child(DateTime.now().millisecondsSinceEpoch.toString());
                    UploadTask uploadTask = ref.putFile(File(pickedImage.path));
                    uploadTask.whenComplete(() async {
                      // Get the download URL of the uploaded image
                      String downloadUrl = await ref.getDownloadURL();
                      setState(() {
                        imageUrl = downloadUrl;
                      });
                    });
                  }
                },
                icon: Icon(Icons.image),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add property to Firestore database
                  // Include imageUrl along with other property details
                  _addProperty();
                },
                child: Text('Add Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addProperty() {
    if (_controllerName.text.isNotEmpty &&
        _controllerLocation.text.isNotEmpty &&
        _controllerDescription.text.isNotEmpty &&
        _controllerPrice.text.isNotEmpty &&
        imageUrl.isNotEmpty) {
      // Create a Map of property data
      Map<String, dynamic> propertyData = {
        'name': _controllerName.text,
        'location': _controllerLocation.text,
        'description': _controllerDescription.text,
        'price': double.parse(_controllerPrice.text),
        'image': imageUrl,
      };

      // Add the property to Firestore
      _reference.add(propertyData).then((value) {
        
        // Successfully added property
        // You can add any additional logic here, such as showing a confirmation message
        print('Property added successfully');
      }).catchError((error) {
        // Error occurred while adding property
        // Handle the error
        print('Failed to add property: $error');
      });
    } else {
      // Show error message if any of the fields are empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields and upload an image'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
