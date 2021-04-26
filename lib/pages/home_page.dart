import 'package:flutter/material.dart';
import 'package:patterns_scoped/scopes/home_scoped.dart';
import 'package:patterns_scoped/views/item_of_post.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeScoped scoped = HomeScoped();

  @override
  void initState() {
    super.initState();
    scoped.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(model: scoped, child: ScopedModelDescendant<HomeScoped>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Scoped Model"),
            ),
            body: Stack(
              children: [
                ListView.builder(
                  itemCount: scoped.items.length,
                  itemBuilder: (context, index) {
                    return itemOfPost(context, scoped, scoped.items[index]);
                  },
                ),
                scoped.isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : SizedBox.shrink(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () {
                scoped.apiCreatePost(context);
              },
              child: Icon(Icons.add),
            ));
      },
    ));
  }
}
