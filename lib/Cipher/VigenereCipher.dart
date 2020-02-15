import 'package:crypto_graphy/Cipher/TextDictionary.dart';

class VigenereCipher{
  String cipherName;
  String key;
  TextDictionary dictionary;

  VigenereCipher({this.key}){
    cipherName = "Vigenere Cipher";
    dictionary = new TextDictionary();
    key = key.toUpperCase();
  }

  String encrypt(String plainText){
    plainText = plainText.toUpperCase();
    String cipherText = "";
    int c, key;

    for (int i = 0; i < plainText.length; i++) {
      if(plainText[i] == " "){
        cipherText += " ";
        continue;
      }

      key = dictionary.getCode(this.key[i%this.key.length]);
      c = dictionary.getCode(plainText[i]);
      if(c != -1) {
        c = c + key;
        c = c % 26;
        cipherText += dictionary.getCharacter(c);
      }
      else{
        cipherText += plainText[i];
      }
    }
    return cipherText;
  }
  int getAbsoluteValue(int x){
    if(x < 0)
      return -x;
    else
      return x;
  }

  String decrypt(String cipherText) {
    cipherText = cipherText.toUpperCase();
    String plainText = "";
    int c, key;

    for (int i = 0; i < cipherText.length; i++) {
      if(cipherText[i] == " "){
        plainText += " ";
        continue;
      }
      key = dictionary.getCode(this.key[i%this.key.length]);
      c = dictionary.getCode(cipherText[i]) - key;

      if(c < 0 || c >= 26){
        c = getAbsoluteValue(c - key)%26;
      }

      plainText += dictionary.getCharacter(c );
    }
    return plainText;
  }

}