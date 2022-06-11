import 'dart:convert'; //jsonDecode

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalData.dart';
import '/main.dart';
import '/GlobalData.dart';

// import 'dart:async';

class NotionAPI {
  Future<void> getDatabase() async {
    await dotenv.load(fileName: ".env"); //to get NOTION_TOKEN

    String _res = '';
    String notionToken = dotenv.env['NOTION_TOKEN'] as String;
    String databaseID = dotenv.env['DATABASE_ID'] as String;

    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer $notionToken',
      'Notion-Version': '2022-02-22'
    };
    var request = http.Request(
        'GET', Uri.parse('https://api.notion.com/v1/databases/$databaseID'));

    request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print('ok');
        _res = await response.stream.bytesToString();
        // print(_res);
        Map<String, dynamic> map = jsonDecode(_res);

        dbNameList = [];
        dbTypeList = [];
        for (Map m in map['properties'].values) {
          dbNameList.add(m['name']);
          dbTypeList.add(m['type']);
        }
        print(dbNameList[0]);
        print(dbTypeList[0]);
        // } else if (response.statusCode == 401) {
        //   print('??マルチログインエラーです。他のソフトで、同じnotionTokenを使用していませんか？');
      } else {
        print('notion側でエラー');

        print(response.reasonPhrase);
        print(response.statusCode);

        print('notionToken   $notionToken');
        print('databaseID   $databaseID');
      }
    } on Exception catch (_) {
      print('network is dead.');
    }
  }

  //保存
  Future<void> setData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('NameList', dbNameList);
    await prefs.setStringList('TypeList', dbTypeList);
    print('保存しました。');
  }

  //取得
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    dbNameList = prefs.getStringList('NameList') ?? [];
    dbTypeList = prefs.getStringList('TypeList') ?? [];
    print('取得しました。');
  }
}
