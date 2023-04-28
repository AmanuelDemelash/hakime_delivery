class Myquery {
  // dashbord heder profile

  static String dashbord_profile = """
query(\$id:Int!){
  deliverers_by_pk(id:\$id) {
    id
    full_name
    image {
      url
    }
    is_online
  }
}
""";

// online status

  static String online_status = """
query(\$id:Int!){
  deliverers_by_pk(id:\$id) {
    is_online
  }
}
""";

// data

  static String data_one = """
 query(\$id:Int!){
  deliverers_by_pk(id:\$id) {
    wallet
    orders {
      id
    }
  }
}


""";
}
