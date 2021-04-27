import 'package:get/get.dart';
import 'package:mymessager/models/UserModel.dart';
import 'package:mymessager/services/AuthenticationController.dart';

class UserController extends GetxController {
  //variable thể hiện cách thức đăng nhập
  bool isSignInWithGoogle = false;
  // Khởi tạo một đối tượng lớp authentication liên kết với user controll.
  final _userAuthentication = Authentication();

//Tạo một obserable User quan sát sự thay đổi thông tin của người dùng.

  Rx<UserModel> _userModel = UserModel().obs;

// Trả vời một User model hiện tại.
  UserModel get userModel => _userModel.value;

// Gán một User Model cho User controller
  set userModel(UserModel value) => this._userModel.value = value;

// Làm sạch User model khi người dùng đăng xuất
  void clear() {
    _userModel.value = UserModel();
  }

// Người dùng đăng nhập bằng email và password
  void userLogin(String email, String password) {
    // Các bước tiền xử lý sẽ thực hiện ở đây.
    _userAuthentication.login(email, password);
  }

// Người dùng thực hiện logout
  Future<void> userLogout() async {
    if (!isSignInWithGoogle) {
      await _userAuthentication.signOut();
    } else {
      await _userAuthentication.SignOutWithGoolgeAccoutn();
      isSignInWithGoogle = false;
    }
  }

// Người dùng đăng ký tài khoản bằng email và password
  void userRegister(String name, String email, String password) {
    //Các bước tiền xử lý
    _userAuthentication.createUser(name, email, password);
  }

// Đăng nhập bằng tài khoản google
  Future<void> userSignInwithGoogle() async {
    await _userAuthentication.signInWithGoogle();
  }
}
