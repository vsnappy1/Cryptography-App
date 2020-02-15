

class RailFenceCipher{

  String cipherName;
  int key;
  bool up;

  RailFenceCipher({this.key}) {
    cipherName = "Rail Fence Cipher";
    up = false;
  }

  String encrypt(String plainText) {
    String cipherText = "";
    List<Fence> list = new List();
    int row = key;

    for (int i = 0; i < plainText.length; i++) {

      list.add(new Fence(row: row,character: plainText[i]));
      print('Row: ${list[i].row}  Value: ${list[i].character}');

      if(up){
        row++;
      }
      else{
        row--;
      }

      if(row <= 1 || row == key){
        up = !up;
      }
    }

    row = key;
    for (int i = 0; i < plainText.length; i++) {

      if(list[i].row == row){
        cipherText += list[i].character;
      }

      if(i == plainText.length-1){
        row--;
        i = 0;
        if(row == 0){
          break;
        }
      }
    }

    return cipherText;
  }

  String decrypt(String cipherText) {
    String plainText = "";
    List<Fence> list = new List();
    int row = key, current = 0;

    for (int i = 0; i < cipherText.length; i++) {
      list.add(new Fence(row: row, character: "*"));

      if (up) {
        row++;
      }
      else {
        row--;
      }
      if (row <= 1 || row == key) {
        up = !up;
      }
    }

    row = key;

    for (int i = 0; i < key; i++) {
      for (int j = 0; j < list.length; j++) {
        if (list[j].row == row ) {
          list[j].character = cipherText[current];
          current++;
        }
      }
      row--;
    }

    printList(list);

    row = key;
    up = false;
    for (int i = 0; i < cipherText.length; i++) {
    //  print('Row: ${list[i].row}  Value: ${list[i].character}');
      if (list[i].row == row) {
        plainText += list[i].character;

        if(up){
          row++;
        }
        else{
          row--;
        }
        if(row <= 1 || row == key){
          up = !up;
        }
      }

      if(i == cipherText.length-1){
        break;
      }
    }
    return plainText;
  }

  void printList(List<Fence> list){
    for(int i = 0; i < list.length; i++){
      print('Row: ${list[i].row}  Value: ${list[i].character}');
    }
  }
}


class Fence{
  int row;
  String character;

  Fence({this.row, this.character});
}