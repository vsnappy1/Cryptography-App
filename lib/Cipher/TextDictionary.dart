

class TextDictionary {
 List<LetterPlusCode> dictionary = <LetterPlusCode>[];

  TextDictionary() {
    for (int i = 0; i < 26; i++) {
      dictionary.add(
          new LetterPlusCode(alphabet: String.fromCharCode(65 + i), code: i));
    }
  }

  int getCode(String alphabet) {
    int index = -1;
    for(int i = 0; i < dictionary.length; i++){
      if(dictionary[i].alphabet == alphabet){
        index = i;
        break;
      }
    }
    return index;
  }

  String getCharacter(int code){
    if(code >= 0){
      return dictionary[code].alphabet;
    }
    else{
      return "!";
    }
  }
}

class LetterPlusCode {
  String alphabet;
  int code;

  LetterPlusCode({this.alphabet, this.code});
}
