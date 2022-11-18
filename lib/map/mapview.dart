// import 'dart:async';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolcation/contants.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../contants.dart';

// class mapview extends StatefulWidget {
//   const mapview({super.key});

//   @override
//   State<mapview> createState() => _mapviewState();
// }

// class _mapviewState extends State<mapview> {
//   Completer<GoogleMapController> _controller = Completer();
//   void initState() {
//     _getCurrentLocation();
//     // _onAddMarkerButtonPressed();
//     EasyLoading.show(status: 'loading...');
//   }

//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.terrain ? MapType.hybrid : MapType.terrain;
//     });
//   }

//   final Set<Marker> _markers = {};
//   LatLng _lastMapPosition = LatLng(45.521563, -122.677433);

//   void _onAddMarkerButtonPressed() {
//     print("checkkkkkkking");
//     setState(() {
//       _markers.add(Marker(
//         markerId: MarkerId(
//             LatLng(positions!.latitude, positions!.longitude).toString()),
//         position: LatLng(positions!.latitude, positions!.longitude),
//         icon: BitmapDescriptor.defaultMarker,
//         infoWindow: InfoWindow(
//           title: no,
//           snippet: temp,
//         ),
//       ));
//     });
//   }

//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }

//   MapType _currentMapType = MapType.hybrid;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           title: Text(
//             "Where i'm ?",
//             style: GoogleFonts.poppins(
//               textStyle:
//                   TextStyle(fontSize: 20, letterSpacing: .2, color: Colors.red),
//             ),
//           ),
//         ),
//         body: (status)
//             ? (Container())
//             : Stack(children: [
//                 GoogleMap(
//                   zoomGesturesEnabled: true,
//                   tiltGesturesEnabled: false,
//                   mapType: _currentMapType,
//                   onMapCreated: _onMapCreated,
//                   onCameraMove: _onCameraMove,
//                   markers: _markers,
//                   initialCameraPosition: CameraPosition(
//                     target: _lastMapPosition,
//                     zoom: (check) ? zoom_level1 : zoom_level,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 10, bottom: 110),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: FloatingActionButton(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.black,
//                       onPressed: () {
//                         setState(() {
//                           check = false;
//                         });
//                         print(zoom_level);
//                         _onAddMarkerButtonPressed();
//                       },
//                       child: Icon(
//                         PhosphorIcons.map_pin,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 10, bottom: 175),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: FloatingActionButton(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.black,
//                       onPressed: () {
//                         _onMapTypeButtonPressed();
//                       },
//                       child: Icon(
//                         PhosphorIcons.arrows_clockwise,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                 )
//               ]));
//   }

//   void _getCurrentLocation() async {
//     Position position = await _determinePosition();

//     setState(() {
//       positions = position;
//       _getAddressFromLatLng(positions!);

//       print(lat);

//       print(positions);
//       LatLng(lat, long);
//       print(LatLng(lat, long));
//       _lastMapPosition = LatLng(lat, long);
//       status = false;
//       EasyLoading.dismiss();
//     });
//   }

//   Future<Position> _determinePosition() async {
//     LocationPermission permission;
//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
// // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.

//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     print(
//         "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
//     await placemarkFromCoordinates(positions!.latitude, positions!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//         temp = '${place.subAdministrativeArea}, ${place.postalCode}';
//         no = '${place.street}, ${place.subLocality}';
//         print(
//             "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
//         print(place.street);
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../contants.dart';

class mapview extends StatefulWidget {
  @override
  _mapviewState createState() => _mapviewState();
}

class _mapviewState extends State<mapview> {
  void initState() {
    _getCurrentLocation();
    // _onAddMarkerButtonPressed();
    // _markers.addAll(_list);

    EasyLoading.show(status: 'loading...');
  }

  Completer<GoogleMapController> _controller = Completer();

  static LatLng _center = LatLng(45.521563, -122.677433);

  List<Marker> _markers = [];

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;
  var id;
  final List<Marker> _list = const [
    // List of Markers Added on Google Map
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(12.2958, 76.6394),
        infoWindow: InfoWindow(
          title: 'Mysore',
        )),

    Marker(
        markerId: MarkerId('2'),
        position: LatLng(11.6643, 78.1460),
        infoWindow: InfoWindow(
          title: 'Salem',
        )),

    Marker(
        markerId: MarkerId('3'),
        position: LatLng(10.7867, 76.6548),
        infoWindow: InfoWindow(
          title: 'palakkad',
        )),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(9.9252, 78.1198),
        infoWindow: InfoWindow(
          title: 'Madurai',
        )),
    Marker(
        markerId: MarkerId('5'),
        position: LatLng(12.9716, 77.5946),
        infoWindow: InfoWindow(
          title: 'Bangalore',
        )),
  ];
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.terrain : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    print(_markers);
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(id.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    print(_lastMapPosition);
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Where i'm ?",
            style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(fontSize: 20, letterSpacing: .2, color: Colors.red),
            ),
          ),
        ),
        body: (status)
            ? (Container())
            : Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(positions!.latitude, positions!.longitude),
                      zoom: 6.5,
                    ),
                    mapType: _currentMapType,
                    markers: Set<Marker>.of(_markers),
                    onCameraMove: _onCameraMove,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: _onMapTypeButtonPressed,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.black,
                            child: Icon(
                              PhosphorIcons.arrows_clockwise,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          FloatingActionButton(
                            // onPressed: _onAddMarkerButtonPressed,
                            onPressed: () {
                              setState(() {
                                _markers.addAll(_list);
                              });
                            },
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.black,
                            child: Icon(
                              PhosphorIcons.map_pin,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();

    setState(() {
      positions = position;
      _getAddressFromLatLng(positions!);

      print(lat);

      print(positions);
      LatLng(lat, long);
      print(LatLng(lat, long));
      _lastMapPosition = LatLng(lat, long);
      status = false;
      EasyLoading.dismiss();
      id = LatLng(positions!.latitude, positions!.longitude);
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
// When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    print(
        "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    await placemarkFromCoordinates(positions!.latitude, positions!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        temp = '${place.subAdministrativeArea}, ${place.postalCode}';
        no = '${place.street}, ${place.subLocality}';
        print(
            "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        print(place.street);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
