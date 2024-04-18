class StringUtils {
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text.toUpperCase();
  }

  static String formatSales(int sales) {
    String formattedSales = sales.toString();
    RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    formattedSales = formattedSales.replaceAllMapped(
        regExp, (Match match) => '${match[1]},');
    return formattedSales;
  }
}
