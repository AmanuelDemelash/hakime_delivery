class Mymutation {
  // login
  static String login = """
  mutation delivererlogin(\$email:String!,\$password:String!){
  delivererlogin(email:\$email, password:\$password) {
    id
    token
  }
}
  """;

  // update online status

  static String update_online_status = """
  mutation(\$id:Int!,\$is_online:Boolean!){
  update_deliverers_by_pk(pk_columns: {id: \$id}, _set: {is_online:\$is_online}) {
    is_online
  }
}

""";
}
