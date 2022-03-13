class ChangePassword {
  String oldPassword;
  String newPassword;
  ChangePassword({
    this.newPassword,
    this.oldPassword,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': oldPassword.trim(),
      'password': newPassword.trim()
    };
    return map;
  }
}
