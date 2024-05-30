// import 'package:flutter/material.dart';
// import 'package:flip_card/flip_card.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // String ? token;
// class VirtualCard extends StatelessWidget {
//   const VirtualCard({super.key});
//   _renderBg() {
//     return Container(
//       decoration: const BoxDecoration(color: const Color(0xFFFFFFFF)),
//     );
//   }
  
  


//   // Future<bool> getData() async {
//   //   SharedPreferences prefs = await  SharedPreferences.getInstance();
//   //   token = prefs.getString('profile');
//   //   print(token);
//   //   await Future<dynamic>.delayed(const Duration(milliseconds: 0));
//   //   return true;
    
//   // }

//   _renderAppBar(context) {
//     return MediaQuery.removePadding(
//       context: context,
//       removeBottom: true,
//       child: AppBar(
//         elevation: 0.0,
//         backgroundColor: const Color(0x00FFFFFF),
//       ),
//     );
//   }

//   _renderContent(context) {
    


//     return Card(
//       elevation: 0.0,
//       margin:
//           const EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0, bottom: 0.0),
//       color: const Color(0x00000000),
//       child: FlipCard(
//         direction: FlipDirection.HORIZONTAL,
//         speed: 1000,
//         onFlipDone: (status) {
//           print(status);
//         },
//         front: Container(
//           decoration: const BoxDecoration(
//             color: Color.fromARGB(255, 198, 255, 255),
//             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                         width: 65,
//                         height: 65,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(60.0),
//                             color: Colors.white),
//                         child: Padding(
//                           padding: EdgeInsets.all(7.0),
//                           child: ClipRRect(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10.0)),
//                             child: Image.asset(
//                                 'assets/images/Logo_VecRu_Thai.png'),
//                           ),
//                         )),
//                     Container(
//                       height: 80,
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('มหาวิทยาลัยรามคำแหง',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue[900],
//                                 )),
//                             Text('Ramkhamheang University',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.yellow[700],
//                                 )),
//                             Text('บัตรนักศึกษาอิเล็กทรอนิกส์',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue[300],
//                                 ))
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                 child: Column(
//                   children: [
//                     Container(
//                         height: 150,
//                         width: 150,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.0),
//                             color:  Color.fromARGB(255, 157, 208, 208)),
//                         child:
//                         Padding(
//                         padding: EdgeInsets.all(6.0),
//                         child:   ClipRRect(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(10.0)),
//                           child:
//                               Image.asset('assets/images/me.png'),
//                         )),
//                        )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(0.0, 5.0,0.0, 0.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 70,
//                       width: 280,
//                       child:
//                       Padding(
//                         padding: EdgeInsets.all(5.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('นางสาวเปลวเทียน รักเรียน', style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 255, 255, 255),
//                                 )),
//                                 Text('6299999991', style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 227, 211, 107),
//                                 ))
//                           ],
//                         )),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(6.0),
//                             color:  Color.fromARGB(255, 145, 178, 255)),

//                     ),   Container(
//                       height: 70,
//                       width: 280,
//                       child:
//                       Padding(
//                         padding: EdgeInsets.all(5.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('คณะนิติศาสตร์', style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                 )),
//                                 Text('นิติศาสตร์', style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                 ))
//                           ],
//                         )),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(6.0),
//                             color:  Color.fromARGB(255, 251, 247, 187)),

//                     )
//                   ],
//                 ),
//               ),
   
//             ],
//           ),
//         ),
//         back: Container(
//           decoration: const BoxDecoration(
//             color: Color.fromARGB(255, 113, 156, 156),
//             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
                
//                QrImage(
//               data: 'HELLO RU',
//               version: QrVersions.auto,
//               size: 320,
//               gapless: false,
//               embeddedImage: AssetImage('assets/images/logo.png'),
//               embeddedImageStyle: QrEmbeddedImageStyle(
//                 size: Size(80, 80),
//               ),
//             ),
//               Text('Back', style: Theme.of(context).textTheme.headline1),
//               Text('Click here to flip front',
//                   style: Theme.of(context).textTheme.bodyText1),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FlipCard'),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           _renderBg(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               _renderAppBar(context),
//               Expanded(
//                 flex: 8,
//                 child: _renderContent(context),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container(),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
