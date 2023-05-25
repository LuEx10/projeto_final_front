import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import '../main.dart';

class MenuTreinamentos extends StatefulWidget {
  @override
  MenuTreinamentosCrudState createState() => MenuTreinamentosCrudState();
}

class MenuTreinamentosCrudState extends State<MenuTreinamentos> {
  final treinamentosController = TextEditingController();
  String nomeComercial = '';
  String descricao = '';
  String cargaHoraria = '';
  int codigo = Random().nextInt(1000);
  String minCandidatos = '';
  String maxCandidatos = '';
  DateTime dataInicialInscricao = DateTime.now();
  DateTime dataFinalInscricao = DateTime.now();
  DateTime dataInicialTreinamento = DateTime.now();
  DateTime dataFinalTreinamento = DateTime.now();

void criarTreinamento() {
  Treinamento treinamento = Treinamento(
    nomeComercial: nomeComercial,
    descricao: descricao,
    cargaHoraria: cargaHoraria,
    codigo: codigo,
    minCandidatos: minCandidatos,
    maxCandidatos: maxCandidatos,
    dataInicialInscricao: dataInicialInscricao,
    dataFinalInscricao: dataFinalInscricao,
    dataInicialTreinamento: dataInicialTreinamento,
    dataFinalTreinamento: dataFinalTreinamento,
  );

  var appState = context.watch<MyAppState>();
  appState.adicionarTreinamento(treinamento);
}

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Treinamentos', style: TextStyle(fontSize: 25)),
        TextFormField(
          controller: treinamentosController,
          decoration: InputDecoration(labelText: 'Nome Comercial'),
          onChanged: (value) {
            setState(() {
              nomeComercial = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Descrição'),
          onChanged: (value) {
            setState(() {
              descricao = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Carga Horária'),
          onChanged: (value) {
            setState(() {
              cargaHoraria = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Quantidade Mínima de Inscritos'),
          onChanged: (value) {
            setState(() {
              minCandidatos = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Quantidade Máxima de Inscritos'),
          onChanged: (value) {
            setState(() {
              maxCandidatos = value;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Criar Treinamento'),
                  content: TextField(
                    controller: treinamentosController,
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Salvar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        appState.adicionarTreinamento(Treinamento(nomeComercial: nomeComercial, descricao: descricao, cargaHoraria: cargaHoraria, codigo: codigo, minCandidatos: minCandidatos, maxCandidatos: maxCandidatos, dataInicialInscricao: dataInicialInscricao, dataFinalInscricao: dataFinalInscricao, dataInicialTreinamento: dataInicialTreinamento, dataFinalTreinamento: dataFinalTreinamento));
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        for (var treinamento in appState.treinamentos)
          ListTile(
            leading: Icon(Icons.task),
            title: Text(treinamento.nomeComercial),
          ),
      ],
    );
  }
}

class Treinamento {
  String nomeComercial;
  String descricao;
  String cargaHoraria;
  int codigo;
  String minCandidatos;
  String maxCandidatos;
  DateTime dataInicialInscricao;
  DateTime dataFinalInscricao;
  DateTime dataInicialTreinamento;
  DateTime dataFinalTreinamento;
  
  Treinamento({
    required this.nomeComercial,
    required this.descricao,
    required this.cargaHoraria,
    required this.codigo,
    required this.minCandidatos,
    required this.maxCandidatos,
    required this.dataInicialInscricao,
    required this.dataFinalInscricao,
    required this.dataInicialTreinamento,
    required this.dataFinalTreinamento,
  });

  @override
  String toString() {
    return 'Treinamento: '
        'nomeComercial=$nomeComercial, '
        'descricao=$descricao, '
        'cargaHoraria=$cargaHoraria, '
        'codigo=$codigo, '
        'minCandidatos=$minCandidatos, '
        'maxCandidatos=$maxCandidatos, '
        'dataInicialInscricao=$dataInicialInscricao, '
        'dataFinalInscricao=$dataFinalInscricao, '
        'dataInicialTreinamento=$dataInicialTreinamento, '
        'dataFinalTreinamento=$dataFinalTreinamento';
  }
}

class TreinamentosAlunoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Lista de Treinamentos:', style: TextStyle(fontSize: 25)),
        for (var treinamento in appState.treinamentos)
          ListTile(
            leading: Icon(Icons.task),
            title: Text('Nome Comercial: ${treinamento.nomeComercial}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Descrição: ${treinamento.descricao}'),
                Text('Carga Horária: ${treinamento.cargaHoraria}'),
                Text('Código: ${treinamento.codigo}'),
                Text('Mínimo de Candidatos: ${treinamento.minCandidatos}'),
                Text('Máximo de Candidatos: ${treinamento.maxCandidatos}'),
                Text('Data Inicial de Inscrição: ${DateFormat('dd/MM/yyyy').format(treinamento.dataInicialInscricao)}'),
                Text('Data Final de Inscrição: ${DateFormat('dd/MM/yyyy').format(treinamento.dataFinalInscricao)}'),
                Text('Data Inicial do Treinamento: ${DateFormat('dd/MM/yyyy').format(treinamento.dataInicialTreinamento)}'),
                Text('Data Final do Treinamento: ${DateFormat('dd/MM/yyyy').format(treinamento.dataFinalTreinamento)}'),

              ],
            ),
          ),
      ],
    );
  }
}