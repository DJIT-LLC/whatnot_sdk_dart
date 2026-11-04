import "../config/whatnot_config.dart";
import "../generated/api.dart";
import "../http/whatnot_http_client.dart";

/// Main client for interacting with the Whatnot Seller REST v2 API.
class WhatnotSellerClient {
  /// The configuration used by this client.
  final WhatnotConfig config;

  final WhatnotHttpClient _httpClient;

  /// Products operations (list, create, update, delete, variants).
  late final ProductsApi products = ProductsApi(_httpClient);

  /// Orders operations (list, get, cancel, order items).
  late final OrdersApi orders = OrdersApi(_httpClient);

  /// Inventory operations (adjust, set stock levels).
  late final InventoryApi inventory = InventoryApi(_httpClient);

  /// Shipments operations (list, items, generate label, add tracking).
  late final ShipmentsApi shipments = ShipmentsApi(_httpClient);

  /// Shipping dimension profiles operations.
  late final ShippingApi shipping = ShippingApi(_httpClient);

  /// Merchandising operations (product merchandising, show lineups).
  late final MerchandisingApi merchandising = MerchandisingApi(_httpClient);

  /// Shows and livestreams operations.
  late final ShowsApi shows = ShowsApi(_httpClient);

  /// Analytics operations (show analytics).
  late final AnalyticsApi analytics = AnalyticsApi(_httpClient);

  /// Reports and statements operations.
  late final ReportsAndStatementsApi reports = ReportsAndStatementsApi(
    _httpClient,
  );

  /// User and authentication operations (get me, disconnect).
  late final UsersApi users = UsersApi(_httpClient);

  /// General operations (health check).
  late final GeneralApi general = GeneralApi(_httpClient);

  /// Creates a new Whatnot Seller client with the specified [config].
  WhatnotSellerClient(this.config) : _httpClient = WhatnotHttpClient(config);

  /// Creates a new Whatnot Seller client with the provided [apiKey].
  WhatnotSellerClient.withToken(String apiKey) : this(WhatnotConfig(apiKey));

  /// Closes the client and releases underlying HTTP connection pools.
  void close() => _httpClient.close();
}
