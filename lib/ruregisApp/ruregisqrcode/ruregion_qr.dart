import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/region_enroll_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';

class RuregisQRScreen extends StatefulWidget {
  @override
  _RuregisQRScreenState createState() => _RuregisQRScreenState();
}

class _RuregisQRScreenState extends State<RuregisQRScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  var stdcode;
  var sem;
  var year;
  var tel;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    stdcode = Provider.of<RuregisProvider>(context, listen: false).stdcode;
    sem = Provider.of<RuregisProvider>(context, listen: false).semester;
    year = Provider.of<RuregisProvider>(context, listen: false).year;
    tel = Provider.of<RuregisProvider>(context, listen: false)
        .ruregis
        .mOBILETELEPHONE;
    Provider.of<RegionEnrollProvider>(context, listen: false)
        .getQR(stdcode, sem, year, tel);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var qrData = context.watch<RegionEnrollProvider>().genqrruregion.results;
    var qrurl = context.watch<RegionEnrollProvider>().qrurl;
    var totalamount = context.watch<RegionEnrollProvider>().totalamount;
    var duedate = context.watch<RegionEnrollProvider>().duedate;
    var ruregisProv = context.watch<RuregisProvider>();
    var semester = Provider.of<RuregisProvider>(context).semester;
    var year = Provider.of<RuregisProvider>(context).year;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back button
        title: Text('QR PAYMENT'),
      ),
      body: Provider.of<RegionEnrollProvider>(context).isLoading == false
          ? SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      height: MediaQuery.of(context).size.height * 0.74,
                      child: Card(
                        color: Color.fromARGB(255, 251, 251, 251),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image at the top
                            Image.asset(
                              'assets/images/ru_QR.jpg',
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              '${qrurl}',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            // Text below the image
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Name on the left
                                      Text(
                                        'ลงทะเบียน ป.ตรี (ภูมิภาค)',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // Fee on the right
                                      Text(
                                        '${totalamount}.00',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Name on the left
                                      Text(
                                        '${ruregisProv.ruregis.nAMETHAI}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // Fee on the right
                                      Text(
                                        'บาท (baht)',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Name on the left
                                      Text(
                                        'ภาค ${semester}/${year}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // Fee on the right
                                      Text(
                                        'EXP.  ${duedate}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      child: SizedBox(
                        width: double
                            .infinity, // Set the button to take full width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/ruregishome'); // Navigate to home
                          },
                         style: ElevatedButton.styleFrom(
  backgroundColor: Colors.blue, // Background color
  foregroundColor: Colors.white, // Text color (เดิม onPrimary)
  padding: EdgeInsets.symmetric(vertical: 16.0), // Button padding
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0), // Rounded corners
  ),
),

                          child: Text('กลับสู่หน้าหลัก'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
