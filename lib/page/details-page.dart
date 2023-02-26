import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Details extends StatelessWidget {
  //const UserDetails({super.key});
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  Details({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Profile'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          color: Color(0xFFF5F5F5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, //para que o componente/widget ocupe todo o espaço disponivel
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Name: ' + name),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Email: ' + email),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Phone: ' + phone),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('WebSite: ' + website),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  color: Color(0xFFF5F5F5),
                  child: id! < 9 ? Image.network('https://randomuser.me/api/portraits/lego/'+id.toString()+'.jpg') : Image.network('https://randomuser.me/api/portraits/lego/1.jpg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
