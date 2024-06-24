import 'dart:async';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class homeImageSlider extends StatefulWidget {
  const homeImageSlider({Key? key}) : super(key: key);

  @override
  _homeImageSliderState createState() => _homeImageSliderState();
}
  class profileImage{
    String? title;
    String? imageHome;
    String? description;
    profileImage({this.title,this.imageHome,this.description});
  }
class _homeImageSliderState extends State<homeImageSlider> {
  
  int _current = 0;
  dynamic _selectedIndex = {};

  CarouselController _carouselController = new CarouselController();
  int currentIndex = 0;
  String imgClock='';
  profileImage profileImages  =    profileImage(    
      title: '',
      imageHome:'',
      description:''
    )  ;
  List<profileImage> _products = [

    profileImage(    
      title: 'สวัสดีตอนเช้า',
      imageHome:'assets/fitness_app/banner1.png',
      description:'แดดเช้า'
    ) , 
    profileImage(    
      title: 'สวัสดีตอนบ่าย',
      imageHome:'assets/fitness_app/banner2.png',
      description:'แดดบ่าย'
    ), 
    profileImage(    
      title: 'สวัสดีตอนเย็น',
      imageHome:'assets/fitness_app/banner3.png',
      description:'แดดเย็น'
    )

  ];

    @override
  void initState() {
    super.initState();
    // Start the loop when the widget is created
    DateTime now = DateTime.now();
    DateTime morning = DateTime(now.year, now.month, now.day, 8, 0); 
    DateTime afternoon = DateTime(now.year, now.month, now.day, 13, 0); 
    DateTime evening = DateTime(now.year, now.month, now.day, 18, 0); 
    print(afternoon );
    if(now.isAfter(morning) && now.isBefore(afternoon)){
       profileImages = _products[0] ;
    }else if (now.isAfter(afternoon) && now.isBefore(evening)){
       profileImages = _products[1] ;
    }else if (now.isAfter(evening)){
       profileImages = _products[2] ;
    }
    
    // Timer.periodic(Duration(seconds: 2), (Timer timer) {
    //   setState(() {
    //     // Update the current index and loop back to the beginning when we reach the end
    //     currentIndex = (currentIndex + 1) % _products.length;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 120.0,
        aspectRatio: 16 / 9,
        viewportFraction: 1.02,
      ),
      // items: [1, 2, 3, 4, 5].map((i) {
      items: _products.map((data) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.transparent),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 220,
                        margin: const EdgeInsets.only(top: 10),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Image.asset(profileImages.imageHome!,  fit: BoxFit.cover,height: 220,  width: 1500,),
                            Positioned(
                              left: 5.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                   profileImages.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    color: Color.fromARGB(255, 7, 26, 64),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
// class HomeSky extends StatelessWidget {
//   const HomeSky(
//       {Key? key,
//       this.animationController,
//       this.animation})
//       : super(key: key);

//   final AnimationController? animationController;
//   final Animation<double>? animation;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child: AspectRatio(
//               aspectRatio: 1.5,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//                 child: Stack(
//                   alignment: AlignmentDirectional.center,
//                   children: <Widget>[
//                     Positioned.fill(
//                       child: Image.network('https://img.freepik.com/free-photo/beautiful-dusk-light-colorful-beauty_1203-5706.jpg?w=2000&t=st=1680158838~exp=1680159438~hmac=1b217772a111ade190d2da34d5437d637381b96bb253e162631c2f5caf054334',  fit: BoxFit.cover,height: 220,  width: 500,),
//                     ),
           
//                     // Positioned.fill(
//                     //   child: Icon(listData!.iconsData,
//                     //               size: 120,
//                     //               color: listData!.color,
//                     //               ),
//                     // ),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         splashColor: Colors.grey.withOpacity(0.2),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(4.0)),
//                         // onTap: callBack,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// Stack(
//                   children: [
//                       Image.network(
//                         data['image'],
//                         fit: BoxFit.cover,
//                         height: 280,
//                         width: 500,
                      
//                       ),
//                           Positioned(
//                         bottom: 0.0,
//                         left: 0.0,
//                         right: 0.0,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 10.0),
//                           color: Colors.black.withOpacity(0.5),
//                           child: Text(
//                             'My Text on Image',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),