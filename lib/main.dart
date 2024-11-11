import 'package:ccc/spl.dart';
import 'package:ccc/userlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'donerlist.dart';
void main() {

  runApp(BloodDonorApp());
}

class BloodDonorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donor Registration',
      theme: ThemeData(
        primarySwatch: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      home: Splash(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _lastDonatedController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedGender;  // Variable to store selected gender

  // Save donor information
  Future<void> _saveDonor() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      // Get existing donors
      List<String> donorsJson = prefs.getStringList('donors') ?? [];
      List<Donor> donors = donorsJson
          .map((donorJson) => Donor.fromJson(json.decode(donorJson)))
          .toList();

      // Create new donor
      Donor newDonor = Donor(
        name: _nameController.text,
        age: _ageController.text,
        bloodGroup: _bloodGroupController.text,
        lastDonated: _lastDonatedController.text,
        phoneNumber: _phoneController.text,
      );

      // Add new donor to the list
      donors.add(newDonor);

      // Save updated list
      List<String> updatedDonorsJson = donors
          .map((donor) => json.encode(donor.toJson()))
          .toList();
      await prefs.setStringList('donors', updatedDonorsJson);

      // Navigate to the donor list page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DonorListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Registration'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Gender Selection using RadioButton
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('Male'),
                        leading: Radio<String>(
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('Female'),
                        leading: Radio<String>(
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _bloodGroupController,
                  decoration: InputDecoration(
                    labelText: 'Blood Group',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your blood group';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _lastDonatedController,
                  decoration: InputDecoration(
                    labelText: 'Last Donated Date (DD/MM/YYYY)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last donation date';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _saveDonor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfff24336),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    selectionColor: Colors.white,
                    'Register',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _bloodGroupController.dispose();
    _lastDonatedController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
