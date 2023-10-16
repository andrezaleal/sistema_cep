import 'package:via_cep_api/model/cep_api_model.dart';
import 'package:via_cep_api/repositories/custom_dio.dart';

class CepApiRepository {
  final _custonDio = CustonDio();

  CepApiRepository();

  Future<CepApiModel> readCEP() async {
    var url = "/Ceps";
    var result = await _custonDio.dio.get(url);
    return CepApiModel.fromJson(result.data);
  }

  Future<void> create(CEPModel cepModel) async {
    try {
      await _custonDio.dio.post("/Ceps", data: cepModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> update(CEPModel cepModel) async {
    try {
      var response = await _custonDio.dio
          .put("/Ceps/${cepModel.objectId}", data: cepModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> delete(String objectId) async {
    try {
      var response = await _custonDio.dio.delete(
        "/Ceps/$objectId",
      );
    } catch (e) {
      throw e;
    }
  }

   Future<CepApiModel> isCepInDatabase(String cep) async {
    var url = "/Ceps?where={\"cep\":\"$cep\"}";
    var result = await _custonDio.dio.get(url);
    return CepApiModel.fromJson(result.data);
  }
}
