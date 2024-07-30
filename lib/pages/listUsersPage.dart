import 'package:flutter/material.dart';

import '../AppRoutes.dart';
import '../components/showAlertDialog.dart';
import 'database/databaseOperations.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({super.key});

  @override
  State<ListUsersPage> createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  // static SupabaseUsersTable supabaseInstanceUsers = SupabaseUsersTable();
  // final Future<List<dynamic>> _listaUsuarios =
  //     supabaseInstanceUsers.getUsersSupabase();

  final Future<List<dynamic>> _listaUsuarios =
      DatabaseOperationsFirebase().listUsersFirebase();

  List<String> _nomesUsuarios = [];

  void trocarNome(indexNome, novoNome) {
    setState(() {
      _nomesUsuarios[indexNome] = novoNome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Pessoas'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent),
      body: FutureBuilder<List<dynamic>>(
        future: _listaUsuarios,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            print('aqui: ${snapshot.data}');
            return ListView.builder(
              itemBuilder: (context, index) {
                //trocarNome();
                _nomesUsuarios.add(snapshot.data?[index]['nome']);

                //int id_pessoa = snapshot.data?[index]['id'];

                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.blueAccent,
                  ),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              TextEditingController _textEditingController =
                                  TextEditingController(
                                text: _nomesUsuarios[index],
                              );

                              return ShowAlertDialog(
                                title: SizedBox.shrink(),
                                content: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Editar Nome',
                                    ),
                                    controller: _textEditingController),
                                yesAnswer: 'Salvar',
                                alertAction: () {
                                  String novo_nome =
                                      _textEditingController.text;
                                  print(novo_nome);
                                  Future<void> editar_pessoa =
                                      DatabaseOperationsFirebase()
                                          .editUserNameFirebase(
                                    snapshot.data?[index]['id'],
                                    novo_nome,
                                  );

                                  editar_pessoa.then((value) {
                                    trocarNome(index, novo_nome);
                                  });
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.cyanAccent,
                        ),
                      ),
                      Text(
                        '${_nomesUsuarios[index]}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ShowAlertDialog(
                                title: Text('Excluir Pessoa'),
                                content: Text(
                                  'Tem certeza que deseja excluir o usuário '
                                  '${_nomesUsuarios[index]}?',
                                ),
                                yesAnswer: 'Sim',
                                alertAction: () {
                                  DatabaseOperationsFirebase()
                                      .deletePersonFirebase(
                                          snapshot.data?[index]['id']);
                                  print('excluindo pessoa');
                                  // Navigator.pushReplacementNamed(
                                  //     context, AppRoutes.homePage);
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: snapshot.data?.length,
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 10,
            ));
          }
        },
      ),
    );
  }
}
