import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation =
      LatLng(13.756039900612896, 100.61470178555103);
  static const LatLng destination =
      LatLng(13.758043082767378, 100.61964110906165);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 16.5,
                target: LatLng(
                  newLoc.latitude!,
                  newLoc.longitude!,
                )),
          ),
        );

        //('current ${currentLocation}');

        setState(() {});
      },
    );
    await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
  }

  void getPolyPoints() async {
    // PolylinePoints polylinePoints = PolylinePoints();

    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   "AIzaSyDleXXfNBGkKuNFZyT_tYFAqKc7yqkPYLE",
    //   PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
    //   PointLatLng(destination.latitude, destination.longitude),
    // );

    // if (result.points.isNotEmpty) {
    //   result.points.forEach(
    //     (PointLatLng point) => polylineCoordinates.add(
    //       LatLng(point.latitude, point.longitude),
    //     ),
    //   );
    //   setState(() {});
    // }
  }

  void setCustomMarkerIcon(){
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/images/logo.png').then(
         (icon){
        sourceIcon = icon;
      }
    );
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/images/ram.png').then(
         (icon){
        destinationIcon = icon;
      }
    );
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/images/me.png').then(
         (icon){
        currentLocationIcon = icon;
      }
    );
  }

  @override
  void initState() {
   // print('-------------int state ------------------');
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  // static final Marker _kMark = Marker(markerId: MarkerId('kGoogle'),position:  LatLng(13.756039900612896, 100.61470178555103));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track order",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: Text('Loading'))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 16.5),
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates)
              },
              markers: {
                Marker(
                  markerId: const MarkerId("current"),
                  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                 Marker(
                  markerId: MarkerId("source"),
                  icon: sourceIcon,
                  position: sourceLocation,
                ),
                 Marker(
                  markerId: MarkerId("destination"),
                  icon: destinationIcon,
                  position: destination,
                )
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}

// class OrderTrackingPage extends StatefulWidget {
//   const OrderTrackingPage({Key? key}) : super(key: key);

//   @override
//   State<OrderTrackingPage> createState() => OrderTrackingPageState();
// }

// class OrderTrackingPageState extends State<OrderTrackingPage> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(13.756039900612896, 100.61470178555103),
//     zoom: 14.4746,
//   );
//   static final Marker _kMark = Marker(markerId: MarkerId('kGoogle'),
//   position:  LatLng(13.756039900612896, 100.61470178555103));

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(13.756039900612896, 100.61470178555103),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         markers:  {_kMark},
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('ไปตึกอธิการ !'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
