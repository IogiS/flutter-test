import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/model/videocards_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class mainContent extends StatefulWidget {
  @override
  _mainContentState createState() => _mainContentState();
}

class _mainContentState extends State<mainContent> {
  int currentPage = 1;

  late int totalPages;

  List<VideocardsData> videoCard = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getVideocardsData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage > totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse(
        "https://my-json-server.typicode.com/IogiS/FakeRestAPI/videocards");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = videocardsDataFromJson(response.body);

      final currentPageContent = currentPage * 10;
      List<VideocardsData> res = [];
      result.forEach((element) {
        if (element.id <= currentPageContent) {
          if (element.id >= currentPageContent - 9) {
            res.add(element);
          }
        }
      });

      if (isRefresh) {
        videoCard = res;
      } else {
        videoCard.addAll(res);
      }
      currentPage++;

      totalPages = result.length ~/ 10;

      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List Pagination"),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getVideocardsData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getVideocardsData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final passenger = videoCard[index];

            return ListTile(
              title: Text(passenger.name),
              subtitle: Text(passenger.manufacturer.toString()),
              trailing: Image(
                image: NetworkImage(passenger.img),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticlePage(passenger)));
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: videoCard.length,
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  final VideocardsData article;
  ArticlePage(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(article.manufacturer.toString()),
            Image(
              image: NetworkImage(article.img),
            )
          ],
        ),
      ),
    );
  }
}
