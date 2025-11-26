import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';

class aboutRam extends StatefulWidget {
  const aboutRam({Key? key}) : super(key: key);

  @override
  _aboutRamState createState() => _aboutRamState();
}

class _aboutRamState extends State<aboutRam> {
  int _current = 0;
  dynamic _selectedIndex = {};

final cs.CarouselSliderController _carouselController = cs.CarouselSliderController();

  List<dynamic> _products = [
    {
      'title': 'พ่อขุนรามคำแหง',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZXycQdfvLV_Zyb2d9740vetGn5citezqcPQ&s',
      'description':
          'พ่อขุนรามคำแหงมหาราช หรือ ขุนรามราช หรือ พระบาทกมรเตงอัญศรีรามราช เป็นพระมหากษัตริย์พระองค์ที่ 3 ในราชวงศ์พระร่วงแห่งราชอาณาจักรสุโขทัย เสวยราชย์ประมาณ พ.ศ. 1822 ถึงประมาณ พ.ศ. 1842 พระองค์ทรงเป็นกษัตริย์พระองค์แรกของไทยที่ได้รับการยกย่องเป็น "มหาราช"'
    },
    {
      'title': 'อาคารเวียงผา',
      'image':
          'https://igx.4sqi.net/img/general/600x600/7826402_1oo60CjivIyUplAanZFUraUsntP-z8JLoxvc0ue3oxM.jpg',
      'description':
          '“เวียงผา” ได้นำมาตั้งเป็นชื่อของอาคารภายในมหาวิทยาลัยรามคำแหง อาคารเวียงผา มีลักษณะเป็นอาคารเรียนรวมสูง 5 ชั้น เช่นเดียวกันกับ อาคารเวียงคำ ที่แวดล้อมไปด้วยอาคารต่างๆ ของมหาวิทยาลัย เช่น อาคารรัตนธาร อาคารสำนักพิมพ์ ห้องอ่านหนังสือศรีอักษร อาคารจอดรถ และซุ้มนักศึกษาบริเวณด้านหลังอาคารศรีศรัธรา'
    },
    {
      'title': 'ปณิธาน',
      'image': 'https://www.naewna.com/uploads/news/source/389623.jpg',
      'description':
          'พัฒนามหาวิทยาลัยรามคำแหงให้เป็นแหล่งวิทยาการแบบตลาดวิชาควบคู่แบบจำกัดจำนวน มุ่งผลิตบัณฑิตที่มีความรู้คู่คุณธรรม และจิตสำนึกในความรับผิดชอบต่อสังคม '
    }
  ];

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      floatingActionButton: _selectedIndex.length > 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.arrow_forward_ios),
            )
          : null,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'เกี่ยวกับราม',
          style: TextStyle(
              fontFamily: AppTheme.ruFontKanit
              ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: cs.CarouselSlider(
            carouselController: _carouselController,
            options: cs.CarouselOptions(
                height: 550.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.90,
                enlargeCenterPage: true,
                pageSnapping: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: _products.map((data) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: _selectedIndex == data
                              ? Border.all(
                                  color: Colors.blue.shade500, width: 3)
                              : null,
                          boxShadow: _selectedIndex == data
                              ? [
                                  BoxShadow(
                                      color: Colors.blue.shade100,
                                      blurRadius: 30,
                                      offset: const Offset(0, 10))
                                ]
                              : [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5))
                                ]),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 320,
                              margin: const EdgeInsets.only(top: 10),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(
                                data['image'],
                                fit: BoxFit.cover,
                                height: 150,
                                width: 300,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              data['title'],
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                data['description'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppTheme.ruFontKanit,
                                    color: Colors.grey.shade600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList()),
      ),
    );
  }
}
