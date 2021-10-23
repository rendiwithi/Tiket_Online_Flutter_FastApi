String changeDate(String date) {
  String monthsInYear(String month) {
    if (month == "01") {
      return "Januari";
    } else if (month == "02") {
      return "Februari";
    } else if (month == "03") {
      return "Maret";
    } else if (month == "04") {
      return "April";
    } else if (month == "05") {
      return "Mei";
    } else if (month == "06") {
      return "Juni";
    } else if (month == "07") {
      return "Juli";
    } else if (month == "08") {
      return "Agustus";
    } else if (month == "09") {
      return "September";
    } else if (month == "10") {
      return "Oktober";
    } else if (month == "11") {
      return "November";
    } else if (month == "12") {
      return "Desember";
    } else {
      return month;
    }
  }
  String a = date;
  String b = a.substring(0, 10);
  var c = b.split('-');
  c[1] = monthsInYear(c[1]);
  String temp = c[0];
  c[0] = c[2];
  c[2] = temp;
  c.join(" ");
  String d = c.join(" ");
  return d;
}