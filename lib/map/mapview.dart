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
    setState(() {});

    EasyLoading.show(status: 'loading...');
  }

  Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polyline = {};

  List<Marker> _markers = [];

  LatLng _lastMapPosition = LatLng(lat, long);
  List<LatLng> latLen = [];
  MapType _currentMapType = MapType.normal;
  var id;

  final List<Marker> _list = [];
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
        markerId: MarkerId(id.toString()),
        position: _lastMapPosition,
        onTap: () {},
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      print(position);
      _lastMapPosition = position.target;
    });
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
                    polylines: _polyline,
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
                            onPressed: () {
                              print(latLen);
                              _polyline.add(Polyline(
                                polylineId: PolylineId(latLen.toString()),
                                points: latLen,
                                width: 6,
                                color: Colors.blue,
                              ));
                            },
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.black,
                            child: Icon(
                              PhosphorIcons.map_pin,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          FloatingActionButton(
                            onPressed: () async {
                              GoogleMapController controller =
                                  await _controller.future;
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                target: _lastMapPosition,
                                zoom: 14,
                              )));

                              latLen.add(_lastMapPosition);
                              _markers.add(Marker(
                                markerId: MarkerId(_lastMapPosition.toString()),
                                position: _lastMapPosition,
                                infoWindow: InfoWindow(
                                  title: no,
                                  snippet: temp,
                                ),
                                icon: BitmapDescriptor.defaultMarker,
                              ));
                            },
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.black,
                            child: Icon(
                              PhosphorIcons.crosshair,
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
      print(positions);
      _getAddressFromLatLng(positions!);

      print(lat);

      print(positions);
      LatLng(lat, long);
      print(LatLng(lat, long));
      setState(() {
        _lastMapPosition = LatLng(positions!.latitude, positions!.longitude);
      });

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

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(positions!.latitude, positions!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        temp = '${place.subAdministrativeArea}, ${place.postalCode}';
        no = '${place.street}, ${place.subLocality}';
        print(place.street);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
