import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);
}

class AddressSearch extends SearchDelegate<Suggestion?> {
  final String sessionToken;

  AddressSearch(this.sessionToken);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _fetchSuggestions(query, sessionToken),
      builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text('No suggestions'),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(snapshot.data![index].description),
              onTap: () {
                close(context, snapshot.data![index]);
              },
            ),
            itemCount: snapshot.data!.length,
          );
        }
      },
    );
  }

  Future<List<Suggestion>> _fetchSuggestions(String input, String sessionToken) async {
    if (input.isEmpty) {
      return [];
    }
    final String apiKey = 'YOUR_GOOGLE_API_KEY';
    final String request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken';
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }
}

// Example of calling AddressSearch and handling the null case
class MyHomePage extends StatelessWidget {
  final String sessionToken = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Search Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final Suggestion? result = await showSearch<Suggestion?>(
              context: context,
              delegate: AddressSearch(sessionToken),
            );

            if (result != null) {
              // Handle the selected suggestion
              print('Selected suggestion: ${result.description}');
            } else {
              // Handle the case when no suggestion was selected
              print('No suggestion selected.');
            }
          },
          child: Text('Search Address'),
        ),
      ),
    );
  }
}