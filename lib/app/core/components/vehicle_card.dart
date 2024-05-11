import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/models/vehicle_model.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.vehicle});

  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all(color: vehicle.color), borderRadius: BorderRadius.circular(5), color: vehicle.color.withOpacity(0.3)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Marca: ${vehicle.brand}'),
              Text('Ano: ${vehicle.year}'),
            ],
          ),
          Divider(color: vehicle.color),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Placa: ${vehicle.plate}'),
              Row(
                children: [
                  Text('Cor: '),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: vehicle.color),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
