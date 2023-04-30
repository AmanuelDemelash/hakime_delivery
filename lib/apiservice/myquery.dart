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
    orders {
      id
      status
      delivery_fee
    }
    wallet
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

}
