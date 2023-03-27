// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes_app/model/route_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '.env.dart';
import 'package:google_maps_webservice/places.dart';
import 'widgets/route_tile.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Polyline> _polylines = Set<Polyline>();
  LatLng _origin = LatLng(28.5384, -81.3789); // Example origin: San Francisco

  GoogleMapController? _mapController;

  Set<Marker> markers = {};

  List<Widget> alt_routes = [];
  List<RouteData> routeData = [];
  int currentTile = 0;
  bool isExpanded = false;

  String? origin;
  String? destination;
  String? recommended_time;

  double? org_lat;
  double? org_long;
  double? dest_lat;
  double? dest_long;

  // Replace with your API key
  final String _apiKey = newGoogleApiKey;

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.errorMessage ?? 'Unknown error'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Routes'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _polylines.clear();
                alt_routes.clear();
                markers.clear();
                origin = null;
                destination = null;
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(target: _origin, zoom: 12),
              polylines: _polylines,
              markers: markers,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: routeData.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          recommended_time != null
                              ? Text(
                                  recommended_time!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Expanded(
                            child: ListView.builder(
                                  itemCount: routeData.length,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentTile = index;
                                          isExpanded = !isExpanded;
                                        });
                                        String min = routeData[index]
                                            .routeDescription
                                            .replaceAll(
                                                 RegExp(r'[^0-9]'), '');
                                        DateTime now = DateTime.now().add(
                                          Duration(
                                            minutes: int.parse(min),
                                          ),
                                        );
                                        String formattedDate =
                                            DateFormat('kk:mm').format(now);
                                        setState(() {
                                          recommended_time =
                                              'Expected Arrival Time: $formattedDate';
                                        });
                                      },
                                      child: RouteTile(
                                        routeName: routeData[index].routeName,
                                        routeDescription:
                                            routeData[index].routeDescription,
                                        routeDistance:
                                            routeData[index].routeDistance,
                                        color: routeData[index].color,
                                        distance: routeData[index].distance,
                                        turn: routeData[index].turn,
                                        isExpanded:
                                            currentTile == index && isExpanded
                                                ? true
                                                : false,
                                      ),
                                    );
                                  })
                      
                          ),
                        ],
                      )
                    : ListView(
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: [
                            InkWell(
                              onTap: () async {
                                try {
                                  final Prediction? p =
                                      await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: newGoogleApiKey,
                                    onError: onError,
                                    mode: Mode.overlay, // or Mode.fullscreen
                                    language: 'en',
                                    // components: [Component(Component.country, 'fr')],
                                  );

                                  setState(() {
                                    origin = p?.description;
                                  });

                                  if (kDebugMode) {
                                    print(p?.description);
                                  }
                                  List<geo.Location> locations = await geo
                                      .locationFromAddress("${p?.description}");

                                  markers.add(
                                    Marker(
                                      markerId: const MarkerId('origin'),
                                      infoWindow: InfoWindow(
                                        title: origin,
                                      ),
                                      position: LatLng(
                                        locations[0].latitude,
                                        locations[0].longitude,
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    org_lat = locations[0].latitude;
                                    org_long = locations[0].longitude;
                                  });
                                } catch (e) {
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_on,
                                    size: 40,
                                  ),
                                  title: const Text('Origin'),
                                  subtitle: origin != null
                                      ? Text(origin!)
                                      : const Text(
                                          'Add origin',
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                try {
                                  final Prediction? p =
                                      await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: newGoogleApiKey,
                                    onError: onError,
                                    mode: Mode.overlay, // or Mode.fullscreen
                                    language: 'en',
                                    // components: [Component(Component.country, 'fr')],
                                  );

                                  setState(() {
                                    destination = p?.description;
                                  });

                                  if (kDebugMode) {
                                    print(p?.description);
                                  }
                                  List<geo.Location> locations = await geo
                                      .locationFromAddress("${p?.description}");

                                  markers.add(
                                    Marker(
                                      markerId: const MarkerId('destination'),
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueCyan),
                                      infoWindow: InfoWindow(
                                        title: destination,
                                      ),
                                      position: LatLng(
                                        locations[0].latitude,
                                        locations[0].longitude,
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    dest_lat = locations[0].latitude;
                                    dest_long = locations[0].longitude;
                                  });
                                } catch (e) {
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_on,
                                    size: 40,
                                  ),
                                  title: const Text('Destination'),
                                  subtitle: destination != null
                                      ? Text(destination!)
                                      : const Text(
                                          'Add destination',
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _getDirections(
                                    isInit: true,
                                    org_lat: org_lat,
                                    org_long: org_long,
                                    dest_lat: dest_lat,
                                    dest_long: dest_long,
                                  );
                                },
                                child: const Center(
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                      fontSize: 19.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).toList(),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _getDirections({
    required bool isInit,
    double? org_lat,
    double? org_long,
    double? dest_lat,
    double? dest_long,
  }) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$org_lat,$org_long&destination=$dest_lat,$dest_long&alternatives=true&key=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'] == 'OK') {
        setState(() {
          _polylines.clear();
          int routeId = 1;
          jsonResponse['routes'].forEach((route) {
            if (routeId == 1) {
              setState(() {
                recommended_time =
                    "Recommended Travel time: ${route['legs'][0]['duration']['text']}";
              });
            }

            routeData.add(
              RouteData(
                color: routeId == 1
                    ? Colors.blue
                    : routeId == 2
                        ? Colors.red
                        : Colors.orange,
                routeName: 'Route $routeId',
                routeDescription:
                    'Duration: ${route['legs'][0]['duration']['text']}',
                routeDistance:
                    'Distance: ${route['legs'][0]['distance']['text']}',
                distance: route['legs'][0]['distance']['text'],
                turn: route['legs'][0]['steps'][0]['html_instructions'],
              ),
            );
            Polyline polyline = _createPolyline(route, routeId);
            _polylines.add(polyline);
            routeId++;
          });
        });
      } else {
        print('Error fetching directions: ${jsonResponse['status']}');
      }
    } else {
      print('Request failed with status code ${response.statusCode}');
    }
  }

  Polyline _createPolyline(dynamic route, int routeId) {
    List<LatLng> polylinePoints = [];

    route['legs'][0]['steps'].forEach((step) {
      String points = step['polyline']['points'];
      polylinePoints.addAll(_decodePolyline(points));
    });

    return Polyline(
      polylineId: PolylineId('route_$routeId'),
      points: polylinePoints,
      color: routeId == 1
          ? Colors.blue
          : routeId == 2
              ? Colors.red
              : Colors.orange,
      width: 5,
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'directions_model.dart';
// import 'directions_repository.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(-1.9156, 30.0782),
//     zoom: 15,
//   );

//   GoogleMapController? _googleMapController;
//   Marker? _origin;
//   Marker? _destination;
//   Directions? _info;

//   @override
//   void dispose() {
//     _googleMapController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: const Text('Google Maps'),
//         actions: [
//           if (_origin != null)
//             TextButton(
//               onPressed: () => _googleMapController!.animateCamera(
//                 CameraUpdate.newCameraPosition(
//                   CameraPosition(
//                     target: _origin!.position,
//                     zoom: 14.5,
//                     tilt: 50.0,
//                   ),
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 primary: Colors.white,
//                 textStyle: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               child: const Text('ORIGIN'),
//             ),
//           if (_destination != null)
//             TextButton(
//               onPressed: () => _googleMapController!.animateCamera(
//                 CameraUpdate.newCameraPosition(
//                   CameraPosition(
//                     target: _destination!.position,
//                     zoom: 14.5,
//                     tilt: 50.0,
//                   ),
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 primary: Colors.white,
//                 textStyle: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               child: const Text('DEST'),
//             )
//         ],
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           GoogleMap(
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             initialCameraPosition: _initialCameraPosition,
//             onMapCreated: (controller) => _googleMapController = controller,
//             markers: {
//               if (_origin != null) _origin!,
//               if (_destination != null) _destination!
//             },
//             polylines: {
//               if (_info != null)
//                 Polyline(
//                   polylineId: const PolylineId('overview_polyline'),
//                   color: Colors.red,
//                   width: 5,
//                   points: _info!.polylinePoints
//                       .map((e) => LatLng(e.latitude, e.longitude))
//                       .toList(),
//                 ),
//             },
//             onLongPress: _addMarker,
//           ),
//           if (_info != null)
//             Positioned(
//               top: 20.0,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 6.0,
//                   horizontal: 12.0,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.yellowAccent,
//                   borderRadius: BorderRadius.circular(20.0),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0, 2),
//                       blurRadius: 6.0,
//                     )
//                   ],
//                 ),
//                 child: Text(
//                   '${_info!.totalDistance}, ${_info!.totalDuration}',
//                   style: const TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.black,
//         onPressed: () => _googleMapController!.animateCamera(
//           _info != null
//               ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
//               : CameraUpdate.newCameraPosition(_initialCameraPosition),
//         ),
//         child: const Icon(Icons.center_focus_strong),
//       ),
//     );
//   }

//   void _addMarker(LatLng pos) async {
//     if (_origin == null || (_origin != null && _destination != null)) {
//       // Origin is not set OR Origin/Destination are both set
//       // Set origin
//       setState(() {
//         _origin = Marker(
//           markerId: const MarkerId('origin'),
//           infoWindow: const InfoWindow(title: 'Origin'),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//           position: pos,
//         );
//         // Reset destination
//         _destination = null;

//         // Reset info
//         _info = null;
//       });
//     } else {
//       // Origin is already set
//       // Set destination
//       setState(() {
//         _destination = Marker(
//           markerId: const MarkerId('destination'),
//           infoWindow: const InfoWindow(title: 'Destination'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           position: pos,
//         );
//       });

//       // Get directions
//       final directions = await DirectionsRepository(dio: Dio())
//           .getDirections(origin: _origin!.position, destination: pos);
//       setState(() => _info = directions);
//     }
//   }
// }
