import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/example_three_model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<ExampleThreeModel> userList = [];
  Future<List<ExampleThreeModel>> getUserApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode"
        ".com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        ExampleThreeModel users = ExampleThreeModel.fromJson(i);
        userList.add(users);
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context,
                      AsyncSnapshot<List<ExampleThreeModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomRow(
                                        title: "Id: ",
                                        apiData: snapshot.data![index].id
                                            .toString()),
                                    CustomRow(
                                        title: "Name: ",
                                        apiData: snapshot.data![index].name
                                            .toString()),
                                    CustomRow(
                                        title: "Username: ",
                                        apiData: snapshot.data![index].username
                                            .toString()),
                                    CustomRow(
                                        title: "Email: ",
                                        apiData: snapshot.data![index].email
                                            .toString()),
                                    const Text(
                                      "Address: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomRow(
                                              title: "Street: ",
                                              apiData: snapshot
                                                  .data![index].address!.street
                                                  .toString()),
                                          CustomRow(
                                              title: "Suite: ",
                                              apiData: snapshot
                                                  .data![index].address!.suite
                                                  .toString()),
                                          CustomRow(
                                              title: "City: ",
                                              apiData: snapshot
                                                  .data![index].address!.city
                                                  .toString()),
                                          CustomRow(
                                              title: "Zipcode: ",
                                              apiData: snapshot
                                                  .data![index].address!.zipcode
                                                  .toString()),
                                          const Text(
                                            "Geo: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              children: [
                                                CustomRow(
                                                    title: "Lat: ",
                                                    apiData: snapshot
                                                        .data![index]
                                                        .address!
                                                        .geo!
                                                        .lat
                                                        .toString()),
                                                CustomRow(
                                                    title: "Lng: ",
                                                    apiData: snapshot
                                                        .data![index]
                                                        .address!
                                                        .geo!
                                                        .lng
                                                        .toString()),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }))
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String title;
  final dynamic apiData;
  const CustomRow({
    Key? key,
    required this.title,
    required this.apiData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(apiData),
      ],
    );
  }
}
