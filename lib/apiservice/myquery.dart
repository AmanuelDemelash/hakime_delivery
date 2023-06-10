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

// active order
  static String activeorder="""
  query(\$id:Int!){
  orders(where: {deliverer_id: {_eq:\$id}, status: {_eq: on_delivery}}, order_by: {created_at: desc}) {
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

  static String compOrder="""
  query(\$id:Int!){
  orders(where: {deliverer_id: {_eq:\$id}, status: {_eq: delivered}}){
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

  // completed
  static String completedOrder="""
  Query(\$id:Int!){
  orders(where: {deliverer_id: {_eq:\$id}, status: {_eq: delivered}}, order_by: {created_at: desc}) {
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

// active order detail
static String activeorderdetail="""
query(\$id:Int!){
  orders_by_pk(id:\$id) {
    order_address {
      location
      latitude
      longitude
    }
    pharmacy {
      address {
        latitude
        longitude
        location
      }
      logo_image {
        url
      }
      name
    }
    user {
      full_name
      profile_image {
        url
      }
      phone_number
    }
    id
    delivery_fee
    created_at
    total_cost
    order_code
  }
}
""";

// bank info

static String bank_info="""
query(\$id:Int!){
  bank_informations(where: {deliverer_id: {_eq:\$id}}) {
    id
    bank_name
    full_name
    account_number
  }
}


""";

// withdrawal

static String withdrawal="""
query(\$id:Int!){
  withdrawals(where: {deliverer_id: {_eq:\$id}}) {
     id
    amount
    created_at
    status
  }
}
""";


}
