import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityScreen extends StatefulWidget {
  final int countryId;

  CityScreen({required this.countryId});

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<Map<String, dynamic>> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCities().then((data) {
      setState(() {
        cities = data;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load cities: $error');
    });
  }

  Future<List<Map<String, dynamic>>> fetchCities() async {
    final response = await http.get(Uri.parse('https://www.bme.seawindsolution.ae/api/f/city/${widget.countryId}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == true && responseBody['responsedata'] is List) {
        return List<Map<String, dynamic>>.from(responseBody['responsedata']);
      } else {
        throw Exception('Failed to load cities');
      }
    } else {
      throw Exception('Failed to load cities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cities'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.7, 
              ),
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          city['Image'], // Adjust according to the JSON structure
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          city['Title'], // Adjust according to the JSON structure
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
