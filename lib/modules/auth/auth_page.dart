import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/modules/auth/otp_verification_page.dart';
import 'package:frontend_mobile_flutter/modules/auth/forget_password_page.dart';
import '../../core/widgets/login_header_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthController controller = Get.find<AuthController>();

  bool isLogin = true;
  bool isLoading = false;
  bool _rememberMe = false;
  bool _obscurePasswordLogin = true;
  bool _obscurePasswordReg = true;
  bool _obscureConfirmPassword = true;

  // Login Controllers
  final TextEditingController _emailLogin = TextEditingController();
  final TextEditingController _passwordLogin = TextEditingController();

  // Register Controllers
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _emailReg = TextEditingController();
  final TextEditingController _telp = TextEditingController();
  final TextEditingController _passwordReg = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  String _statusKaryawan = "1";

  // State untuk Password Requirements Indicator
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  //VALIDATOR 
  
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Nama tidak boleh kosong";
    }
    
    // Cek apakah nama mengandung angka
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return "Yakin Sudah memasukkan nama dengan benar?";
    }
    
    // Minimal 2 karakter
    if (value.length < 2) {
      return "Nama minimal 2 karakter";
    }
    
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username tidak boleh kosong";
    }

    if (value.length < 3) {
      return "Username minimal 3 karakter";
    }

    final usernameRegex = RegExp(r'^[a-zA-Z0-9._]+$');
    if (!usernameRegex.hasMatch(value)) {
      return "Username hanya boleh berisi huruf, angka, titik, dan underscore";
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    
    if (!emailRegex.hasMatch(value)) {
      return "Masukkan alamat email yang valid";
    }

    if (_statusKaryawan == "1" && !value.endsWith("@airnavindonesia.co.id")) {
      return "Gunakan email @airnavindonesia.co.id";
    }
    
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Nomor telepon tidak boleh kosong";
    }

    final phoneRegex = RegExp(r'^(?:\+62|0)[0-9]{9,}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Format nomor tidak valid (contoh: 0812xxx atau +62812xxx)";
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }

    final pwdRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$');
    if (!pwdRegex.hasMatch(value)) {
      return "Password harus mengandung huruf besar, angka, simbol, dan minimal 8 karakter";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Konfirmasi password tidak boleh kosong";
    }

    if (value != _passwordReg.text) {
      return "Password tidak sama";
    }

    return null;
  }

  void _checkPasswordRequirements(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
      _hasSpecialChar = RegExp(r'[^A-Za-z0-9]').hasMatch(password);
    });
  }

  bool get _allPasswordRequirementsMet {
    return _hasMinLength && _hasUppercase && _hasNumber && _hasSpecialChar;
  }

  Future<void> _onLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    final result =
        await controller.login(_emailLogin.text.trim(), _passwordLogin.text);
    setState(() => isLoading = false);

    if (result != null) {
      // Get.snackbar("Login Gagal", result,
      //     backgroundColor: Colors.redAccent, colorText: Colors.white);
    } else {
      Get.snackbar("Berhasil", "Login sukses!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed('/main');
    }
  }

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    final result = await controller.register(
      name: _name.text.trim(),
      username: _username.text.trim(),
      email: _emailReg.text.trim(),
      telp: _telp.text.trim(),
      password: _passwordReg.text,
      confirmPassword: _confirmPassword.text,
      statusKaryawan: _statusKaryawan,
    );
    setState(() => isLoading = false);

    if (result != null) {

    } else {
      Get.to(() => OtpVerificationPage(email: _emailReg.text.trim()));
      Get.snackbar("Registrasi Berhasil",
          "Silakan verifikasi email kamu sebelum login.",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  

      @override
      Widget build(BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
              return false;
            }
        
            if (!isLogin) {
              setState(() => isLogin = true);
              return false; 
            }
        
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: isLogin ? _buildLoginView() : _buildRegisterView(),
              ),
            ),
          ),
        );
      }

  // Login View
  Widget _buildLoginView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LoginHeaderWidget(
            imagePath: 'assets/images/building_header.png',
            logoImagePath: 'assets/logo.png',
            logoText: 'AirNav Indonesia',
            useImageLogo: true, 
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header "Masuk"
                  Center(
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Email/Username
                  TextFormField( 
                    controller: _emailLogin,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Email tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField( 
                    controller: _passwordLogin,
                    obscureText: _obscurePasswordLogin,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePasswordLogin
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePasswordLogin = !_obscurePasswordLogin;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 50),

                  // Button Masuk
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1565C0),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Masuk",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Footer Links
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isLogin = false),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Belum punya akun? ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Daftar",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF1565C0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPasswordPage());
                      },
                      child: Text(
                        "lupa kata sandi",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // View Register
  Widget _buildRegisterView() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Buat Akun Baru",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      hintText: "Nama Lengkap",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: _validateName, 
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: _validateUsername, 
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _telp,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Nomor Telepon",
                      hintText: "Nomor Telepon",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.phone_outlined),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: _validatePhone, 
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailReg,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: _validateEmail, 
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordReg,
                    obscureText: _obscurePasswordReg,
                    onChanged: _checkPasswordRequirements,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePasswordReg
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePasswordReg = !_obscurePasswordReg;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: "Konfirmasi Password",
                      hintText: "Konfirmasi Password",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: _validateConfirmPassword, 
                  ),
                  const SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 8),
                          child: Row(
                            children: [
                              if (_allPasswordRequirementsMet)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.check, 
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),

                              Flexible(
                                child: Text(
                                  "Minimal 8 karakter, 1 angka, 1 kapital, 1 simbol",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,  
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                  const SizedBox(height: 20),

                  // Status
                  Row(
                    children: [
                      Text(
                        "Status ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: "1",
                              groupValue: _statusKaryawan,
                              onChanged: (value) {
                                setState(() => _statusKaryawan = value!);
                              },
                              activeColor: const Color(0xFF1565C0),
                            ),
                            const Text("Karyawan", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: "0",
                              groupValue: _statusKaryawan,
                              onChanged: (value) {
                                setState(() => _statusKaryawan = value!);
                              },
                              activeColor: const Color(0xFF1565C0),
                            ),
                            const Text("Non Karyawan", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 24),

                  // Button Daftar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _onRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1565C0),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Daftar",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Footer Link
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          "Sudah punya akun?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => isLogin = true),
                          child: Text(
                            "Masuk di sini",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF1565C0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}