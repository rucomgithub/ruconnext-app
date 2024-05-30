import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exceptions/dioexception.dart';
import '../fitness_app/fitness_app_theme.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../model/rumap_model.dart';


String? tokenMr30;

List<Roommap> jsonData =[];
Map<String,Map<String,dynamic>>  builderRam = 
{
  "VKB502":{"destlat":13.757975908470604,"destlng":100.620394321302},
  "SBB308":{"destlat":13.757975908470604,"destlng":100.620394321302},
};
const double latVKB = 13.757975908470604;
const double lngVKB = 100.620394321302;

class RuMap extends StatefulWidget {
  @override
  _RuMapState createState() => _RuMapState();
}

class _RuMapState extends State<RuMap>
    with TickerProviderStateMixin {
  AnimationController? animationController;
   Completer<GoogleMapController> _controller = Completer();
  // double lati = builderRam['VKB502'] ?? builderRam['VKB502']!['destlat'];
  static const LatLng sourceLocation =
      LatLng(13.756039900612896, 100.61470178555103);
  static LatLng destination =
  LatLng( latVKB, lngVKB);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController googleMapController;


      
//   Future<List<Roommap>> loadJsonData() async {
//       print('------------------- LOAD JSON DATA -------------------  ');
//   //String jsonData = await rootBundle.loadString('assets/rumap.json');
//   String jsonData = '[{"room":"KMB","destlat":13.753764722413896,"destlng":100.61761093689002},{"room":"SWB","destlat":13.754634679593483,"destlng":100.61844854139595},{"room":"VKB","destlat":13.758898700829464,"destlng":100.62123059543501},{"room":"VPB","destlat":13.758898700829464,"destlng":100.62123059543501},{"room":"SBB","destlat":13.75719605241267,"destlng": 100.61955928268597},{"room":"SCO","destlat":13.754606568664048,"destlng": 100.61968694283942} ] ';
//   print('getjson -------------------  ${Roommap.decode(jsonData).length}');
//   return Roommap.decode(jsonData);
// }
  Future<List<Roommap>>  getJson() async{
    
   //    String responseJson = '[{"room":"KMB","destlat":13.753764722413896,"destlng":100.61761093689002},{"room":"SWB","destlat":13.754634679593483,"destlng":100.61844854139595},{"room":"VKB","destlat":13.758898700829464,"destlng":100.62123059543501},{"room":"VPB","destlat":13.758898700829464,"destlng":100.62123059543501},{"room":"SBB","destlat":13.75719605241267,"destlng": 100.61955928268597},{"room":"SCO","destlat":13.754606568664048,"destlng": 100.61968694283942} ] ';
            try{
              var responseJson2 = await Dio().get(
                    'https://uat.ru.ac.th/jsondata/building.json',
                    options: Options(
                      headers: {
                        HttpHeaders.contentTypeHeader: "application/json",
                        "authorization": "Bearer ",
                      },
                    ),
                    
                  );
                  if (responseJson2.statusCode == 200) {
                    print('json from url :  ${responseJson2.data.toString()}');
                     
                  return Roommap.decode(jsonEncode(responseJson2.data));
                  }else {
                  throw ('Error Get Data');
                }
            }  on DioError catch (err) {
              final errorMessage = DioException.fromDioError(err).toString();
              print('$errorMessage ...');
              throw ('$errorMessage ...');
            } catch (e) {
              print('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
              throw ('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
            }

        //return Roommap.decode('');
   
  }

  void getCurrentLocation() async {
    
    Location location = Location();
 print(location);
    location.getLocation().then(
      (location) {
        currentLocation = location;
       
      },
    );

     googleMapController = await _controller.future;

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
        if (!mounted) return; 
        print('current ${currentLocation}');

        setState(() {});
      },
    );
    //await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
  }

   getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBDni9WvxHp5hBqVmm80tJDhgYotiOJC-A",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    } else {
      print('Error from Polyline : ${result.errorMessage}');
    }
  }

  void setCustomMarkerIcon(){
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 10.5), 'assets/images/logo.png').then(
         (icon){
        sourceIcon = icon;
      }
    );
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.5), 'assets/images/ram.png').then(
         (icon){
        destinationIcon = icon;
      }
    );
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 7.5), 'assets/images/me.png').then(
         (icon){
        currentLocationIcon = icon;
      }
    );
  }

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    googleMapController.dispose();
    _controller = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

final Map<String, dynamic> args = Get.arguments;
    final String? courseRoom = args['courseroom'];
     print('${courseRoom.toString().trim()}');

    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
              child: CircularProgressIndicator(),
            );
            } else {
              print(tokenMr30);
              List<Roommap> room =  jsonData.where((Roommap r) => r.room!.substring(0,3) == (courseRoom.toString().trim()).substring(0,3)).toList();
              print(jsonData.length);
             print('jsonData -------------------  ${room[0].room!.substring(0,3)}');
              print('jsonlatlng -------------------  ${room[0].destlat!.toDouble()} and ${room[0].destlng!.toDouble()}');
              return room.length == 0 ? Stack(
                      children: <Widget>[
                        GoogleMap(
              initialCameraPosition: CameraPosition(
                  target:  LatLng(
                      13.756230984740453, 100.61881313427858),
                  zoom: 16.0),
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                         color: Colors.blue,)
              },
              markers: {
                Marker(
                  markerId: const MarkerId("current"),
                //  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
              
                ),
                
                //  Marker(
                //   markerId: MarkerId("source"),
                //   icon: sourceIcon,
                //   position: sourceLocation,
                // ),
                 Marker(
                  markerId: MarkerId("destination"),
                 // icon: destinationIcon,
                  position: LatLng(13.756230984740453, 100.61881313427858),
                )
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
                      ],
                    ) :Stack(
                      children: <Widget>[
                        GoogleMap(
              initialCameraPosition: CameraPosition(
                  target:  LatLng(
                      room[0].destlat!.toDouble(), room[0].destlng!.toDouble()) ,
                  zoom: 15.0),
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                         color: Colors.blue,)
              },
              markers: {
                Marker(
                  markerId: const MarkerId("current"),
                //  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                //  Marker(
                //   markerId: MarkerId("source"),
                //   icon: sourceIcon,
                //   position: sourceLocation,
                // ),
                 Marker(
                  markerId: MarkerId("destination"),
                 // icon: destinationIcon,
                  position: LatLng(room[0].destlat!.toDouble(), room[0].destlng!.toDouble()),
                )
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
                      ],
                    );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenMr30 = prefs.getString('profile');
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    jsonData = await getJson();
    //jsonData = await loadJsonData();
    await Future<dynamic>.delayed(const Duration(milliseconds: 3000));
    return true;
  }
}
