import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puc_minas/app/core/models/vehicle_model.dart';
import 'package:validatorless/validatorless.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({Key? key}) : super(key: key);

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final plateEC = TextEditingController();
  final brandEC = TextEditingController();
  final yearEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Color selectedColor = Colors.purple.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Veiculo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 157, 183, 230),
                const Color.fromARGB(255, 162, 139, 226),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: plateEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatorio'),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'Insira a placa do veiculo',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: brandEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatorio'),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'Marca do veiculo',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: yearEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatorio'),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'Ano do veiculo',
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      await showColorPickerDialog(context, selectedColor,
                          actionButtons: const ColorPickerActionButtons(
                            closeButton: true,
                          ),
                          barrierColor: Colors.black.withOpacity(0.7),
                          backgroundColor: Colors.lightBlue.shade50,
                          selectedColorIcon: Icons.color_lens,
                          elevation: 4,
                          pickersEnabled: {
                            ColorPickerType.primary: true,
                            ColorPickerType.accent: false,
                            ColorPickerType.wheel: true,
                          },
                          pickerTypeLabels: {
                            ColorPickerType.primary: 'Cor Primária',
                            ColorPickerType.wheel: 'Manual',
                          }).then((color) {
                        selectedColor = color;
                        setState(() {});
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 226, 179, 235))),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Selecione a cor:'),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 0.9),
                              borderRadius: BorderRadius.circular(50),
                              color: selectedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            int year = DateTime.now().year;

                            VehicleModel vehicle = VehicleModel(
                              brand: brandEC.text,
                              plate: plateEC.text,
                              year: int.tryParse(yearEC.text) ?? year,
                              color: selectedColor,
                            );

                            Navigator.of(context).pop(vehicle);
                          }
                        },
                        child: const Text('Cadastrar'),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
