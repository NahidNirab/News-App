import 'package:day_43/model/news_model.dart';
import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails({Key? key, this.articles}) : super(key: key);
  Articles? articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${articles!.author}"),
      ),
      body: Container(
        color: Colors.teal,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.teal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${articles!.title}",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${articles!.publishedAt}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        "${articles!.publishedAt}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Image.network(
                        "${articles!.urlToImage}",
                      ),
                      Positioned(
                        bottom: 10,
                        right: 30,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_rounded,
                              color: Colors.teal,
                              size: 50,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Descreaption",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${articles!.description}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Content",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "${articles!.content}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${articles!.source}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decorationStyle: TextDecorationStyle.double),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${articles!.url}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[900],
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.blue[900],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.network("${articles!.urlToImage}"),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
