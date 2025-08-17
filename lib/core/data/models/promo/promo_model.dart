import 'package:tokona/packages/packages.dart';

class PromoModel extends Equatable {
  final String? message;
  final List<PromoDataModel>? data;

  const PromoModel({
    required this.message,
    required this.data,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      message: json["message"],
      data: List<PromoDataModel>.from(
        json["data"].map(
          (x) => PromoDataModel.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  Promo toEntity() => Promo(
    message: message,
    data: data!
        .map(
          (e) => PromoData(
            id: e.id,
            code: e.code,
            photo: e.photo,
            name: e.name,
            description: e.description,
            price: e.price,
            discount: e.discount,
            endDate: e.endDate,
            merchantId: e.merchantId,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
          ),
        )
        .toList(),
  );

  @override
  List<Object?> get props => [
    data,
  ];
}
