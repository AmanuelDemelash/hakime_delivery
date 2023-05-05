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

  // accept order

  static String acceptorder="""
  mutation(\$deliverer_id:Int!,\$order_id:Int!){
  assignDeliverer(deliverer_id:\$deliverer_id, order_id:\$order_id) {
    id
  }
}

  
  """;
  // complete order

 static String completeorder="""
 mutation(\$id:Int!){
  update_orders_by_pk(_set: {status: delivered}, pk_columns: {id:\$id}) {
    id
  }
}
 
 """;

 // inser bank account

static String insert_bankinfo="""
mutation(\$bank_name:String!,\$name:String!,\$acc:String!,\$id:Int!){
  insert_bank_informations(objects: {bank_name:\$bank_name, full_name:\$name, account_number:\$acc, deliverer_id:\$id}) {
    returning {
      id
    }
  }
}

""";
}
