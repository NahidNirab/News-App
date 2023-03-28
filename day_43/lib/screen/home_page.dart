import 'dart:convert';
import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:day_43/model/news_model.dart';
import 'package:day_43/provider/news_provider.dart';
import 'package:day_43/screen/news_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sortBy = "publishedAt";
  int pageNo = 1;
  final controller = ScrollController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ruper Alo News"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (pageNo == 1) {
                            return null;
                          } else {
                            setState(() {
                              pageNo -= 1;
                            });
                          }
                        },
                        child: Text("Prev")),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  pageNo = index + 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: pageNo == index + 1
                                        ? Colors.deepPurple
                                        : Colors.teal,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.only(right: 5),
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (pageNo < 10) {
                            setState(() {
                              pageNo += 1;
                            });
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: DropdownButton(
                  value: sortBy,
                  items: [
                    DropdownMenuItem(
                      child: Text("relevancy"),
                      value: "relevancy",
                    ),
                    DropdownMenuItem(
                      child: Text("popularity"),
                      value: "popularity",
                    ),
                    DropdownMenuItem(
                      child: Text("publishedAt"),
                      value: "publishedAt",
                    ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      sortBy = value!;
                    });
                  },
                ),
              ),
              FutureBuilder<NewsModel>(
                future: newsProvider.getHomeData(pageNo, sortBy),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Something is wrong");
                  } else if (snapshot.data == null) {
                    return Text("snapshot data are null");
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsDetails(
                                    articles: snapshot.data!.articles![index],
                                  )));
                        },
                        child: Container(
                          color: Colors.white,
                          height: 130,
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 120,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 120,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(14),
                                margin: EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${snapshot.data!.articles![index].urlToImage}",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
                                        ),
                                        //Image(image: NetworkImage("${snapshot.data!.articles![index].urlToImage}",))
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        flex: 10,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${snapshot.data!.articles![index].title}",
                                              maxLines: 2,
                                            ),
                                            Text(
                                                "${snapshot.data!.articles![index].publishedAt}")
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          )),
    );
  }
}

// Void scrollDown(){
//                 final double end = 0;
//                 controller.position.maxScrollExtent(setState(() {
//                               pageNo += 1;
//                             }))
//               }

