import 'package:flutter/material.dart';

class DeleteAlertModal extends StatefulWidget {
  const DeleteAlertModal({super.key});

  @override
  State<DeleteAlertModal> createState() => _DeleteAlertModalState();
}

class _DeleteAlertModalState extends State<DeleteAlertModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      title: Text('Excluir Veiculo'),
      content: Text('Voce tem certeza?'),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Cancelar')),
        TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Excluir')),
      ],
    );
  }
}