import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<dynamic>> fetchPosts()async{
    Response response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rania Get Data with Dio"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if (snapshot.hasError){
            return Center(child: Text("Error ${snapshot.hasError}"),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return const Center(child: Text("No data found"),);
          }
          List<dynamic> posts = snapshot.data!;
          return   RefreshIndicator(

            onRefresh: () {
              setState(() {

              });
              return fetchPosts();
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                dynamic post = posts[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(post['id'].toString()),
                  ),
                  title: Text(post['title']),
                  subtitle: Text(post['title']),
                );
              },

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
           fetchPosts();
        });

      },child: Icon(Icons.refresh),),
    );
  }
}


//  get data with dio (future builder)
// add model
// cubit ans states