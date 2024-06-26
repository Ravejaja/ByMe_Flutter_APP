import 'package:byme_flutter_app/utils/modules/delete_module.dart';
import 'package:byme_flutter_app/utils/modules/get_module_data.dart';
import 'package:byme_flutter_app/utils/modules/update_module.dart';
import 'package:byme_flutter_app/utils/modules/update_module_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ModulePage extends StatefulWidget {
  final int moduleId;
  final PageController pageController;

  const ModulePage(
      {Key? key, required this.moduleId, required this.pageController})
      : super(key: key);

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getModuleData(widget.moduleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Scaffold(
              body: Center(
                child: Text('Erro ao carregar dados do utilizador'),
              ),
            );
          } else {
            Map<String, dynamic> module = snapshot.data?['module'];

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    widget.pageController.jumpToPage(6);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                              ),
                              const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 45),
                                    Text(
                                      'Informações do Módulo',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Módulo ${module['module']}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 5,
                              ),
                              Text(
                                module['episode'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              Container(
                                height: 5,
                              ),
                              Text(
                                module['status'] == "In Progress"
                                    ? 'Em progresso...'
                                    : module['status'] == "Finished"
                                        ? 'Terminado'
                                        : module['status'] == "Paused"
                                            ? 'Pausado'
                                            : module['status'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      right: 15,
                      bottom: 10,
                      child: SpeedDial(
                        backgroundColor: const Color(0xff672D6F),
                        foregroundColor: Colors.white,
                        animatedIcon: AnimatedIcons.menu_close,
                        children: [
                          SpeedDialChild(
                              shape: const CircleBorder(),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DeleteModule(
                                          context: context,
                                          moduleId: widget.moduleId,
                                          pageController:
                                              widget.pageController);
                                    });
                              },
                              backgroundColor: const Color(0xff672D6F),
                              foregroundColor: Colors.white,
                              label: 'Excluir módulo',
                              child: const Icon(Icons.delete_forever)),
                          SpeedDialChild(
                              shape: const CircleBorder(),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UpdateModuleStatus(
                                        context: context,
                                        moduleId: widget.moduleId,
                                        module: module,
                                        reloadPage: reloadPage,
                                      );
                                    });
                              },
                              backgroundColor: const Color(0xff672D6F),
                              foregroundColor: Colors.white,
                              label: 'Alterar estado do módulo',
                              child: const Icon(Icons.change_circle)),
                          SpeedDialChild(
                              shape: const CircleBorder(),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UpdateModule(
                                        context: context,
                                        moduleId: widget.moduleId,
                                        module: module,
                                        reloadPage: reloadPage,
                                      );
                                    });
                              },
                              backgroundColor: const Color(0xff672D6F),
                              foregroundColor: Colors.white,
                              label: 'Editar módulo',
                              child: const Icon(Icons.edit_square)),
                        ],
                      )),
                ],
              ),
            );
          }
        });
  }
}
