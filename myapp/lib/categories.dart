import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/categoryModel.dart';
import 'package:http/http.dart' as http;

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final bool _isloading = false;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  Future<List<Category>> getAllCategories() async {
    const url = 'http://192.168.8.102:8000/api/categories/';

    var response = await http.get(Uri.parse(url));

    var jsonData = json.decode(response.body);
    var jsonArray = jsonData['data'];
    List<Category> categories = [];
    print('******2**************');
    print(jsonArray.length);
    for (var jsonCategory in jsonArray) {
      print('******5**************');
      Category category = Category(
          // id: jsonCategory['id'],
          // code: jsonCategory['code'],
          name: jsonCategory['name'],
          // slug: jsonCategory['slug'],
          // display_mode: jsonCategory['display_mode'],
          description: jsonCategory['description'],
          // meta_title: jsonCategory['meta_title'],
          // meta_description: jsonCategory['meta_description'],
          // meta_keywords: jsonCategory['meta_keywords'],
          // status: jsonCategory['status'],
          // category_icon_path: jsonCategory['category_icon_path'],
          image_url: jsonCategory['image_url']
          // additional: jsonCategory['additional'],
          // created_at: jsonCategory['created_at'],
          // updated_at: jsonCategory['updated_at']
          );
      categories.add(category);
      print('********************');
      print(category);
    }
    print('******3**************');

    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Category List'),
        ),
        body: FutureBuilder<List<Category>>(
          future: getAllCategories(),
          builder: (context, snapshot) {
            try {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else {
                setState(() {
                  getAllCategories();
                });
                return Center(
                  child: Text(snapshot.data!.length.toString()),
                );
              }
            } catch (e) {
              print(e.toString());
              return Center(
                child: Text(e.toString()),
              );
            }
          },
        ));
  }
}
