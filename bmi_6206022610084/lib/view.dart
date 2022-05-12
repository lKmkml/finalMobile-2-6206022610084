import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class View extends StatefulWidget {
  View({Key key, this.country, this.db}) : super(key: key);
  Map country;
  Database db;
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController sexController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController bmiController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.country);
    nameController.text = widget.country['name'];
    ageController.text = widget.country['age'];
    sexController.text = widget.country['sex'];
    heightController.text = widget.country['height'];
    weightController.text = widget.country['weight'];
    bmiController.text = widget.country['BMI'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00BCD1),
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
        title: Text("BMI View"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.db.delete(widget.country["id"]);
                Navigator.pop(context, true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("ชื่อ"),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("เพศ"),
                controller: sexController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("อายุ"),
                controller: ageController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("ความสูง"),
                controller: heightController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("น้ำหนัก"),
                controller: weightController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: OutlinedButton(
              //color: Colors.black,
              onPressed: () {
                widget.db.update(
                    widget.country['id'],
                    nameController.text,
                    sexController.text,
                    weightController.text,
                    heightController.text,
                    ageController.text,
                    bmiController.text);
                Navigator.pop(context, true);
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}
