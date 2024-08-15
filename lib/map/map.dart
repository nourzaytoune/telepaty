import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final List<TextEditingController> _searchControllers = [
    TextEditingController()
  ];
  final List<String> _letters = List.generate(26, (index) => String.fromCharCode(index + 65)); // Generating letters A to Z
  final List<String> _assignedLetters = [];
  final Map<int, String> _indexToMarkerId = {}; // Track marker IDs by index
  late GoogleMapController _mapController;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  int _markerIdCounter = 0;
  List<LatLng> _newCoordinates = <LatLng>[];
  String _totalTripTime = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Search'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              itemCount: _searchControllers.length + 1,
              itemBuilder: (context, index) {
                if (index == _searchControllers.length) {
                  return IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addSearchBox,
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: _buildSearchBox(_searchControllers[index], index),
                  );
                }
              },
            ),
          ),
          if (_totalTripTime.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Total trip: $_totalTripTime'),
            ),
          Expanded(
            flex: 3,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(23.0225, 72.5714),
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: _markers,
              polylines: _polylines,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _searchControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildSearchBox(TextEditingController controller, int index) {
    String letter = _assignedLetters.length > index ? _assignedLetters[index] : '';
    return Row(
      children: [
        Text(letter, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(width: 8),
        Expanded(
          child: GooglePlaceAutoCompleteTextField(
            textEditingController: controller,
            googleAPIKey: "AIzaSyAaJYVS9wlErpanSAGEfAC8hhv8sx0kOPQ", // Replace with your Google Maps API Key
            inputDecoration: InputDecoration(
              hintText: 'Enter location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => _removeSearchBox(index),
              ),
            ),
            debounceTime: 800,
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              print("placeDetails: ${prediction.toString()}");
            },
            itemClick: (Prediction prediction) async {
              controller.text = prediction.description!;
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description!.length));

              // Get LatLng from prediction
              final latLng = await _getLatLngFromAddress(prediction.description!);
              if (latLng != null) {
                String markerId = 'marker_${_markerIdCounter++}';
                _addMarker(latLng, markerId);
                _indexToMarkerId[index] = markerId;
                if (!_newCoordinates.contains(latLng)) {
                  _newCoordinates.add(latLng);
                }

                // Animate camera to the selected location
                _animateCamera(latLng);

                if (_newCoordinates.isNotEmpty) {
                  await _updatePolylines(_newCoordinates);
                }
              }
            },
            itemBuilder: (context, index, Prediction prediction) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 7),
                    Expanded(child: Text("${prediction.description ?? ""}"))
                  ],
                ),
              );
            },
            seperatedBuilder: Divider(),
            isCrossBtnShown: false,
            containerHorizontalPadding: 10,
            countries: const ['lb'],
            placeType: PlaceType.establishment,
          ),
        ),
      ],
    );
  }

  void _reassignLetters() {
    setState(() {
      // Clear existing letter assignments
      _assignedLetters.clear();

      // Reassign letters to the remaining search boxes
      for (int i = 0; i < _searchControllers.length; i++) {
        if (i < _letters.length) {
          _assignedLetters.add(_letters[i]);
        } else {
          _assignedLetters.add('');
        }
      }
    });
  }

  void _addSearchBox() {
    setState(() {
      final index = _searchControllers.length; // Index of the new search box
      _searchControllers.add(TextEditingController());

      // Add a new entry for this index in the marker ID map
      _indexToMarkerId[index] = '';

      // Reassign letters after adding a new search box
      _reassignLetters();
    });
  }

  void _removeSearchBox(int index) {
    setState(() {
      print('Attempting to remove search box at index: $index');
      if (_searchControllers.length >= 1) {
        // Get the marker ID for the search box to be removed
        final markerId = _indexToMarkerId[index];
        print('Marker ID to remove: $markerId');

        if (markerId != null && markerId.isNotEmpty) {
          // Remove the marker
          _markers.removeWhere((marker) => marker.markerId.value == markerId);
          print('Marker removed: $markerId');
        }

        // Remove the search box
        _searchControllers.removeAt(index);
        _assignedLetters.removeAt(index);
        _indexToMarkerId.remove(index);

        // Reassign letters and update coordinates
        _reassignLetters();

        // Update coordinates for remaining markers
        _newCoordinates = _indexToMarkerId.values
            .where((id) => id.isNotEmpty)
            .map((id) => _markers.firstWhere((marker) => marker.markerId.value == id).position)
            .toList();

        // Remove polyline segments that include the marker
        _updatePolylines(_newCoordinates);

        // Update camera position if there are remaining coordinates
        if (_newCoordinates.isNotEmpty) {
          _animateCamera(_newCoordinates.first);
        }
      }
    });
  }

  Future<void> _updatePolylines(List<LatLng> coordinates) async {
    if (coordinates.length >= 2) {
      final List<LatLng> polylineCoordinates = [];
      final waypoints = coordinates
          .sublist(1, coordinates.length - 1)
          .map((latLng) => '${latLng.latitude},${latLng.longitude}')
          .join('|');
      final url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${coordinates.first.latitude},${coordinates.first.longitude}&destination=${coordinates.last.latitude},${coordinates.last.longitude}&waypoints=$waypoints&key=AIzaSyAaJYVS9wlErpanSAGEfAC8hhv8sx0kOPQ'; // Replace with your Google Maps API Key

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['status'] == 'OK') {
            final routes = data['routes'];
            if (routes != null && routes.isNotEmpty) {
              final route = routes[0];
              final legs = route['legs'];
              if (legs != null && legs.isNotEmpty) {
                final leg = legs[0];
                _totalTripTime = leg['duration']['text'];

                polylineCoordinates.clear(); // Clear previous polyline coordinates

                for (var leg in legs) {
                  for (var step in leg['steps']) {
                    final polylinePoints = _decodePolyline(step['polyline']['points']);
                    polylineCoordinates.addAll(polylinePoints);
                  }
                }

                setState(() {
                  _polylines.clear(); // Clear previous polylines
                  _polylines.add(
                    Polyline(
                      polylineId: PolylineId('polyline_${_markerIdCounter++}'),
                      color: Colors.blue,
                      width: 5,
                      points: polylineCoordinates,
                    ),
                  );
                });
              }
            }
          }
        }
      } catch (e) {
        print('Error fetching directions: $e');
      }
    } else {
      setState(() {
        _polylines.clear(); // Clear polylines if there are fewer than 2 coordinates
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      polyline.add(p);
    }

    return polyline;
  }

  Future<LatLng?> _getLatLngFromAddress(String address) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyAaJYVS9wlErpanSAGEfAC8hhv8sx0kOPQ'; // Replace with your Google Maps API Key

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final results = data['results'];
          if (results != null && results.isNotEmpty) {
            final location = results[0]['geometry']['location'];
            final lat = location['lat'];
            final lng = location['lng'];
            return LatLng(lat, lng);
          }
        }
      }
    } catch (e) {
      print('Error fetching geocoding: $e');
    }
    return null;
  }

  void _addMarker(LatLng latLng, String markerId) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: latLng,
    );
    setState(() {
      _markers.add(marker);
    });
  }

  void _animateCamera(LatLng latLng) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 12,
        ),
      ),
    );
  }
}





/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final List<TextEditingController> _searchControllers = [TextEditingController()];
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];
  int _markerIdCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearch,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(23.0225, 72.5714),
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
            polylines: _polylines,
          ),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: _buildSearchBoxColumn(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBoxColumn() {
    return Column(
      children: [
        for (var i = 0; i < _searchControllers.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: _buildSearchBox(_searchControllers[i], i),
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _addSearchBox,
        ),
      ],
    );
  }

  Widget _buildSearchBox(TextEditingController controller, int index) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Enter location',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () => _onSearch(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void _addSearchBox() {
    setState(() {
      _searchControllers.add(TextEditingController());
    });
  }

  Future<void> _onSearch() async {
    final newCoordinates = <LatLng>[];

    for (var controller in _searchControllers) {
      if (controller.text.isNotEmpty) {
        final location = controller.text;
        print('Searching for location: $location');
        final latLng = await _getLatLngFromAddress(location.trim());
        if (latLng != null) {
          print('Found location: $latLng');
          _addMarker(latLng);
          newCoordinates.add(latLng);
        } else {
          print('Could not find location for: $location');
        }
      }
    }

    if (newCoordinates.isNotEmpty) {
      _animateCamera(newCoordinates.first);
      _updatePolyline(newCoordinates);
    }

    // Clear all search boxes
    for (var controller in _searchControllers) {
      controller.clear();
    }
  }

  Future<LatLng?> _getLatLngFromAddress(String address) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=YOUR_API_KEY';
    print('Requesting geocode for: $address');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      } else {
        print('Geocoding API error: ${data['status']}');
      }
    } else {
      print('HTTP error: ${response.statusCode}');
    }
    return null;
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markerIdCounter++;
      final String markerIdVal = 'marker_$_markerIdCounter';
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Location $_markerIdCounter',
          ),
        ),
      );
    });
  }

  void _animateCamera(LatLng target) {
    print('Animating camera to: $target');
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(target, 12.0),
    );
  }

  void _updatePolyline(List<LatLng> coordinates) {
    setState(() {
      _polylineCoordinates.clear();
      _polylineCoordinates.addAll(coordinates);

      if (coordinates.length >= 2) {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.red,
            points: _polylineCoordinates,
            width: 5,
          ),
        );
      }
    });
  }
}*/




