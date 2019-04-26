import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Serch Bar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      drawer: Drawer(),
      body: Center(child: Text("Load instrument card when fetched")),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  String x = "";

  final cities = [
    "Mumbai",
    "Colombo",
    "Galle",
    "Mathara",
    "Hambanthota",
    "Aswadduma",
    "Gampaha",
    "Uwa",
    "Sathgamuwa",
    "Ambagamuwa",
    "Qurty",
    "Walgmpola",
    "Egodauyana",
    "Dasnayaka",
    "Rathgama",
    "Ambalangoda",
    "Irugoda",
    "Tasgama"
  ];

  final recentcities = [
    "Colombo",
    "Galle",
    "Mathara",
    "Hambanthota",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //what kind of actions to perform
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //show results based on the selection
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(x),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone serches of something

    final suggesionList = query.isEmpty
        ? recentcities
        : cities
            .where((p) =>
                p.startsWith(query[0].toUpperCase() + query.substring(1)))
            .toList();
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => ListTile(
          onTap: () {
            showResults(context);
            print(suggesionList);
            print(index);
            print(suggesionList[index]);
            x = suggesionList[index];
          },
          leading: Icon(Icons.location_city),
          title: RichText(
              text: TextSpan(
                  text: suggesionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: suggesionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ]))),
      itemCount: suggesionList.length,
    );
  }
}
