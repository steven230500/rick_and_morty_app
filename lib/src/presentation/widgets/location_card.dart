import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/data/models/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      child: ListTile(
        title: Text(location.name),
        subtitle: Text(location.type),
        trailing: IconButton(
          icon: const Icon(Icons.map),
          onPressed: () {},
        ),
        onTap: () {},
      ),
    );
  }
}
