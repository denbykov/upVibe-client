import 'package:client/feature/controllers/assets_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:client/domain/entities/file.dart';

import 'package:client/feature/snackBars.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/files_controller.dart';

class FilesPage extends StatelessWidget {
  final FilesController _filesController = Get.find<FilesController>();
  final SnackBarController _snackBarController = Get.find<SnackBarController>();
  final AssetsController _assetsController = Get.find<AssetsController>();
  final String _title = 'Files';

  FilesPage({super.key});

  ListTile buildFileTile(File file) {
    if (file.shortTags != null &&
        file.shortTags!.artist != null &&
        file.shortTags!.artist != null) {
      return ListTile(
        leading: FutureBuilder<SvgPicture>(
          future: _assetsController.getIconBySourceId(file.source.id),
          builder: (BuildContext context, AsyncSnapshot<SvgPicture> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            }
            return SizedBox(
              height: 48.0,
              width: 48.0,
              child: SpinKitPulse(
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            );
          },
        ),
        title: Text('${file.shortTags!.artist!} - ${file.shortTags!.title!}'),
        onTap: () => {},
      );
    }

    return ListTile(
      title: Text(file.sourceUrl),
    );
  }

  Widget buildContent(BuildContext context) {
    return FutureBuilder(
      future: _filesController.getFiles(),
      builder: (context, AsyncSnapshot<List<File>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(child: Text('Something went wrong'));
          }

          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return buildFileTile(snapshot.data![index]);
              });
        }
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _snackBarController.registerOnErrorCallback(showErrorSnackBar);

    return AppScaffoldWidget(
      title: _title,
      body: buildContent(context),
    );
  }
}
