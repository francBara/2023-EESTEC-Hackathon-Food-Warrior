import 'package:athens/model/wiki/topic.dart';
import 'package:athens/screens/utils/loading_indicator.dart';
import 'package:athens/screens/wiki/topic_tile.dart';
import 'package:athens/service/topic_proxy.dart';
import 'package:flutter/material.dart';

class Wiki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wiki - Topics'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<Topic>>(
                  future: TopicProxy.getTopics(),
                  builder: (context, topics) {
                    if (topics.hasData) {
                      return ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        itemCount: topics.data!.length,
                        itemBuilder: (context, index) {
                          return TopicTile(topics.data![index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16);
                        },
                      );
                    } else if (topics.hasError) {
                      return Center(
                        child: Text('An error occurred'),
                      );
                    } else {
                      return Center(child: LoadingIndicator());
                    }
                  }))
        ],
      )),
    );
  }
}
