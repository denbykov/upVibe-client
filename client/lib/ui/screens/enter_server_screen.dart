import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/api_info_model.dart';
import '../../models/server_connection_model.dart';

import '../components/app_page_route.dart';
import '../components/app_scaffold.dart';
import 'login_screen.dart';

class EnterServerScreen extends StatefulWidget {
  const EnterServerScreen({super.key});

  @override
  EnterServerScreenState createState() => EnterServerScreenState();
}

class EnterServerScreenState extends State<EnterServerScreen> {
  final _enterServerFormKey = GlobalKey<FormState>();

  final _addressController = TextEditingController();
  final _portController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var form = SizedBox(
        width: 300,
        child: Form(
            key: _enterServerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _makeLabel(context),
                _makeAddressField(),
                _makePortField(),
                _makeButtonsRow(context)
              ],
            )));

    return Consumer<ServerConnectionModel>(
      builder: (context, serverConnection, child) {
        _addressController.text = serverConnection.host ?? '';
        _portController.text = serverConnection.port?.toString() ?? '';

        return AppScaffold(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: form)
            ],
          ),
        );
      },
    );
  }

  Widget _makeTestConnectionDialogContent(
      BuildContext context, List<Widget> children) {
    return SizedBox(
      height: 180,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: children),
    );
  }

  Future<void> _makeTestConnectionDialog(
      BuildContext context, Future<ApiInfo> future) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            content: FutureBuilder<ApiInfo>(
              future: future,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return _makeTestConnectionDialogContent(context, [
                      SpinKitFoldingCube(
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                    ]);
                  default:
                    if (snapshot.hasError) {
                      return _makeTestConnectionDialogContent(context, [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('Connection failed'),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ]);
                    } else {
                      return _makeTestConnectionDialogContent(context, [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('Connection succeeded'),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ]);
                    }
                }
              },
            ));
      },
    );
  }

  Future<void> _testConnection() async {
    if (!_enterServerFormKey.currentState!.validate()) {
      return;
    }

    String host = _addressController.text;
    String port = _portController.text;

    final model = ApiInfoModel();
    _makeTestConnectionDialog(
        context, model.getApiInfo(host: host, port: port));
  }

  void _onSavePressed(BuildContext context) async {
    if (_enterServerFormKey.currentState!.validate()) {
      var model = Provider.of<ServerConnectionModel>(context, listen: false);
      model.host = _addressController.text;
      model.port = int.parse(_portController.text);
      await model.write();

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
            AppPageRoute(builder: (context) => const LoginScreen()));
      }
    }
  }

  Padding _makeButtonsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 56,
          ),
          Center(
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () => _onSavePressed(context),
                child: const Text('Save'),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Ink(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: const CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.network_ping,
                ),
                tooltip: 'Test connection',
                onPressed: () {
                  _testConnection();
                },
              )),
        ],
      ),
    );
  }

  Align _makeLabel(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 35, bottom: 8, left: 16),
        child: SelectableText('Enter the server location',
            textAlign: TextAlign.right,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Padding _makePortField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(),
          hintText: 'Port',
        ),
        controller: _portController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the port';
          }
          var portFormat = RegExp(
              r'^(6553[0-5]|655[0-2]\d|65[0-4]\d{2}|6[0-4]\d{3}|[1-5]?\d{1,4})$');
          if (!portFormat.hasMatch(value)) {
            return 'Incorrect port';
          }
          return null;
        },
      ),
    );
  }

  Padding _makeAddressField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(),
          hintText: 'Address',
        ),
        controller: _addressController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter host address';
          }
          var hostFromat = RegExp(
              r'^(?:(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$)|(?:^(?:(?=^.{1,253}$)(^(?!-)[a-zA-Z0-9-]{1,63}(?<!-)\.?)+(?:(?!-)[a-zA-Z0-9-]{1,63}(?<!-))$))$');
          if (!hostFromat.hasMatch(value)) {
            return 'Incorrect ip or DNS name';
          }
          return null;
        },
      ),
    );
  }
}
