import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/second_screen_model.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<SecondScreenModel> photoList = [];

  Future<List<SecondScreenModel>> getPhoto() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        SecondScreenModel photo = SecondScreenModel(
          title: i["title"],
          thumbnailUrl: i["thumbnailUrl"],
          url: i["url"],
          albumId: i["albumId"],
          id: i["id"],
        );
        photoList.add(photo);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPhoto(),
                  builder: (context,
                      AsyncSnapshot<List<SecondScreenModel>> snapshot) {
                    return ListView.builder(
                        itemCount: photoList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].url.toString()),
                            ),
                            title:
                                Text('Notes ID: ${snapshot.data![index].id}'),
                            subtitle:
                                Text(snapshot.data![index].title.toString()),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
