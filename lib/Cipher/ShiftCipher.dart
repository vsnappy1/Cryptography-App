
import 'TextDictionary.dart';

class ShiftCipher {
  String cipherName;
  int key;
  TextDictionary dictionary;

  ShiftCipher({this.key}) {
    cipherName = "Shift Cipher";
    dictionary = new TextDictionary();
  }

  String encrypt(String plainText) {
    plainText = plainText.toUpperCase();
    String cipherText = "";
    int c;

    for (int i = 0; i < plainText.length; i++) {

      if(plainText[i] == " "){
        cipherText += " ";
        continue;
      }
      c = dictionary.getCode(plainText[i]);
      if (c != -1) {
        c = c + key;
        c = c % 26;
        cipherText += dictionary.getCharacter(c);
      }
      else {
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
    int c;

    for (int i = 0; i < cipherText.length; i++) {

      if(cipherText[i] == " "){
        plainText += " ";
        continue;
      }

      c = dictionary.getCode(cipherText[i]) - key;

      if(c < 0 || c >= 26){
        c = getAbsoluteValue(c - key)%26;
      }

      plainText += dictionary.getCharacter(c );
    }
    return plainText;
  }
}
