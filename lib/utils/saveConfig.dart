import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SaveConfig extends ChangeNotifier {
  String accent = 'Color(0xFFe53935)';
  String background1 = 'Color(0xFFff9966)';
  String background2 = 'Color(0xFFff5e62)';
  bool _viewMode = true;
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  _encryptJSON(plainText) {
    final encrypted = encrypter.encryptBytes(plainText, iv: iv);
    return encrypted.bytes;
  }

  _decryptJSON(encText) {
    encrypt.Encrypted en = encrypt.Encrypted(encText);
    return encrypter.decryptBytes(en, iv: iv);
  }

  var configJSON = new Map<String, dynamic>();
  changeAccent(Color accentColor) {
    accent = accentColor.toString();
    writeConfig();
    notifyListeners();
  }

  changeBackground(Color color1, Color color2) {
    background1 = color1.toString();
    background2 = color2.toString();
    writeConfig();
    notifyListeners();
  }

  changeView(bool value) {
    _viewMode = value;
    writeConfig();
    notifyListeners();
  }

  estimateColor(Color accent) {
    if (ThemeData.estimateBrightnessForColor(accent) == Brightness.dark)
      return Colors.white;
    else
      return Colors.black;
  }

  resetConfig() {
    accent = 'Color(0xFFe53935)';
    background1 = 'Color(0xFFff9966)';
    background2 = 'Color(0xFFff5e62)';
    configJSON.clear();
    clearConfigJSON();
    writeConfig();
    notifyListeners();
  }

  getAccent() {
    String valueString = accent.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  getGradient() {
    String valueString1 = background1.split('(0x')[1].split(')')[0];
    String valueString2 = background2.split('(0x')[1].split(')')[0];
    int value1 = int.parse(valueString1, radix: 16);
    int value2 = int.parse(valueString2, radix: 16);
    List<Color> gradient = [Color(value1), Color(value2)];
    return gradient;
  }

  getView() {
    return _viewMode;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/.config');
  }

  Future<void> readConfig() async {
    try {
      File file = await _localFile;
      var jsonString = await file.readAsBytes();
      var data = jsonDecode(utf8.decode(_decryptJSON(jsonString)));
      accent = data['accent'].toString();
      background1 = data['background1'];
      background2 = data['background2'];
      _viewMode = data['viewMode'];
      notifyListeners();
    } catch (FileSystemException) {
      File file = await _localFile;
      file.create();
    }
  }

  Future writeConfig() async {
    configJSON['accent'] = accent;
    configJSON['background1'] = background1;
    configJSON['background2'] = background2;
    configJSON['viewMode'] = _viewMode;
    var serializedMap = _encryptJSON(utf8.encode(jsonEncode(configJSON)));
    File f = await _localFile;
    await f.writeAsBytes(serializedMap);
    readConfig();
  }

  clearConfigJSON() async {
    final path = await _localFile;
    return path.writeAsString("");
  }
}
