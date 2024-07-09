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
          : ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return ListTile(
                  title: Text(city['Title']), // Adjust according to the JSON structure
                );
              },
            ),
    );
  }
}
