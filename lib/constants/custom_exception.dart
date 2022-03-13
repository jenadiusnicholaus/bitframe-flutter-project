class CustomException {
  String _message;
  CustomException([this._message]);
  String toString() {
    return '$_message';
  }
}
