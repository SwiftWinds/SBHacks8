import 'package:discovar/audio_information.dart';
import 'package:discovar/model/tour_point.dart';
import 'package:discovar/tour_information.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:latlong2/latlong.dart';

import 'main_map.dart';
import 'model/tour.dart';

class MainDragPanel extends StatefulWidget
{
  const MainDragPanel({Key? key}) : super(key: key);

  @override
  State<MainDragPanel> createState() => _MainDragPanelState();
}

class _MainDragPanelState extends State<MainDragPanel>
{
  _MainDragPanelState()
  {
    tourList = testTours.where((tour) => true).toList();
  }

  var testTours = [
    Tour('UCSB', 'The best campus.', 4.5, LatLng(34.413963, -119.848946), const Image(image: AssetImage('images/Storke.JPG')), [
      TourPoint("Storke Tower", LatLng(37.413963, -119.848946), "Storke Tower is a landmark campanile located on the campus of the University of California, Santa Barbara in the United States. Dedicated for use on September 28, 1969, the 61-bell carillon tower stands 175 ft tall. It was designed by the San Francisco architecture firm Clark and Morgan.", "storke_tower.mp3")
    ]),
    Tour('New York City', 'WIP', 4.5, LatLng(34.413963, -119.848946), const Image(image: AssetImage('images/Storke.JPG')), [])
  ];

  late List<Tour> tourList;

  Tour? selectedTour;
  TourPoint? selectedTourPoint;

  final slidingPanelController = PanelController();
  final searchBarController = FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final maxPanelHeight = selectedTour == null
        ? MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight?.round() ?? 0)
        : 350.0;

    late double minPanelHeight;
    if (selectedTour == null)
    {
      minPanelHeight = 100.0;
    }
    else if (selectedTour != null && selectedTourPoint == null)
    {
      minPanelHeight = 140.0;
    }
    else if (selectedTour != null && selectedTourPoint != null)
    {
      minPanelHeight = 120.0;
    }

    onTourSelect(Tour tour)
    {
      setState(() {
        selectedTour = selectedTour == null ? tour : null;
        slidingPanelController.close();
      });
    }

    selectedTour = testTours[0];
    selectedTourPoint = testTours[0].points[0];

    late Widget widgetToDisplayInPanel;
    if (selectedTour == null)
    {
      widgetToDisplayInPanel = FloatingSearchBar(
        hint: 'Search...',
        controller: searchBarController,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 200),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
          setState(() {
            tourList = testTours.where((tour) => tour.name.contains(query) || tour.description.contains(query)).toList();
          });
        },
        onFocusChanged: (bool focused) {
          focused ? slidingPanelController.open() : slidingPanelController.close();
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
                children: tourList.map((tour) => tour.toTile(onTourSelect)).toList(),
              ),
            ),
          );
        },
      );
    }
    else if (selectedTour != null && selectedTourPoint == null)
    {
      widgetToDisplayInPanel = TourInformation(selectedTour: selectedTour!);
    }
    else if (selectedTour != null && selectedTourPoint != null)
    {
      widgetToDisplayInPanel = AudioInformation(tourPoint: selectedTourPoint!);
    }

    return SlidingUpPanel(
      backdropEnabled: true,
      maxHeight: maxPanelHeight,
      minHeight: minPanelHeight,
      controller: slidingPanelController,
      panel: widgetToDisplayInPanel,
      body: MainMap(selectedTour),
      onPanelClosed: () {
        searchBarController.close();
      },
      onPanelOpened: () {
        searchBarController.open();
      },
    );
  }
}