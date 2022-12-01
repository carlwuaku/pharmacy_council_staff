class UsersModel {
  static String tableName = "user";

  int id;
  String displayName;
  String email;

  UsersModel(
      {required this.id, required this.displayName, required this.email});
}
