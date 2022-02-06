import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:latlong2/latlong.dart';

import 'main_map.dart';
import 'model/tour.dart';

class SearchPanel extends StatefulWidget
{
  const SearchPanel({Key? key}) : super(key: key);

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel>
{
  _SearchPanelState()
  {
    tourList = testTours.where((tour) => true).toList();
  }

  var testTours = [
    Tour('UCSB', 'The worst campus.', 4.5, LatLng(34.413963, -119.848946), const Image(image: AssetImage('images/Storke.JPG')), []),
    Tour('UCSB', 'The best campus.', 4.5, LatLng(34.413963, -119.848946), const Image(image: AssetImage('images/Storke.JPG')), []),
    Tour('UCSB', 'The best campus.', 4.5, LatLng(34.413963, -119.848946), const Image(image: AssetImage('images/Storke.JPG')), []),
    Tour('UCSB', 'The best campus.', 4.5, LatLng(34.413963, -119.848946), const Image(image: AssetImage('images/Storke.JPG')), [])
  ];

  late List<Tour> tourList;

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final maxPanelHeight = MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight?.round() ?? 0);

    return SlidingUpPanel(
      backdropEnabled: true,
      maxHeight: maxPanelHeight,
      panel: FloatingSearchBar(
        hint: 'Search...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
          setState(() => {
            tourList = testTours.where((tour) => tour.name.contains(query) || tour.description.contains(query)).toList()
          });
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.place),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: tourList.map((tour) => tour.toTile()).toList(),
              ),
            ),
          );
        },
      ),
      body: const MainMap(),
    );
  }
}