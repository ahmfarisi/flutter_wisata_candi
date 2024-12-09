import 'package:flutter/material.dart';
import 'package:flutter_wisata_candi/data/candi_data.dart';
import 'package:flutter_wisata_candi/models/candi.dart';
import 'package:flutter_wisata_candi/screens/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Candi> _filteredCandiList = [];

  @override
  void initState() {
    super.initState();
    // _filteredCandiList = candiList;
    _searchController.addListener(_filterCandiList);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.removeListener(_filterCandiList);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCandiList() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCandiList = [];
      } else {
        _filteredCandiList = candiList.where((candi) {
          return candi.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[50],
              ),
              child: TextField(
                controller: _searchController,
                autofocus: false,
                decoration: const InputDecoration(
                    hintText: 'Cari Candi ...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _filteredCandiList.length,
            itemBuilder: (context, index) {
              Candi candi = _filteredCandiList[index];
              return ListTile(
                title: Text(candi.name),
                subtitle: Text(candi.location),
                leading: Image.asset(
                  candi.imageAsset,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailScreen(candi: candi);
                  }));
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
