import 'package:flutter/material.dart';
import 'package:patterns_scoped/model/post_model.dart';
import 'package:patterns_scoped/pages/create_page.dart';
import 'package:patterns_scoped/pages/update_page.dart';
import 'package:patterns_scoped/services/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScoped extends Model {
  bool isLoading = false;
  List<Post> items = new List();

  Future<void> apiPostList() async {
    isLoading = true;
    notifyListeners();

    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = new List();
    }
    isLoading = false;
    notifyListeners();
  }


  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();

    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading = false;
    notifyListeners();
    return response != null;
  }

  Future<void> apiUpdatePost(BuildContext context, Post post) async{
    String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePage(post: post,)));
    if(result != null) {
      Post newPost = Network.parsePost(result);
      items[items.indexWhere((element) => element.id == newPost.id)] = newPost;
    }
    notifyListeners();
  }

  Future<void> apiCreatePost(BuildContext context) async{
    String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePage()));
    if(result != null) items.add(Network.parsePost(result));
    notifyListeners();
  }
}