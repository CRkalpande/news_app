import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../model/article.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  int ind;
  NewsCard({
    Key? key,
    required this.ind,
    required this.postList,
  }) : super(key: key);

  shareData() {
    Share.share("${postList[ind].title!}" + "\n" "${postList[ind].url}");
  }

  final List<Article> postList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // launchUrl(Uri.parse(postList[ind].url!));
        FlutterWebBrowser.openWebPage(url: postList[ind].url!);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black)),
          // color: Colors.black54,
          child: Column(
            children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    postList[ind].urlToImage!,
                    fit: BoxFit.fill,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return child;
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  postList[ind].title!,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${postList[ind].source?.name} ",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.heart_fill,
                        size: 18,
                      )),
                  IconButton(
                      onPressed: () {
                        shareData();
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 18,
                      )),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 300,
                              color: Color(0xFF403B58),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      "More Options"
                                          .text
                                          .xl
                                          .color(Colors.white)
                                          .semiBold
                                          .make()
                                          .pOnly(left: 20),
                                      IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: Icon(
                                          CupertinoIcons.clear,
                                          color: Colors.white,
                                        ),
                                        alignment: Alignment.centerRight,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 88, 86, 86),
                                    indent: 8,
                                    endIndent: 10,
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                        ),
                                        title: "About this source & topic"
                                            .text
                                            .color(Colors.white)
                                            .make(),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.flag_outlined,
                                          color: Colors.white,
                                        ),
                                        title: "About this source & topic"
                                            .text
                                            .color(Colors.white)
                                            .make(),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                        ),
                                        title: "Report this"
                                            .text
                                            .color(Colors.white)
                                            .make(),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.feedback_outlined,
                                          color: Colors.white,
                                        ),
                                        title: "Send feedback"
                                            .text
                                            .color(Colors.white)
                                            .make(),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.ellipsis_vertical,
                        size: 18,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
