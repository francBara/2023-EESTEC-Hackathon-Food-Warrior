class AthensStrings {
  static String centsToString(int money) {
    String tmpMoneyString = money.toString();
    if (tmpMoneyString.length == 1) {
      return '0,0$tmpMoneyString';
    }
    else if (tmpMoneyString.length == 2) {
      return '0,$tmpMoneyString';
    }
    String units = tmpMoneyString.substring(0, tmpMoneyString.length - 2);
    String cents = tmpMoneyString.substring(tmpMoneyString.length - 2);
    return '$units,$cents';
  }
}