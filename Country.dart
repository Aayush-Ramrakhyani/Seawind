import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:seawind/City.dart';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<Map<String, dynamic>> countries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCountries().then((data) {
      setState(() {
        countries = data;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load countries: $error');
    });
  }

  Future<List<Map<String, dynamic>>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://www.bme.seawindsolution.ae/api/f/country'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == true && responseBody['responsedata'] is List) {
        return List<Map<String, dynamic>>.from(responseBody['responsedata']);
      } else {
        throw Exception('Failed to load countries');
      }
    } else {
      throw Exception('Failed to load countries');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 0.7, // Adjust the aspect ratio as needed
              ),
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityScreen(countryId: country['Id']),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            country['Image'], // Adjust according to the JSON structure
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            country['Title'], // Adjust according to the JSON structure
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
