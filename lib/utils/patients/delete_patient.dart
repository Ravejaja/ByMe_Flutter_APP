import 'package:byme_flutter_app/utils/token/read_token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeletePatient extends StatefulWidget {
  final BuildContext context;
  final int patientId;
  final PageController pageController;

  const DeletePatient(
      {Key? key,
      required this.context,
      required this.patientId,
      required this.pageController})
      : super(key: key);

  @override
  State<DeletePatient> createState() => _DeletePatientState();
}

class _DeletePatientState extends State<DeletePatient> {
  bool isLoading = false;

  Future<bool?> deletePatient(int patientId) async {
    final userStorage = await readToken();
    String token = userStorage?['token'];

    var url =
        Uri.parse('https://api-py-byme.onrender.com/patient/delete_patient');

    var body = {
      "patient_id": patientId,
    };

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response =
          await http.delete(url, body: jsonEncode(body), headers: header);

      switch (response.statusCode) {
        case 200:
          return true;
        case 400:
          return false;
        case 401:
          return false;
        case 500:
          return false;
      }
    } catch (error) {
      throw 'Error: $error';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(
        width: 150,
        height: 150,
        child: Image.asset('assets/images/warning.png'),
      ),
      content: const Text(
        'Você não poderá voltar atrás com esta ação. Tem certeza que deseja excluir o paciente?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(widget.context).pop();
          },
        ),
        TextButton(
          child: isLoading
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                )
              : const Text('Excluir'),
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            deletePatient(widget.patientId).then((success) {
              if (success == true) {
                Navigator.of(widget.context).pop();
                widget.pageController.jumpToPage(2);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Paciente excluído com sucesso.'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ));
              } else {
                Navigator.of(widget.context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Não foi possível excluir o paciente.'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ));
              }
            });
          },
        ),
      ],
    );
  }
}
