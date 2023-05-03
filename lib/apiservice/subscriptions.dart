class MySubscription {

  // new orders
  static String neworders="""
  subscription{
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
