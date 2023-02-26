import 'dart:convert'; // json.decode

import 'package:app_http_users/models/user.dart';
import 'package:app_http_users/page/details-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Lista de Usuarios"),
      ),
      body: //ListView(
          //children: [
          Center(
        child: FutureBuilder<List<User>>(
          //Tipando o futureBuilder com tipo lista de Usuarios
          future: users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  User usuario = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      print(usuario.phone);
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            id: usuario.id!,
                            name: usuario.name!,
                            email: usuario.email!,
                            phone: usuario.phone!,
                            website: usuario.website!, 
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.all(16),
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black54,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          usuario.name!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        subtitle: Text(
                          usuario.email!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                        // leading: Icon(
                        //   Icons.account_box,
                        //   size: 50,
                        //   color: Colors.black54,
                        // ),
                        leading: usuario.id! < 9 ? Image.network('https://randomuser.me/api/portraits/lego/'+usuario.id.toString()+'.jpg') : Image.network('https://randomuser.me/api/portraits/lego/1.jpg'),
                        // textColor: Colors.black54,
                        // trailing: Icon(
                        //   Icons.more_vert,
                        //   size: 30,
                        //   color: Colors.black54,
                        // ),
                      ),
                    ),
                  );
                  // return ListTile(
                  //  title: Text(usuario.name!),
                  //  subtitle: Text(usuario.email!),
                  // );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return CircularProgressIndicator();
            //https://www.youtube.com/watch?v=1uxnXwN0s5Q&ab_channel=RodrigoRahman

            //parei
            // https://www.youtube.com/watch?v=EZIbMLVaOpM&ab_channel=EmanuelSeverino
          },
        ),
      ),
      // ],
      //),
    );
  }

  Future<List<User>> getAllUsers() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      //retorna 200 se estiver ok
      print(json.decode(response.body));

      List listaUsuarios = json.decode(response.body);
      print(listaUsuarios.length);

      return listaUsuarios.map((jsonItem) => User.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Não foi possivel carregar os usuarios!');
    }
  }
}
