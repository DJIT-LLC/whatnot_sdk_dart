// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShowAnalytics
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "show_analytics_status.dart" as _i1;
import "money.dart" as _i2;

class ShowAnalytics(
  /// The show these analytics describe.
  final String showId,

  /// The show's title.
  final String title,

  /// When the show started.
  final DateTime startTime,

  /// WILL_NOT_BE_CALCULATED if the show was cancelled, is private or is a rehearsal, so no analytics will ever exist. NOT_ENDED while the show has not ended, so no analytics exist yet. PENDING once it has ended but the metrics are still being calculated. GENERATED once they are final. Metrics are null unless GENERATED.
  final _i1.ShowAnalyticsStatus? calculationStatus,

  /// Gross sales.
  final _i2.Money? sales,

  /// Estimated earnings; can be negative after refunds and fees.
  final _i2.Money? estimatedEarnings,

  /// Number of orders.
  final int? ordersCount,

  /// Average order value.
  final _i2.Money? averageOrderValue,

  /// Number of giveaway orders.
  final int? giveawayOrdersCount,

  /// Amount spent on giveaways; can be negative.
  final _i2.Money? giveawaySpend,

  /// Number of times the show was shown to viewers.
  final int? showImpressionCount,

  /// Percentage of impressions that were tapped, to two decimal places. Null when there were no impressions.
  final double? showClickthroughRate,

  /// Number of distinct buyers.
  final int? buyersCount,

  /// Buyers purchasing from the seller for the first time.
  final int? firstTimeBuyersCount,

  /// Buyers who had purchased from the seller before.
  final int? returningBuyersCount,

  /// Number of distinct giveaway winners.
  final int? giveawayWinnersCount,

  /// Giveaway winners who had not bought from the seller before.
  final int? firstTimeGiveawayWinnersCount,

  /// Giveaway winners who had bought from the seller before.
  final int? returningGiveawayWinnersCount,

  /// Number of times buyers shared the show.
  final int? buyerSharesCount,

  /// Minutes the show ran.
  final int? streamMinutes,

  /// Peak number of simultaneous viewers.
  final int? maxConcurrentViewers,

  /// Total views.
  final int? totalViews,

  /// Number of distinct viewers.
  final int? distinctViewersCount,

  /// Average viewer rating of the show.
  final double? averageRating,
) {
  factory ShowAnalytics.fromJson(Map<String, dynamic> json) => ShowAnalytics(
    json["show_id"] as String,
    json["title"] as String,
    DateTime.parse(json["start_time"] as String),
    json["calculation_status"] != null
        ? _i1.ShowAnalyticsStatus.fromJson(json["calculation_status"])
        : null,
    json["sales"] != null
        ? _i2.Money.fromJson(json["sales"] as Map<String, dynamic>)
        : null,
    json["estimated_earnings"] != null
        ? _i2.Money.fromJson(json["estimated_earnings"] as Map<String, dynamic>)
        : null,
    json["orders_count"] as int?,
    json["average_order_value"] != null
        ? _i2.Money.fromJson(
            json["average_order_value"] as Map<String, dynamic>,
          )
        : null,
    json["giveaway_orders_count"] as int?,
    json["giveaway_spend"] != null
        ? _i2.Money.fromJson(json["giveaway_spend"] as Map<String, dynamic>)
        : null,
    json["show_impression_count"] as int?,
    json["show_clickthrough_rate"] as double?,
    json["buyers_count"] as int?,
    json["first_time_buyers_count"] as int?,
    json["returning_buyers_count"] as int?,
    json["giveaway_winners_count"] as int?,
    json["first_time_giveaway_winners_count"] as int?,
    json["returning_giveaway_winners_count"] as int?,
    json["buyer_shares_count"] as int?,
    json["stream_minutes"] as int?,
    json["max_concurrent_viewers"] as int?,
    json["total_views"] as int?,
    json["distinct_viewers_count"] as int?,
    json["average_rating"] as double?,
  );

  Map<String, dynamic> toJson() => {
    "show_id": showId,
    "title": title,
    "start_time": startTime.toIso8601String(),
    if (calculationStatus != null)
      "calculation_status": calculationStatus?.toJson(),
    if (sales != null) "sales": sales?.toJson(),
    if (estimatedEarnings != null)
      "estimated_earnings": estimatedEarnings?.toJson(),
    if (ordersCount != null) "orders_count": ordersCount,
    if (averageOrderValue != null)
      "average_order_value": averageOrderValue?.toJson(),
    if (giveawayOrdersCount != null)
      "giveaway_orders_count": giveawayOrdersCount,
    if (giveawaySpend != null) "giveaway_spend": giveawaySpend?.toJson(),
    if (showImpressionCount != null)
      "show_impression_count": showImpressionCount,
    if (showClickthroughRate != null)
      "show_clickthrough_rate": showClickthroughRate,
    if (buyersCount != null) "buyers_count": buyersCount,
    if (firstTimeBuyersCount != null)
      "first_time_buyers_count": firstTimeBuyersCount,
    if (returningBuyersCount != null)
      "returning_buyers_count": returningBuyersCount,
    if (giveawayWinnersCount != null)
      "giveaway_winners_count": giveawayWinnersCount,
    if (firstTimeGiveawayWinnersCount != null)
      "first_time_giveaway_winners_count": firstTimeGiveawayWinnersCount,
    if (returningGiveawayWinnersCount != null)
      "returning_giveaway_winners_count": returningGiveawayWinnersCount,
    if (buyerSharesCount != null) "buyer_shares_count": buyerSharesCount,
    if (streamMinutes != null) "stream_minutes": streamMinutes,
    if (maxConcurrentViewers != null)
      "max_concurrent_viewers": maxConcurrentViewers,
    if (totalViews != null) "total_views": totalViews,
    if (distinctViewersCount != null)
      "distinct_viewers_count": distinctViewersCount,
    if (averageRating != null) "average_rating": averageRating,
  };
}
