import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rex/components/utilities/submit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/header_footer/top_bar.dart';
import '../../components/utilities/constants.dart';
import 'locations.dart' as locations;
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoder/geocoder.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  static final LatLng _kMapCenter =
      const LatLng(19.018255973653343, 72.84793849278007);

  static final LatLng _kMapCenterAK =
      const LatLng(40.253518362701556, -74.57739990917831);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  static final CameraPosition _kInitialPositionAK =
      CameraPosition(target: _kMapCenterAK, zoom: 18.0, tilt: 70, bearing: 0);

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await rootBundle.loadString('assets/map_style.json');
    _controller.setMapStyle(value);
  }

  void onCameraMove(CameraPosition cameraPosition) {
    debugPrint('${cameraPosition}');
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: const MarkerId("marker_1"),
          position: _kMapCenter,
          infoWindow: const InfoWindow(title: 'Marker 1'),
          rotation: 90),
      const Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(18.997962200185533, 72.8379758747611),
      ),
    };
  }

  Set<Circle> _createCircle() {
    return {
      Circle(
        circleId: const CircleId('1'),
        consumeTapEvents: true,
        strokeColor: Colors.teal,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 2,
        center: _kMapCenter,
        radius: 5000,
      ),
      Circle(
        circleId: const CircleId('2'),
        consumeTapEvents: true,
        strokeColor: Colors.teal,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 2,
        center: const LatLng(18.997962200185533, 72.8379758747611),
        radius: 6000,
      ),
    };
  }

  Set<Polygon> _createPolygon() {
    return {
      Polygon(
          polygonId: const PolygonId('2'),
          consumeTapEvents: true,
          strokeColor: Colors.black,
          strokeWidth: 2,
          fillColor: Colors.teal,
          points: _createPoints())
    };
  }

  Set<Polyline> _createPolyline() {
    return {
      Polyline(
        polylineId: const PolylineId('1'),
        consumeTapEvents: true,
        color: Colors.black,
        width: 5,
        points: _createPoints(),
      ),
    };
  }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(const LatLng(19.03434603366356, 72.8464128479929));
    points.add(const LatLng(19.039546951601157, 72.86191217766304));
    points.add(const LatLng(18.9648299877223, 72.84281511964726));
    //points.add(LatLng(19.03434603366356, 72.8464128479929));
    points.add(const LatLng(18.93089678860969, 72.82178660269335));
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: TopBar(
          phonenavigator: InkResponse(
            onTap: () {
              context.router.pushNamed('/our-contact');
            },
            child: const Icon(Icons.phone),
          ),
          infonavigator: InkResponse(
            onTap: () {
              //widget.infonavigator;
            },
            child: const Icon(Icons.info_outline_rounded),
          ),
          aboutnavigator: InkResponse(
            onTap: () {
              context.router.pushNamed('/about-us');
            },
            child: const Icon(Icons.group_rounded),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                const Center(
                  child: SizedBox(
                    width: 300.0,
                    height: 30.0,
                    child: CupertinoSearchTextField(
                      placeholder: 'Rechercher ou entrer votre adresse',
                      style: kUserInfoHolder,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  height: 350,
                  child: GoogleMap(
                    initialCameraPosition: _kInitialPosition,
                    onMapCreated: onMapCreated,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    markers: _createMarker(),
                    mapToolbarEnabled: false,
                    buildingsEnabled: true,

                    onTap: (latLong) async {
                      final coordinates =
                          Coordinates(latLong.latitude, latLong.longitude);
                      var addresses = await Geocoder.local
                          .findAddressesFromCoordinates(coordinates);
                      var first = addresses.first;

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Tapped location LatLong is ( ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare})'),
                      ));
                    },
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    liteModeEnabled: false,
                    //circles: _createCircle(),
                    //polygons: _createPolygon(),
                    //polylines: _createPolyline(),
                    trafficEnabled: false,
                    onCameraMove: onCameraMove,
                  ),
                ),
                const SizedBox(
                  height: 96.0,
                ),
                const Submit(
                  margin: EdgeInsets.only(left: 116.0, right: 116.0),
                  text: 'AJOUTEZ L\'ADRESSE',
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
