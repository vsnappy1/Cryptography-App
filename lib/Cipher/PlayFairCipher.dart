

class PlayFairCipher{
  String cipherName, key, notThis;
  List<List<String>> list;
  int keyLetter;

  PlayFairCipher({this.key}) {
    cipherName = "Play Fair Cipher";
    notThis = "J";      ///*********************  NO J's  *********************
    keyLetter = 0;
    key = key.toUpperCase();
    print(key);
    list = new List(5);
    fillTheList();
  }

  String removeSpaces(String plainText){
    String temp = "";
    for(int i = 0; i < plainText.length; i++){
      if(plainText[i] != " ")
        temp += plainText[i];
    }
    return temp;
  }

  String encrypt(String plainText) {
    String cipherText = "";
    plainText = plainText.toUpperCase();
    RowColumn rowColumn1, rowColumn2;

    plainText = removeSpaces(plainText);

    if(plainText.length%2 == 1){
      plainText += "X";
    }

    for(int i = 0; i < plainText.length; i++) {


      rowColumn1 = getRowColumn(plainText[i]);
      rowColumn2 = getRowColumn(plainText[++i]);

      // If in same row
      if (rowColumn1.row == rowColumn2.row) {
        // Select row and then select element one step right
        cipherText += list[rowColumn1.row][(rowColumn1.column + 1) % 5];
        cipherText += list[rowColumn2.row][(rowColumn2.column + 1) % 5];
      }
      // If in same Column
      else if (rowColumn1.column == rowColumn2.column) {
        // Select row and then select element one step down
        cipherText += list[(rowColumn1.row + 1) % 5][(rowColumn1.column)];
        cipherText += list[(rowColumn2.row + 1) % 5][(rowColumn2.column)];
      }
      else{
        cipherText += list[rowColumn1.row][rowColumn2.column];
        cipherText += list[rowColumn2.row][rowColumn1.column];
      }
    }
    return cipherText;
  }

  String decrypt(String cipherText) {
    String plainText = "";
    cipherText = cipherText.toUpperCase();

    RowColumn rowColumn1, rowColumn2;

    if(cipherText.length%2 == 1){
      cipherText += "X";
    }

    for(int i = 0; i < cipherText.length; i++) {
      if(cipherText[i] == " "){
        plainText += " ";
        continue;
      }

      rowColumn1 = getRowColumn(cipherText[i]);
      rowColumn2 = getRowColumn(cipherText[++i]);

      // If in same row
      if (rowColumn1.row == rowColumn2.row) {
        // Select row and then select element one step right
        plainText += list[rowColumn1.row][(rowColumn1.column - 1) % 5];
        plainText += list[rowColumn2.row][(rowColumn2.column - 1) % 5];
      }
      // If in same Column
      else if (rowColumn1.column == rowColumn2.column) {
        // Select row and then select element one step down
        plainText += list[(rowColumn1.row - 1) % 5][(rowColumn1.column)];
        plainText += list[(rowColumn2.row - 1) % 5][(rowColumn2.column)];
      }
      else{
        plainText += list[rowColumn1.row][rowColumn2.column];
        plainText += list[rowColumn2.row][rowColumn1.column];
      }
    }
    return plainText;
  }

  void fillTheList(){
    List<String> temp;
    int ascii = 65;
    keyLetter = 0;
    for(int i = 0; i < 5; i++){
      temp = <String>[];
      for(int j = 0; j < 5; j++){

        if(keyLetter < key.length){
          temp.add(nextListElementKey(key[keyLetter]));
        }else{
          temp.add(nextListElement(ascii));
          ascii++;
        }list[i] = temp;
      }
      print(temp);
    }
  }

  String nextListElement(int ascii){
    if(ascii < 91) {
      String char = String.fromCharCode(ascii);
      if (!checkIfExistInList(char) && char != notThis) {
        return char;
      }
      else {
        return nextListElement(++ascii);
      }
    }
    return null;
  }

  String nextListElementKey(String char){
    if(keyLetter < key.length) {
      if (!checkIfExistInList(char) && char != notThis) {
        keyLetter++;
        return char;
      }
      else {
        return nextListElementKey(key[++keyLetter]);
      }
    }
    return null;
  }

  bool checkIfExistInList(String char){
    List<String> temp;

    for (int i = 0; i < list.length; i++) {
      temp = list.elementAt(i);
      if (temp != null && temp.contains(char)) {
        return true;
      }
    }

    return false;
  }

  RowColumn getRowColumn(String plainText) {
    for(int i = 0; i < 5; i++){
      if(list[i].contains(plainText)){
        int j = list[i].indexOf(plainText);
        return new RowColumn(row: i,column: j);
      }
    }

    return null;
  }

}

class RowColumn{
  int row, column;
  RowColumn({this.row, this.column});
}