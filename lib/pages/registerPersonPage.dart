import 'package:aula_firebase/pages/database/databaseOperations.dart';
import 'package:flutter/material.dart';
import '../AppRoutes.dart';
import '../components/customTextFormField.dart';

class RegisterPersonPage extends StatefulWidget {
  const RegisterPersonPage({super.key});

  @override
  State<RegisterPersonPage> createState() => _RegisterPersonPageState();
}

class _RegisterPersonPageState extends State<RegisterPersonPage> {
  TextEditingController _controller_nome = TextEditingController();
  TextEditingController _controller_email = TextEditingController();
  TextEditingController _controller_cpf = TextEditingController();
  TextEditingController _controller_nascimento = TextEditingController();
  TextEditingController _controller_telefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Cadastrar Nova Pessoa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            CustomTextFormField(
                campo: 'Nome Completo', controlador: _controller_nome),
            SizedBox(
              height: 15,
            ),
            CustomTextFormField(
                campo: 'E-mail', controlador: _controller_email),
            SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              campo: 'CPF',
              controlador: _controller_cpf,
              tipoInput: TextInputType.number,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              campo: 'Data de Nascimento',
              controlador: _controller_nascimento,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextFormField(
                campo: 'Telefone', controlador: _controller_telefone),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  DatabaseOperationsFirebase().createNewUserFirebase(
                    _controller_nome.text,
                    _controller_email.text,
                    _controller_cpf.text,
                    _controller_nascimento.text,
                    _controller_telefone.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cadastro feito com sucesso! ')));
                  print('Cadastrando...');
                  Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
