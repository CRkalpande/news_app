// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:news_app/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:news_app/model/article.dart';
import 'package:news_app/model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> postList = [];
  Future<List<Article>> getPostApi() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=86b1ae23ca8f4b1697c247e7eb66b706'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // var model = Model.fromJson(response.body);
      // postList = model.articles!;
      postList = Model.fromJson(response.body).articles!;
      return postList;
    } else {
      // return postList;
      return postList;
    }
    // return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF403B58),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "News App".text.xl5.bold.white.make().py12(),
                  "Trending News".text.xl2.white.make(),
                ],
              ).p16(),
              Expanded(
                child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) {
                          return postList[index].urlToImage == null
                              ? Container()
                              : NewsCard(
                                  postList: postList,
                                  ind: index,
                                );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
