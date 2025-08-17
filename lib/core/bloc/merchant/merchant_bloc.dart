import 'package:tokona/packages/packages.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final GetCurrentMerchant getCurrentMerchant;

  MerchantBloc(this.getCurrentMerchant) : super(const MerchantState()) {
    on<MerchantGetted>(
      (event, emit) async {
        if (state.hasReachedMax) return;
        final result = await getCurrentMerchant.get(
          event.search,
          state.page,
          state.pageSize,
        );
        result.fold(
          (failure) {
            emit(
              state.copyWith(
                status: failure.statusCode == 500
                    ? MerchantResponse.offline
                    : MerchantResponse.failure,
                errorMessage: failure.message,
                errorCode: failure.statusCode,
              ),
            );
          },
          (merchant) {
            final listMerchantData = merchant.data ?? [];
            emit(
              state.copyWith(
                status: MerchantResponse.success,
                listMerchantData: List.of(
                  state.listMerchantData,
                )..addAll(listMerchantData),
                page: state.page + 1,
                hasReachedMax: listMerchantData.length < state.pageSize,
              ),
            );
          },
        );
      },
      transformer: Droppables.throttle(),
    );
    on<MerchantRefreshed>((event, emit) async {
      emit(
        state.copyWith(
          status: MerchantResponse.loading,
          listMerchantData: [],
          page: 1,
          hasReachedMax: false,
          errorMessage: null,
          errorCode: null,
        ),
      );
      final result = await getCurrentMerchant.get(
        event.search,
        1,
        state.pageSize,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: failure.statusCode == 500
                  ? MerchantResponse.offline
                  : MerchantResponse.failure,
              errorMessage: failure.message,
              errorCode: failure.statusCode,
            ),
          );
        },
        (merchant) {
          final listMerchantData = merchant.data ?? [];
          emit(
            state.copyWith(
              status: MerchantResponse.success,
              listMerchantData: listMerchantData,
              page: 1,
              hasReachedMax: listMerchantData.length > 5
                  ? listMerchantData.isEmpty
                  : true,
            ),
          );
        },
      );
    });
  }
}
