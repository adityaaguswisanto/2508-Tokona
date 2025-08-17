import 'package:tokona/packages/packages.dart';

enum PromoResponse { loading, success, failure, offline }

final class PromoState extends Equatable {
  final PromoResponse status;
  final List<PromoData> listPromoData;
  final bool hasReachedMax;
  final int page;
  final int pageSize;
  final String errorMessage;
  final int errorCode;

  const PromoState({
    this.status = PromoResponse.loading,
    this.listPromoData = const <PromoData>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.pageSize = 20,
    this.errorMessage = "",
    this.errorCode = 0,
  });

  PromoState copyWith({
    PromoResponse? status,
    List<PromoData>? listPromoData,
    bool? hasReachedMax,
    int? page,
    int? pageSize,
    String? errorMessage,
    int? errorCode,
  }) {
    return PromoState(
      status: status ?? this.status,
      listPromoData: listPromoData ?? this.listPromoData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [
    status,
    listPromoData,
    hasReachedMax,
    page,
    pageSize,
    errorMessage,
    errorCode,
  ];
}
