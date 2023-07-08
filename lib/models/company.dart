class Company {
  final String name;
  final String imageUrl;

  Company(
      {required this.name, required this.imageUrl});
}

List<Company> companies = [
  Company(name: "Company 1", imageUrl: "assets/images/company/company1.jpg"),
  Company(name: "Company 2", imageUrl: "assets/images/company/comapny.jpg"),
  Company(name: "Company 1", imageUrl: "assets/images/company/comapny.jpg"),
  Company(name: "Company 2", imageUrl: "assets/images/company/comapny.jpg"),
  Company(name: "Company 1", imageUrl: "assets/images/company/comapny.jpg"),
  Company(name: "Company 2", imageUrl: "assets/images/company/comapny.jpg"),
  // Add more company instances as needed
];
