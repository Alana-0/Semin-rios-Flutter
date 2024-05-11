import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:puc_minas/app/core/components/vehicle_card.dart';
import 'package:puc_minas/app/core/constants/app_assests.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/core/constants/modals/delete_alert_modal.dart';
import 'package:puc_minas/app/core/models/vehicle_model.dart';
import 'package:puc_minas/features/home/home_controller.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<VehicleModel> vehicles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () async {
                bool result = await HomeCrontroller.logout();
                if (result) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var vehicle = await Navigator.of(context).pushNamed(AppRoutes.add);

            if (vehicle != null) {
              vehicles.add(vehicle as VehicleModel);
              setState(() {});
            }
            ;
          },
          backgroundColor: Color.fromARGB(255, 163, 76, 175),
          child: const Icon(Icons.car_repair),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color.fromARGB(255, 182, 195, 239), Color.fromARGB(255, 202, 139, 229)],
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.asset(AppAssets.gif),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        vehicles.isEmpty
                            ? Center(
                                child: Text('Nenhum veiculo cadastrado'),
                              )
                            : ListView.builder(
                                itemCount: vehicles.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (direction) async {
                                      bool? deleted = await showDialog<bool>(context: context, builder: (context) => const DeleteAlertModal());

                                      if (deleted ?? false) {
                                        try {
                                          vehicles.removeAt(index);
                                          setState(() {});
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            const CustomSnackBar.success(message: 'O veículo foi excluido'),
                                          );
                                        } catch (e) {
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            const CustomSnackBar.error(message: 'O veículo não pode ser excluido'),
                                          );
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: VehicleCard(vehicle: vehicles[index]),
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
