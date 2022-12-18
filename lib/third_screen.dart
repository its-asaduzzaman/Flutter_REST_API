import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/third_screen_model.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<ThirdScreenModel> commentList = [];

  Future<List<ThirdScreenModel>> getComment() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        ThirdScreenModel comment = ThirdScreenModel(
            body: i["body"],
            email: i["email"],
            name: i["name"],
            id: i["id"],
            postId: i["postId"]);

        commentList.add(comment);
      }
      return commentList;
    } else {
      return commentList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: FutureBuilder(
                future: getComment(),
                builder:
                    (context, AsyncSnapshot<List<ThirdScreenModel>> snapshot) {
                  return ListView.builder(
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(20),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                    "ID: ${snapshot.data![index].id.toString()}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Name: ${snapshot.data![index].name.toString()}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Email: ${snapshot.data![index].email.toString()}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Body: ${snapshot.data![index].body.toString()}"),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        );
                      });
                }))
      ],
    ));
  }
}
