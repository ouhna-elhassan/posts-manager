import 'package:flutter/material.dart';
import 'package:postsapp/components/appBar.dart';
import '../data/models.dart';
import '../apilayer/requests.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
/*
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
 */
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//import 'package:image_downloader/image_downloader.dart';
import '../components/postContainer.dart';

/*
class PostContainer extends StatefulWidget {
  PostContainer({Key? key,required this.post}) : super(key: key);

  final Post post;

  @override
  State<PostContainer> createState() => _PostContainerState();
}
 */

class Posts extends StatefulWidget {
  Posts({Key? key,required this.tag}) : super(key: key);

  String? tag;

  @override
  State<Posts> createState() => _PostsState();
  //_PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  final _numberOfPostsPerRequest = 10;

  final PagingController<int, Post> _pagingController = PagingController(firstPageKey: 0);


  Future<void> getPosts(int pageKey) async{
    try {
      String tag = widget.tag??'';
      http.Client client  = http.Client();
      List<Post> postList = [];

      if(tag=="") {
        
        postList =await getpost(client,pageKey);
      }
      else {postList =await searchList(client,pageKey,tag);}
      
      final isLastPage = postList.length < _numberOfPostsPerRequest;

      if (isLastPage) {
        _pagingController.appendLastPage(postList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(postList, nextPageKey);
      }
    }catch (e){
      print("error --> $e");
    }
    
  }

  @override
  void initState() {
   
    _pagingController.addPageRequestListener((pageKey) {
       getPosts(pageKey);
    });
    super.initState();
  }

 @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
      String tag = widget.tag??'';
      return Scaffold(
        appBar:tag==""?appBar(context):null,
        body: RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh()),
          child: PagedListView<int, Post>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Post>(
              itemBuilder: (context, item, index) =>
                  GestureDetector(
                    onLongPress: (){
                      showDialog<String>(
                          context:context,
                          builder:(BuildContext context) => AlertDialog(
                            title:const Text('Delet'),
                            content: const Text('delete this post?'),
                            actions: [
                              TextButton(onPressed: (){Navigator.pop(context);Fluttertoast.showToast(msg:'Cancel');}, child: const Text('Cancel')),
                              TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    deletePost(item.id);
                                  },
                                  child: const Text('Ok')),
                              ],
                          )
                      );
                    },
                    child:  PostContainer(post: item),
            ),
          ),
        ),
        )
      );
}

}