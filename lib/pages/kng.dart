import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:topteam/common/utils.dart';
import 'package:topteam/common/widgets.dart';
import 'package:topteam/services/main.dart';

import 'kng/detail.dart';

class KngPage extends StatefulWidget {
  KngPage({Key key}) : super(key: key);

  @override
  _KngPageState createState() => _KngPageState();
}

class _KngPageState extends State<KngPage> {
  var kng = DataList(pageSize: 10, loading: true);
  var query = {
    'orderby': 'hotIndex',
    'direction': 'desc',
    'isHidden': 0,
    'type': 1,
  };
  @override
  void initState() {
    this.getList();
    super.initState();
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('企业课程'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        itemCount: kng.list.length + 1,
        itemBuilder: (context, index) {
          if (index == kng.list.length) {
            if (kng.loading || kng.pages > kng.pageIndex) {
              if (!kng.loading) getList();
              return Column(
                children: [
                  CircularProgressIndicator()
                ],
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Text('我也是有底线的～'),
              );
            }
          }

          var item = kng.list[index];
          return GestureDetector(
            child: Container(
              height: 72,
              margin: EdgeInsets.only(bottom: 25),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(image: NetworkImage(item['logoUrl']), fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title'], style: TextStyle(fontSize: 16, color: Color(0xff333333)), overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 6,),
                        AppText('${item['studyHours']}分钟', fontSize: 12,),
                        SizedBox(height: 6,),
                        AppText('${item['studyCount']}人学过', color: Color(0xff999999), fontSize: 12,)
                      ],
                    )
                  )
                ],
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (item['fileType'] == 'video') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KngDetail(item['id'], title: item['title'])));
              }
            },
          );
        }
      )
    );
  }
  void getList() {
    kng.pageIndex++;
    kng.loading = true;

    query.addEntries(kng.paging.entries);
    getKngList(kng.paging).then((res) {
      var data = jsonDecode(res.toString());
      setState(() {
        kng.loading = false;
        kng.list.addAll(data['datas']);
        kng.pages = data['paging']['pages'];
        kng.count = data['paging']['count'];
      });
    }).catchError((err) {
      setState(() {
        kng.loading = false;
      });
    });
  }
}