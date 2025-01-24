import 'package:flutter/material.dart';
import '../models/verdura.dart';
import '../services/github_service.dart';

class VerdurasController with ChangeNotifier {
  final GithubService _githubService = GithubService();
  List<Verdura> _verduras = [];

  List<Verdura> get verduras => _verduras;

  Future<void> fetchVerduras() async {
    _verduras = await _githubService.getVerduras();
    notifyListeners();
  }

  Future<void> addVerdura(Verdura verdura) async {
    _verduras.add(verdura);
    await _githubService.updateVerduras(_verduras);
    notifyListeners();
  }

  Future<void> updateVerdura(Verdura verdura) async {
    final index = _verduras.indexWhere((v) => v.codigo == verdura.codigo);
    if (index != -1) {
      _verduras[index] = verdura;
      await _githubService.updateVerduras(_verduras);
      notifyListeners();
    }
  }

  Future<void> deleteVerdura(int codigo) async {
    _verduras.removeWhere((v) => v.codigo == codigo);
    await _githubService.updateVerduras(_verduras);
    notifyListeners();
  }

  Verdura? getVerduraByCodigo(int codigo) {
    try {
      return _verduras.firstWhere((v) => v.codigo == codigo);
    } catch (e) {
      return null;
    }
  }
}

