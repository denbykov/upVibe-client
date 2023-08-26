import 'package:client/application/request_agent.dart';
import 'package:flutter/material.dart';
import '../../models/server_connection_model.dart';

import 'enter_server_screen.dart';
import 'login_screen.dart';

import '../components/app_scaffold.dart';
import '../../application/request_agent.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _initializationCompleted = false;
  bool _serverConnectionIsSpecified = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    super.initState();
    await initializeServerConnection();

    setState(() {
      _initializationCompleted = true;
    });
  }

  Future<void> initializeServerConnection() async {
    final serverConnectionModel = ServerConnectionModel();
    await serverConnectionModel.read();
    if (serverConnectionModel.host == null ||
        serverConnectionModel.port == null) {
      return;
    }

    RequestAgent().setBaseUrl(
        serverConnectionModel.host!, serverConnectionModel.port!.toString());

    setState(() {
      _serverConnectionIsSpecified = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(builder: (context) {
        if (_initializationCompleted) {
          return constuctFirstScreen(context);
        } else {
          return const AppScaffold(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget constuctFirstScreen(BuildContext context) {
    if (_serverConnectionIsSpecified) {
      return const LoginScreen();
    } else {
      return const EnterServerScreen();
    }
  }
}
