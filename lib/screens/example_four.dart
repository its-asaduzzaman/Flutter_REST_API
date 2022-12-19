import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  dynamic data;
  Future<void> getUserApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode"
        ".com/users"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("loading");
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        return Card(
                            child: Column(
                          children: [
                            CustomRow(
                                title: "Name: ",
                                apiData: data[index]['name'].toString()),
                            CustomRow(
                                title: "let: ",
                                apiData: data[index]['address']['geo']['lat']),
                          ],
                        ));
                      });
                }
              },
            ),
          ),
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
