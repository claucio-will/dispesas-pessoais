import 'package:dispesas/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final price = double.tryParse(_priceController.text) ?? 0;

    if (title.isEmpty || price <= 0) {
      return;
    }
    widget.onSubmit(title, price, _selectedDate);
  }

  String formValid(String value) {
    if (value.isEmpty) {
      return 'Preencha o campo';
    }
    return null;
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickerDate) {
      if (pickerDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickerDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: 'Titulo', border: InputBorder.none),
                  validator: formValid,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Valor (R\$)',
                    border: InputBorder.none,
                  ),
                  validator: formValid,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                    TextButton(
                        onPressed: _showDatePicker,
                        child: Text('Selecionar data'))
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _submitForm();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return ThemeApp.colorPrimary.withOpacity(0.90);
                        }
                        return ThemeApp
                            .colorPrimary; // Use the component's default.
                      },
                    ),
                  ),
                  child: Text(
                    'NOVA TRANSAÇÃO',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
