abstract class DatasourceAddress {
  Future<bool> create(Map<String,dynamic> address,String idUser);
  Future<bool> delete(String idDoc,String idUser);
}