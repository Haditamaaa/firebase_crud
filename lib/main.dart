import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late String name, description;
  late double price;

  getName(name){
    this.name = name;
    print(this.name);
  }

  getDescription(description){
    this.description = description;
    print(this.description);
  }

  getPrice(price){
    this.price = double.parse(price);
    print(this.price);
  }

  createData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("Car").doc(name);

    Map<String, dynamic> car = {
      "name": name,
      "description": description,
      "price": price
    };

    documentReference.set(car).whenComplete((){
      print("$name created");
    });
  }
  


  updateData(){
    print("update");
  }

  deleteData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("Car").doc(name);

    documentReference.delete().whenComplete((){
      print("$name deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase CRUD"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Name"
              ),
              onChanged: (String name) {
                getName(name);
              },
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Description"
              ),
              onChanged: (String description) {
                getDescription(description);
              },
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Price"
              ),
              onChanged: (String price) {
                getPrice(price);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.green,
                         foregroundColor: Colors.white
                       ),
                        onPressed: (){
                         createData();
                        },
                        child: const Text("Create"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white
                      ),
                      onPressed: (){

                      },
                      child: const Text("Read"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white
                      ),
                      onPressed: (){
                        updateData();
                      },
                      child: const Text("Update"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white
                      ),
                      onPressed: (){
                        deleteData();
                      },
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

