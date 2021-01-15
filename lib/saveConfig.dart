import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class saveConfig extends ChangeNotifier {
  List<String> accent = ['Color(0xFFe53935)'];
  List<String> background = [
    'Color(0xFFff9966)',
    'Color(0xFFff5e62),',
  ];
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
    accent.clear();
    accent.add(accentColor.toString());
    configJSON['accent'] = accent;
    writeConfig();
    notifyListeners();
  }

  changeBackground(Color Color1, Color Color2) {
    background.clear();
    background.add(Color1.toString());
    background.add(Color2.toString());
    writeConfig();
    notifyListeners();
  }

  resetConfig() {
    accent[0] = 'Color(0xFFe53935)';
    background = [
      'Color(0xFFff9966)',
      'Color(0xFFff5e62)',
    ];
    configJSON.clear();
    clearConfigJSON();
    writeConfig();
    notifyListeners();
  }

  getAccent() {
    String valueString = accent[0].split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  getGradient() {
    String valueString1 = background[0].split('(0x')[1].split(')')[0];
    String valueString2 = background[1].split('(0x')[1].split(')')[0];
    int value1 = int.parse(valueString1, radix: 16);
    int value2 = int.parse(valueString2, radix: 16);
    List<Color> gradient = [Color(value1), Color(value2)];
    return gradient;
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
    File file = await _localFile;
    if (file.existsSync() == true) {
      var jsonString = await file.readAsBytes();
      var data = jsonDecode(utf8.decode(_decryptJSON(jsonString)));
      accent[0] = data['accent'].toString();
      background[0] = data['background'][0];
      background[1] = data['background'][1];
      notifyListeners();
    } else {
      File file = await _localFile;
      file.create();
    }
  }

  Future writeConfig() async {
    configJSON['accent'] = accent;
    configJSON['background'] = background;
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
