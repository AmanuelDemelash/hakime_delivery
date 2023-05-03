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
  // profile heder

 static String delivery_profile_header="""
 query(\$id:Int!){
  deliverers_by_pk(id:\$id) {
    full_name
    phone_number
    image {
      url
    }
  }
}
 """;

 // wallet page

static String delivery_wallet="""
query(\$id:Int!){
  deliverers_by_pk(id:\$id) {
    wallet
    bank_info {
      full_name
    }
  }
}
""";

// order

static String neworder="""
query{
  orders(where: {status: {_eq: confirmed}}, order_by: {created_at: desc}) {
    id
    distance
    order_address {
      location
    }
    pharmacy {
      name
      logo_image {
        url
      }
      address {
        location
      }
    }
    delivery_fee
    created_at
  }
}
""";
}
