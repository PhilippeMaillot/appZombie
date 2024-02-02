import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TournoiPage extends StatefulWidget {
  static String baseUrl = "http://localhost:8080";

  const TournoiPage({Key? key}) : super(key: key);

  @override
  _TournoiPageState createState() => _TournoiPageState();
}

class _TournoiPageState extends State<TournoiPage> {
  late Future<List> _tournois;

  @override
  void initState() {
    super.initState();
    _tournois = getAllTournois();
  }

  Future<List> getAllTournois() async {
    try {
      var res = await http.get(Uri.parse(TournoiPage.baseUrl + "/tournament"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception("Erreur Serveur");
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat.yMd().format(dateTime);
  return formattedDate;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Tournois"),
      ),
      body: FutureBuilder(
        future: _tournois,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Erreur : ${snapshot.error}");
          } else {
            List tournois = snapshot.data as List;
            return ListView.builder(
              itemCount: tournois.length,
              itemBuilder: (context, index) {
                var tournoi = tournois[index];
                return ListTile(
                  title: Text(tournoi["tournament_name"]),
                  subtitle: Text(formatDateTime(tournoi["tournament_date"])),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TournoiPage(),
  ));
}
