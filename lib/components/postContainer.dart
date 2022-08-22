import 'package:flutter/material.dart';
import '../data/models.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import '../apiLayer/requests.dart';
import '../offline/controlDB.dart';

class PostContainer extends StatefulWidget {
  PostContainer({Key? key,required this.post}) : super(key: key);

  final Post post;

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {

  List<String> led = [];

  @override
  Widget build(BuildContext context) {
    return  Container(
                margin:const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 25),
                padding: const EdgeInsets.all(5),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset:const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        GestureDetector(
                          //onTap: () => Second(context,index,1),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                            NetworkImage(widget.post.owner.picture),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(width:7),
                        Row(
                          children: [
                            Column(
                                children:[
                                  Text(widget.post.owner.title+'.'+' '+widget.post.owner.firstName+' '+widget.post.owner.lastName,
                                    style:const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(height:3),
                                  Text(widget.post.publishDate)
                                ]
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.93,
                      child: Text(widget.post.text,style:const TextStyle(
                          fontSize: 15
                      )),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        GestureDetector(
                          //onTap: () => Second(context,index,2),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.93,              
                            child: Image.network(widget.post.image,height: 250,fit: BoxFit.cover,) ,
                          ),
                        ),
                        const SizedBox(width: 5,),

                      ],
                    ),
                    const SizedBox(height: 15,),

                    Row(
                      children: [
                        IconButton(
                         
                            onPressed: () async{

                              setState(() {
                                int l =widget.post.likes;
                              String s = widget.post.id;
                              if(led.contains(s)){
                                l--;
                                led.remove(s);

                              }
                              else{
                                l++;
                                led.add(s);
                              }
                              liked(widget.post.id, l);

                              });

                            },
                            icon:Icon(
                              led.contains(widget.post.id)?Icons.favorite:Icons.favorite_border,
                              size: 29,
                              color: Colors.redAccent,
                            )
                        ),
                        Text(
                            '${widget.post.likes}',
                          style:const TextStyle(
                            fontSize: 21
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Container(
                          height: 25,
                          width: 1,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 15,),
                        IconButton(
                            onPressed: ()async {
                              print('${widget.post.image}');
                              var path ;
                              
                              try {
                                //showLoadingDialog(context);
                               print('${widget.post.image}');
                                // https://img-fotki.yandex.ru/get/5114/127863950.77/0_87274_1261ad98_orig.jpg
                                var imageId = await ImageDownloader.downloadImage(widget.post.image);
                                
                                //widget.posts[index].image

                                if (imageId == null) {
                                  Fluttertoast.showToast(msg: '$imageId');
                                  Fluttertoast.showToast(msg: 'image not d');
                                }
                                // Below is a method of obtaining saved image information.

                                  var fileName = await ImageDownloader.findName(imageId!);
                                  path = await ImageDownloader.findPath(imageId);
                                  var size = await ImageDownloader.findByteSize(imageId);
                                  var mimeType = await ImageDownloader.findMimeType(imageId);
                                  //Navigator.pop(context);
                                  Fluttertoast.showToast(msg:  'Image downloaded.');

                              } catch (error) {
                                Fluttertoast.showToast(msg:  'Image error.$error');

                              }
                              await addToDataBase(widget.post.id,widget.post.text,path);

                            },
                            icon:const Icon(
                              Icons.save_alt_outlined,
                              size: 29,
                              color: Colors.redAccent,
                            ),
                        ),
                        const SizedBox(width: 15,),
                        Container(
                          height: 25,
                          width: 1,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 15,),
                        const SizedBox(width: 15,),
                        const Icon(
                              Icons.comment,
                              size: 29,
                              color: Colors.redAccent,
                            ),

                      ],
                    ),

                  ],
                ),
              );
  }
}

/*

var path ;
                              var response = await Dio().get(
                                "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
                                options: Options(responseType: ResponseType.bytes)
                              );
                              final result = await ImageGallerySaver.saveImage(
                                Uint8List.fromList(response.data),
                                quality: 60,
                                name: "hello"
                              );
                              print(result);
 */