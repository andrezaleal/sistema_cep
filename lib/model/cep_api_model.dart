class CepApiModel {
  List<CEPModel> cep = [];

  CepApiModel(this.cep);

  CepApiModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      cep = <CEPModel>[];
      json['results'].forEach((v) {
        cep.add(CEPModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = cep.map((v) => v.toJson()).toList();
    return data;
  }
}

class CEPModel {
  String objectId = "";
  String cep = "";
  String estado = "";
  String logradouro = "";
  String cidade = "";

  CEPModel(this.objectId, this.cep, this.estado, this.logradouro, this.cidade);

  CEPModel.criar(this.cep, this.estado, this.logradouro, this.cidade);

  CEPModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    estado = json['estado'];
    logradouro = json['logradouro'];
    cidade = json['cidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['estado'] = estado;
    data['logradouro'] = logradouro;
    data['cidade'] = cidade;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['estado'] = estado;
    data['logradouro'] = logradouro;
    data['cidade'] = cidade;
    return data;
  }
}
