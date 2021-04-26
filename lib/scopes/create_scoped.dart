import 'package:flutter/material.dart';
import 'package:patterns_scoped/model/post_model.dart';
import 'package:patterns_scoped/services/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateScoped extends Model {
  bool isLoading = false;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  Future apiCreatePost(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    String title = titleController.text.trim().toString();
    String body = bodyController.text.trim().toString();
    Post post = Post(title: title, body: body, userId: 1);

    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    isLoading = false;
    Navigator.pop(context, response);
    notifyListeners();
  }
}
