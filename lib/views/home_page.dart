import 'package:flutter/material.dart';
import 'package:pesquisa_cep/services/via_cep_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String? _result;
  String? _localidade;
  String? _cep;
  String? _logradouro;
  String? _complemento;
  String? _bairro;
  String? _uf;
  String? _unidade;
  String? _ibge;
  String? _gia;
  String? _invalid;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: 'CEP'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FloatingActionButton(
        onPressed: _searchCep,
        child: _loading ? _circularLoading() : Text('Consultar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    _searching(true);

    final cep = _searchCepController.text;

    if(cep.isNotEmpty && (cep.toString().length == 8) ){
      final resultCep = await ViaCepService.fetchCep(cep: cep);
      print(resultCep.localidade); // Exibindo somente a localidade no terminal

      setState(() {
        _result = resultCep.toJson();
        _localidade = resultCep.localidade;
        _cep = resultCep.cep;
        _logradouro = resultCep.logradouro;
        _complemento = resultCep.complemento;
        _bairro = resultCep.bairro;
        _uf = resultCep.uf;
        _unidade = resultCep.unidade;
        _ibge = resultCep.ibge;
        _gia = resultCep.gia;
      });
    }else{
      _invalid = 'CEP inválido.';
      _result = null;
    }

    _searching(false);
  }

  Widget _buildResultForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: _result != null
          ? Center(
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'Localidade: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _localidade != null ? '$_localidade' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Logradouro: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _logradouro != null ? '$_logradouro' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Complemento: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _complemento != null ? '$_complemento' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Bairro: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _bairro != null ? '$_bairro' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'CEP: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _cep != null ? '$_cep' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'UF: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _uf != null ? '$_uf' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Unidade: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _unidade != null ? '$_unidade' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                              text: 'IBGE: ',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black),
                              children: [
                                TextSpan(
                                  text: _ibge != null ? '$_ibge' : " ",
                                  style: TextStyle(
                                    color: Colors.grey)
                                )
                              ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'GIA: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: _gia != null ? '$_gia' : " ",
                                      style: TextStyle(
                                          color: Colors.grey)
                                  )
                                ]
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          : Center(
        child: Column(
          children: [
            Text(
                _invalid ?? '',
                style: TextStyle(
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20)
            ),
          ],
        ),
      )
    );
  }
}
