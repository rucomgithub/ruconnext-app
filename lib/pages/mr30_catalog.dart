import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class Mr30CatalogPage extends StatefulWidget {
  const Mr30CatalogPage({super.key});

  @override
  State<Mr30CatalogPage> createState() => _Mr30CatalogPageState();
}

class _Mr30CatalogPageState extends State<Mr30CatalogPage> {
  List<dynamic> catalog = [];
  Future<List<dynamic>>? getDataFuture;
  final urlMr30Catalog = dotenv.env['MR30_CAT'];
  Future<List<dynamic>> getData()  async {
    try {
      var response = await Dio().get('$urlMr30Catalog/mr30_catalog.json');
      catalog = response.data;

        return catalog; 
    } catch(e) {
      throw Exception('เกิดข้อผิดพลาดจาก Server กรุณาลองใหม่' );
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFuture = getData();
  }

  @override
  Widget build(BuildContext context) {
 return Scaffold(
     
      appBar: AppBar(title:  const Text('catalog')),
      body: FutureBuilder<List<dynamic>>(
        future: getDataFuture,
        builder:(context, snapshot) {
          if (snapshot.hasData){
            return ListView.separated(
              itemBuilder: ((context, index) {
                return ListTile(
  
                  
                  title: Text('${snapshot.data![index]['cName']}'),
                  subtitle: Text('${snapshot.data![index]['type']}(${snapshot.data![index]['typeNo']})'),
                  trailing:  Chip(
                    label:  Text('${snapshot.data![index]['COURSENO']}'),
                  ),
                );
              }), 
              separatorBuilder: ((context, index) => const Divider()), 
              itemCount: snapshot.data!.length
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  }
