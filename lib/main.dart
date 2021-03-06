import 'package:flutter/material.dart';
import 'package:api_call/api_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Users>> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: const Text('Api Calls in Flutter'),
          centerTitle: true,
          backgroundColor: Colors.indigo),
      // ignore: avoid_unnecessary_containers
      body: Container(
        color: Color.fromARGB(255, 195, 189, 209),
        child: Center(
          child: FutureBuilder<List<Users>>(
              future: users,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].email),
                          trailing: Text(snapshot.data![index].username),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    ));
  }
}
