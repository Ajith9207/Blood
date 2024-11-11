import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'donerlist.dart';
import 'main.dart';
import 'mydata.dart';

class DonorListPage extends StatefulWidget {
  @override
  _DonorListPageState createState() => _DonorListPageState();
}
class _DonorListPageState extends State<DonorListPage> {
  List<Donor> donors = [];
  List<String> donationImages = [
    'https://mmhrc.in/file/wp-content/uploads/2022/03/blood-donation.jpg',
    'https://www.shutterstock.com/image-vector/blood-donation-illustration-concept-bag-600nw-2156013083.jpg',
    'https://advinhealthcare.com/wp-content/uploads/2022/10/Blood-Donation-2.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadDonors();
  }

  // Load donors from shared preferences
  Future<void> _loadDonors() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> donorsJson = prefs.getStringList('donors') ?? [];

    setState(() {
      donors = donorsJson
          .map((donorJson) => Donor.fromJson(json.decode(donorJson)))
          .toList();
    });
  }
  Future<void> _deleteDonor(int index) async {
    final prefs = await SharedPreferences.getInstance();
    donors.removeAt(index);
    List<String> updatedDonorsJson = donors
        .map((donor) => json.encode(donor.toJson()))
        .toList();
    await prefs.setStringList('donors', updatedDonorsJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor List'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: donationImages.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(
                  donationImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              scrollPhysics: ScrollPhysics(),
            ),
          ),

          // Show donors list
          donors.isEmpty
              ? Center(child: Text('No donors registered yet'))
              : Expanded(
            child: ListView.builder(
              itemCount: donors.length,
              itemBuilder: (context, index) {
                final donor = donors[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        donor.bloodGroup,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(donor.name),
                    subtitle: Text(donor.phoneNumber),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                            return MyData();
                          }) );
                        }, icon: Icon(Icons.add_box)),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                              return MyData();
                            }) );
                            // Show a confirmation dialog before deletion
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Donor'),
                                  content: Text('Are you sure you want to delete this donor?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        // Call the delete method
                                        _deleteDonor(index);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),

                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegistrationForm()),
          );
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        tooltip: 'Add New Donor',
      ),
    );
  }
}
