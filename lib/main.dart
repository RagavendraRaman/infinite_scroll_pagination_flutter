/*
 * created by Ragavendra & GnanaPrakash
 * Created on 17/10/2022
 *
 */




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinte_scroll/model/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final controller = ScrollController();

  List<Pagination> items = [];
  int page = 1;
  bool hasMore = true; 
  bool isLoading = false; 

  @override
  void initState() {
    super.initState();
    fetch();
    controller.addListener(() { 
      if(controller.position.maxScrollExtent == controller.offset){
        fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<List<Pagination>> fetch() async{

    if(isLoading) return items;
    
    isLoading =  true;

      const limit = 10;

      final url = Uri.parse('https://api.yellow-time.de/app/message/list?pageNumber=$page&itemsPerPage=$limit');
      final response = await http.get(url,headers: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhbm5pa2VAeWFob28uY29tIiwiYXV0aCI6eyJhdXRob3JpdHkiOiJBUFBfREVGQVVMVF9ST0xFIn0sInVzZXJOYW1lIjoiYW5uaWtlQHlhaG9vLmNvbSIsImRldmljZUlkIjoiMTgwMDk4MjkyMjI4MTExIiwiaWF0IjoxNjY2MDEwNTYyLCJleHAiOjE2NjYwMTQxNjJ9.qRU6u58Ujdi9HnZ8HrZU1rhwXEhV1c1NebrlaunzxXs'});
    
    if(response.statusCode == 200){

      var newItems = json.decode(response.body);
      print(newItems);
  
       var data=newItems["data"]["data"]["messages"];
       print(data);

      setState(() {
      page++;
      isLoading = false;

      if (data.length < limit){
        hasMore = false;
      }
       for (int i = 0; i < data.length; i++) {

        items.add(Pagination.fromJson(data[i]));

      }
      // items.addAll(newItems.map<String>((item) {
      //   final number = item['id'];

      //   return 'Item $number';
      // }).toList());
      
    });
    }
    return items;
  }

  Future refresh() async{
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      items.clear();
    });

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Pagination'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          controller: controller,
          padding: const EdgeInsets.all(8.0),
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
           if(index < items.length){
             final item = items[index];
      
            return ListTile(title: Text(item.message.toString()),);
           }else{
            return  Padding(padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: 
            hasMore ? const CircularProgressIndicator() : const Text('No More Data')),
            );
           }
          }),
      ),
    );
  }
}
