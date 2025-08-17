import 'package:tokona/packages/packages.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final attendancesBloc = locator<AttendancesBloc>();
  final merchantBloc = locator<MerchantBloc>();
  final merchantController = ScrollController();

  final search = TextEditingController();

  String nik = "";
  String name = "";
  String position = "";
  String createdAt = "";

  @override
  void dispose() {
    attendancesBloc.close();
    merchantBloc.close();
    search.dispose();
    merchantController.removeListener(() {
      onScroll();
    });
    super.dispose();
  }

  @override
  void initState() {
    getAttendances();

    getMerchant();

    getUser();

    merchantController.addListener(() {
      onScroll();
    });
    super.initState();
  }

  void getAttendances() {
    attendancesBloc.add(
      const AttendancesGetted(),
    );
  }

  void onScroll() {
    if (isBottom()) getMerchant();
  }

  bool isBottom() {
    if (!merchantController.hasClients) return false;
    final maxScroll = merchantController.position.maxScrollExtent;
    final currentScroll = merchantController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void getMerchant() {
    merchantBloc.add(
      const MerchantGetted(search: ""),
    );
  }

  Future<void> getUser() async {
    nik = await Secures().getNik();
    name = await Secures().getName();
    position = await Secures().getPosition();
    createdAt = await Secures().getCreatedAt();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              const HomeBackgroundHeader(),
              Padding(
                padding: EdgeInsets.only(
                  top: Sizes.height(context) * 0.06,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeAppbar(),
                        HomeLogout(),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Cards(
                      radius: 16.r,
                      child: Column(
                        children: [
                          HomeEmployee(
                            nik: nik,
                            name: name,
                            position: position,
                            createdAt: createdAt,
                          ),
                          const Divider(
                            color: white200,
                            thickness: 1,
                          ),
                          BlocBuilder<AttendancesBloc, AttendancesState>(
                            bloc: attendancesBloc,
                            builder: (context, state) {
                              switch (state.status) {
                                case AttendancesResponse.loading:
                                  return const HomeAttendancesShimmer();
                                case AttendancesResponse.success:
                                  final attendances = state.attendances!;
                                  return HomeAttendances(
                                    attendancesBloc: attendancesBloc,
                                    attendances: attendances,
                                    workingHours: state.workingHours,
                                  );
                                case AttendancesResponse.offline:
                                  return Text(
                                    "Kamu Sedang Offline",
                                    style: Texts.medium(),
                                  );
                                case AttendancesResponse.failure:
                                  return Text(
                                    state.message,
                                    style: Texts.medium(),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                HomeSearch(
                  search: search,
                  onFieldSubmitted: (value) {
                    merchantBloc.add(
                      MerchantRefreshed(
                        search: value,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<AttendancesBloc, AttendancesState>(
                    bloc: attendancesBloc,
                    builder: (context, state) {
                      switch (state.status) {
                        case AttendancesResponse.loading:
                          return const HomeMerchantShimmer();
                        case AttendancesResponse.success:
                          final attendances = state.attendances!;
                          final status = attendances.data?.status;
                          if (attendances.data == null || status == 2) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 80.w,
                                    color: orange,
                                  ),
                                  Text(
                                    "Kamu belum melakukan absensi",
                                    style: Texts.medium(),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  SizedBox(
                                    width: Sizes.width(context) * 0.36,
                                    height: Sizes.height(context) * 0.03,
                                    child: Buttons(
                                      onPressed: () => showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        enableDrag: false,
                                        isDismissible: false,
                                        backgroundColor: white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(
                                              20.r,
                                            ),
                                          ),
                                        ),
                                        builder: (context) => AttendancesModal(
                                          attendancesBloc: attendancesBloc,
                                          attendances: attendances,
                                        ),
                                      ),
                                      label: status == 1
                                          ? "Check Out"
                                          : "Check In",
                                      fontSize: 10.sp,
                                      isSemiBold: true,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return BlocBuilder<MerchantBloc, MerchantState>(
                            bloc: merchantBloc,
                            builder: (context, state) {
                              switch (state.status) {
                                case MerchantResponse.loading:
                                  return const HomeMerchantShimmer();
                                case MerchantResponse.success:
                                  final listMerchantData =
                                      state.listMerchantData;
                                  final hasReachedMax = state.hasReachedMax;
                                  if (listMerchantData.isEmpty) {
                                    return const Emptys(
                                      iconData: Icons.store,
                                      title: "Tidak ada data merchant",
                                    );
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                      top: 16.w,
                                    ),
                                    controller: merchantController,
                                    itemCount: hasReachedMax
                                        ? listMerchantData.length
                                        : listMerchantData.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index >= listMerchantData.length) {
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 16.h,
                                            ),
                                            child: Loadings(
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          ),
                                        );
                                      }
                                      final data = listMerchantData[index];
                                      return HomeItem(
                                        merchantData: data,
                                      );
                                    },
                                  );
                                case MerchantResponse.offline:
                                  return const Offlines();
                                case MerchantResponse.failure:
                                  return Failures(
                                    title: state.errorMessage,
                                  );
                              }
                            },
                          );
                        case AttendancesResponse.offline:
                          return Center(
                            child: Text(
                              "Kamu Sedang Offline",
                              style: Texts.medium(),
                            ),
                          );
                        case AttendancesResponse.failure:
                          return Center(
                            child: Text(
                              state.message,
                              style: Texts.medium(),
                            ),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
