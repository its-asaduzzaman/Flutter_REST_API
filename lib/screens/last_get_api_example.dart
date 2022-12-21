import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ProductsModel.dart';

class LastApiGetExample extends StatefulWidget {
  const LastApiGetExample({Key? key}) : super(key: key);

  @override
  State<LastApiGetExample> createState() => _LastApiGetExampleState();
}

class _LastApiGetExampleState extends State<LastApiGetExample> {
  Future<ProductsModel> getProduct() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/3822418d-09ec-49cf-a8ab-c8df792ac932'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<ProductsModel>(
              future: getProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            BigTextWidget(
                              text: snapshot.data!.message.toString(),
                            ),
                            BigTextWidget(
                              text: snapshot.data!.data![index].createdAt
                                  .toString(),
                            ),
                          ],
                        );
                      });
                } else {
                  return Text("Loading");
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}

class BigTextWidget extends StatelessWidget {
  final String text;
  const BigTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 22),
    );
  }
}
