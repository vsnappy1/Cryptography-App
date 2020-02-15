
class SubstitutionCipher{
  String cipherName;
  List<SubstitutionTable> substitutionList;

  SubstitutionCipher(){
    cipherName = "Substitution Cipher";
    substitutionList = [];
    fillSubstitutionList();
  }

  String encrypt(String plainText) {
    plainText = plainText.toUpperCase();
    String cipherText = "";

    for (int i = 0; i < plainText.length; i++) {

      cipherText += getLetter2(plainText[i]);

    }
    return cipherText;
  }

  String decrypt(String cipherText) {
    cipherText = cipherText.toUpperCase();
    String plainText = "";

    for (int i = 0; i < cipherText.length; i++) {
        plainText += getLetter1(cipherText[i]);
    }
    return plainText;
  }

  void fillSubstitutionList(){
    substitutionList.add(new SubstitutionTable(letter1: "A",letter2: "M"));
    substitutionList.add(new SubstitutionTable(letter1: "B",letter2: "N"));
    substitutionList.add(new SubstitutionTable(letter1: "C",letter2: "O"));
    substitutionList.add(new SubstitutionTable(letter1: "D",letter2: "P"));
    substitutionList.add(new SubstitutionTable(letter1: "E",letter2: "Q"));
    substitutionList.add(new SubstitutionTable(letter1: "F",letter2: "R"));
    substitutionList.add(new SubstitutionTable(letter1: "G",letter2: "S"));
    substitutionList.add(new SubstitutionTable(letter1: "H",letter2: "T"));
    substitutionList.add(new SubstitutionTable(letter1: "I",letter2: "U"));
    substitutionList.add(new SubstitutionTable(letter1: "J",letter2: "V"));
    substitutionList.add(new SubstitutionTable(letter1: "K",letter2: "W"));
    substitutionList.add(new SubstitutionTable(letter1: "L",letter2: "X"));
    substitutionList.add(new SubstitutionTable(letter1: "M",letter2: "Y"));
    substitutionList.add(new SubstitutionTable(letter1: "N",letter2: "Z"));
    substitutionList.add(new SubstitutionTable(letter1: "O",letter2: "A"));
    substitutionList.add(new SubstitutionTable(letter1: "P",letter2: "B"));
    substitutionList.add(new SubstitutionTable(letter1: "Q",letter2: "C"));
    substitutionList.add(new SubstitutionTable(letter1: "R",letter2: "D"));
    substitutionList.add(new SubstitutionTable(letter1: "S",letter2: "E"));
    substitutionList.add(new SubstitutionTable(letter1: "T",letter2: "F"));
    substitutionList.add(new SubstitutionTable(letter1: "U",letter2: "G"));
    substitutionList.add(new SubstitutionTable(letter1: "V",letter2: "H"));
    substitutionList.add(new SubstitutionTable(letter1: "W",letter2: "I"));
    substitutionList.add(new SubstitutionTable(letter1: "X",letter2: "J"));
    substitutionList.add(new SubstitutionTable(letter1: "Y",letter2: "K"));
    substitutionList.add(new SubstitutionTable(letter1: "Z",letter2: "L"));

  }

  String getLetter2(String letter1){
    for(int i = 0; i < substitutionList.length; i++){
      if(letter1 == substitutionList[i].letter1){
        return substitutionList[i].letter2;
      }
    }
    return letter1;
  }

  String getLetter1(String letter2){
    for(int i = 0; i < substitutionList.length; i++){
      if(letter2 == substitutionList[i].letter2){
        return substitutionList[i].letter1;
      }
    }
    return letter2;
  }
}

class SubstitutionTable{
  String letter1, letter2;
  SubstitutionTable({this.letter1, this.letter2});
}