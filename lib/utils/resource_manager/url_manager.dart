enum UrlManager {
  baseTitleUrl("$baseUrl/title/"),
  refresh("$baseUrl/refresh"),
  cart("$baseUrl/cart"),
  allProductWithTitle("$baseUrl/title/titles"),
  register("$baseUrl/register"),
  allProduct("$baseUrl/title/all"),
  allTitle("$baseUrl/title/only-titles"), // change in admin manager
  Checkout("$baseUrl/checkout"),
  product("$baseUrl/product"),
  images("$baseUrl/images"),
  imageUpload("$baseUrl/upload"),
  dashboard("$baseUrl/dashboard"),
  login("$baseUrl/login");

  final String url;
  const UrlManager(this.url);
}

const String baseUrl = "http://127.0.0.1:5000";
