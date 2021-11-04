import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:slideshow/controllers/setid.controller.dart';
import './../util/theme_config.dart';

//Verificando se o id ja foi definido
class Verify extends StatelessWidget {
  final c = Get.put(SetIdController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: GetBuilder<SetIdController>(
        initState: (_) async {
          c.verify();
        },
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  themeData.themePrimaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SetId extends StatelessWidget {
  final c = Get.put(SetIdController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: RawKeyboardListener(
        onKey: (RawKeyEvent event) async {
          if (event.runtimeType == RawKeyDownEvent) {
            switch (event.logicalKey.keyLabel) {
              case 'Enter':
                c.setId(context);
                break;
              case 'Ok':
                c.setId(context);
                break;
              case 'Arrow Up':
                c.formIdFocus.requestFocus();
                break;
              case 'Arrow Down':
                c.formKeyFocus.requestFocus();
                break;
              default:
            }
          }
        },
        autofocus: true,
        focusNode: FocusNode(),
        child: Scaffold(
          body: Center(
            child: GetBuilder<SetIdController>(
              init: SetIdController(),
              initState: (_) {
                c.formIdFocus.requestFocus();
              },
              builder: (_) {
                return c.isLoading == false
                    ? Container(
                        constraints: BoxConstraints(maxWidth: 412.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'INSIRA O ID DA SUA LOJA',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: c.formId,
                                  autofocus: true,
                                  focusNode: c.formIdFocus,
                                  decoration: InputDecoration(
                                    labelText: 'ID',
                                    prefixIcon: Icon(Icons.store),
                                    filled: true,
                                    labelStyle: TextStyle(fontSize: 13.0),
                                    hintText: "Insira um id",
                                  ),
                                  onEditingComplete: () {
                                    c.formKeyFocus.requestFocus();
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: c.formKey,
                                autofocus: true,
                                focusNode: c.formKeyFocus,
                                decoration: InputDecoration(
                                  labelText: 'Código de acesso',
                                  prefixIcon: Icon(Icons.vpn_key),
                                  filled: true,
                                  labelStyle: TextStyle(fontSize: 13.0),
                                  hintText: "Insira o seu código de acesso",
                                ),
                                onEditingComplete: () {
                                  c.setId(context);
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8.0),
                              child: new SizedBox(
                                width: double.infinity,
                                height: 48.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: themeData.themePrimaryColor,
                                  ),
                                  child: Text(
                                    "Verificar / Confirmar",
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    c.setId(context);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Caso não possua o código de acesso contacte o seu administrador.',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            themeData.themePrimaryColor,
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
