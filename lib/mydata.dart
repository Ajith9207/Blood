import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  late String name = "No user found";
  late String age = "";
  late String weight = "";
  late String bloodGroup = "Not available";
  late String lastDonated = "Not available";
  late String phone = "Not available";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "No user found";
      age = prefs.getString("age") ?? "Not specified";
      weight = prefs.getString("weight") ?? "Not specified";
      bloodGroup = prefs.getString("bloodGroup") ?? "Not available";
      lastDonated = prefs.getString("lastDonated") ?? "Not available";
      phone = prefs.getString("phone") ?? "Not available";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Data"), backgroundColor: Colors.redAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(name),
                leading: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Age", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(age),
                leading: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Weight", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(weight),
                leading: Icon(Icons.fitness_center),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Blood Group", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(bloodGroup),
                leading: Icon(Icons.local_hospital),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Last Donated", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(lastDonated),
                leading: Icon(Icons.access_time),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Phone", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(phone),
                leading: Icon(Icons.phone),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
