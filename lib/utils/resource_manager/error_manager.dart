enum ErrorManager with Exception {
  imageEmpty(604, "Image Should not be empty"),
  colorEmpty(604, "Color should not be empty"),
  noInternetConnection(101, "Check your Internet Connetcion"),
  userInvalidResponse(100, "User bad send Response"),
  invalidFormat(102, "Format Invalid"),
  unknown(103, "Unknown Error");

  final int statusCode;
  final String message;
  const ErrorManager(this.statusCode, this.message);
}
