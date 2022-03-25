import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/album.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest Api',
      home: RestApiIntigration(),
    );
  }
}

class RestApiIntigration extends StatefulWidget {
  const RestApiIntigration({Key? key}) : super(key: key);

  @override
  State<RestApiIntigration> createState() => _RestApiIntigrationState();
}

class _RestApiIntigrationState extends State<RestApiIntigration> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Future<Album> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    );
    if (response.statusCode == 200) {
      return Album.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api Intigration'),
        centerTitle: true,
      ),
      body: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.title);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
