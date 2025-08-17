import 'package:tokona/packages/packages.dart';

class MerchantModel extends Equatable {
  final String? message;
  final List<MerchantDataModel>? data;

  const MerchantModel({
    required this.message,
    required this.data,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      message: json["message"],
      data: List<MerchantDataModel>.from(
        json["data"].map(
          (x) => MerchantDataModel.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  Merchant toEntity() => Merchant(
    message: message,
    data: data!
        .map(
          (e) => MerchantData(
            id: e.id,
            code: e.code,
            name: e.name,
            address: e.address,
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
