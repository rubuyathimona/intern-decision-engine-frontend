// Function to extract birthdate from a given identification code.
DateTime extractBirthdate(String idCode) {
  // Extracting the century, year, month, and day from the identification code.
  int century = int.parse(idCode.substring(0, 1));
  int year = int.parse(idCode.substring(1, 3));
  int month = int.parse(idCode.substring(3, 5));
  int day = int.parse(idCode.substring(5, 7));

  // Determining the prefix for the birth year based on the century digit.
  // 1-2: 19th century; 3-4: 20th century; 5-6: 21st century
  int prefix;
  if (century <= 2) {
    prefix = 1800;
  } else if (century <= 4) {
    prefix = 1900;
  } else {
    prefix = 2000;
  }

  // Adding the prefix to the extracted birth year to get the full birth year.
  year += prefix;

  return DateTime(year, month, day);
}

// Function to calculate age based on the birthdate extracted from the identification code.
int calculateAge(String idCode) {
  DateTime birthdate = extractBirthdate(idCode);

  DateTime now = DateTime.now();

  int age = now.year - birthdate.year;

  // Adjusting age if the current month and day are before the birth month and day.
  if (now.month < birthdate.month ||
      (now.month == birthdate.month && now.day < birthdate.day)) {
    age--;
  }

  return age;
}

// Function to determine if the age extracted from the identification code is valid for a loan application.
bool isInvalidAgeForGivenId(String idCode) {
  int age = calculateAge(idCode);
  int minEligibleAge = 18;
  int maximumExpectedLifeTime = 85;
  int maximumLoanPeriodInYears = 5;

  // Checking if the age falls below 18 or above 80, which are commonly restricted age limits for loans.
  return age < minEligibleAge || age > (maximumExpectedLifeTime - maximumLoanPeriodInYears);
}
