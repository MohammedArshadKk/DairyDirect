import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptData {
  final key = encrypt.Key.fromUtf8('XkT9vR4zP0QW8f5tJ1L0nS3oG6zU8e2L');
  final iv = encrypt.IV.fromLength(16);

  encryptText(String text) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base16;
  }

  String decryptText(String encryptedText) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypt.Encrypted.fromBase16(encryptedText);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
