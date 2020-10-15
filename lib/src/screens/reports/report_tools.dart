import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> writeFile({
  @required final List<int> fileContent,
  @required final String fileName,
  @required final Function successAlert,
  @required final Function errorAlert,
}) async {
  final isPermissionGranted = await requestPermissions;
  final downloadPath = await getDownloadPath;

  if (isPermissionGranted && downloadPath != null) {
    final file = new File('$downloadPath/$fileName.xlsx');
    file.writeAsBytesSync(fileContent);
    successAlert();
  } else {
    errorAlert();
  }
}

Future<String> get getDownloadPath async {
  try {
    final directory = await DownloadsPathProvider.downloadsDirectory;
    return directory.path;
  } catch (e) {
    return null;
  }
}

Future<bool> get requestPermissions async {
  try {
    final bool granted = await Permission.storage.isGranted;
    if (granted) {
      return granted;
    }
    await Permission.storage.request();
    return await Permission.storage.isGranted;
  } catch (e) {
    return false;
  }
}

void successAlert({
  @required final GlobalKey<ScaffoldState> scaffoldKey,
  @required final String title,
  @required final String subTitle,
}) {
  _viewAlert(
    scaffoldKey: scaffoldKey,
    color: Colors.green,
    title: title,
    subTitle: subTitle,
  );
}

void errorAlert({
  @required final GlobalKey<ScaffoldState> scaffoldKey,
  @required final String title,
  @required final String subTitle,
}) {
  _viewAlert(
    scaffoldKey: scaffoldKey,
    color: Colors.red,
    title: title,
    subTitle: subTitle,
  );
}

void _viewAlert({
  @required final GlobalKey<ScaffoldState> scaffoldKey,
  @required final Color color,
  @required final String title,
  @required final String subTitle,
}) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: ListTile(
      title: Text('$title'),
      subtitle: Text('$subTitle'),
    ),
  );
  scaffoldKey.currentState.showSnackBar(snackBar);
}
