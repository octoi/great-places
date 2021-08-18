import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/places_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    builder: (ct, greatPlaces, child) =>
                        greatPlaces.items.length <= 0
                            ? child != null
                                ? child
                                : Text(':(')
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (ctx, i) {
                                  final place = greatPlaces.items[i];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(place.image),
                                    ),
                                    title: Text(place.title),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        PlacesDetailScreen.routeName,
                                        arguments: place.id,
                                      );
                                    },
                                  );
                                },
                              ),
                    child: Center(
                      child: Text('Got no places yet, start adding some!'),
                    ),
                  ),
      ),
    );
  }
}
