import 'package:tokona/packages/packages.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginBloc = locator<LoginBloc>();

  final username = TextEditingController();
  final password = TextEditingController();

  bool obscureText = true;
  bool loading = false;

  @override
  void dispose() {
    loginBloc.close();
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          switch (state.status) {
            case LoginResponse.loading:
              setState(() {
                loading = true;
              });
              break;
            case LoginResponse.success:
              setState(() {
                loading = false;
              });
              Navigations.goRemoveUntil(
                context,
                HomePage.routeName,
              );
              break;
            case LoginResponse.failure:
              setState(() {
                loading = false;
              });
              Toasts.regular(state.message);
              break;
          }
        },
        child: Padding(
          padding: EdgeInsets.all(
            16.r,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ConstantsAssets.imgLogoOrange,
                  width: 70.w,
                  height: 70.h,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Tokona",
                  style: Texts.l(
                    fontSize: 30.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Login dengan akun Anda untuk melanjutkan",
                  style: Texts.medium(),
                ),
                SizedBox(
                  height: 16.h,
                ),
                LoginField(
                  controller: username,
                  label: "Username",
                  hint: "Username",
                  iconPath: ConstantsAssets.icUsername,
                ),
                SizedBox(
                  height: 16.h,
                ),
                LoginField(
                  controller: password,
                  label: "Password",
                  hint: "Password",
                  iconPath: ConstantsAssets.icLock,
                  isPassword: true,
                  obscureText: obscureText,
                  onToggleVisibility: () => setState(() {
                    obscureText = !obscureText;
                  }),
                ),
                SizedBox(
                  height: 16.h,
                ),
                loading
                    ? const Loadings()
                    : SizedBox(
                        width: Sizes.width(context),
                        child: Buttons(
                          onPressed: () {
                            if (username.text.isEmpty ||
                                password.text.isEmpty) {
                              Toasts.regular(
                                "Username dan Password tidak boleh kosong",
                              );
                              return;
                            }
                            loginBloc.add(
                              LoginSubmitted(
                                username: username.text,
                                password: password.text,
                              ),
                            );
                          },
                          backgroundColor: orange,
                          fontColor: white,
                          isBold: true,
                          label: "Login",
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
