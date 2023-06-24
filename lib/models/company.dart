class Company {
  final String name;
  final String imageUrl;

  Company(
      {required this.name, required this.imageUrl});
}

List<Company> companies = [
  Company(name: "Company 1", imageUrl: "assets/images/splashLogo.png"),
  Company(name: "Company 2", imageUrl: "assets/images/splashLogo.png"),
  Company(name: "Company 1", imageUrl: "assets/images/splashLogo.png"),
  Company(name: "Company 2", imageUrl: "assets/images/splashLogo.png"),
  Company(name: "Company 1", imageUrl: "assets/images/splashLogo.png"),
  Company(name: "Company 2", imageUrl: "assets/images/splashLogo.png"),
  // Add more company instances as needed
];
