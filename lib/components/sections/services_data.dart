class ServiceCardData {
  final String title;
  final String description;
  final String imagePath;
  final String? navigationRoute;

  const ServiceCardData({
    required this.title,
    required this.description,
    required this.imagePath,
    this.navigationRoute,
  });
}

class ServicesData {
  static const List<ServiceCardData> services = [
    ServiceCardData(
      title: 'IT Consultancy',
      description: 'At RGP, we offer expert IT consultations to help you make the most out of your technology investments. We work with you to understand your unique business needs and develop solutions that drive your business forward.',
      imagePath: 'assets/consultancy/cbi1.jpg',
      navigationRoute: '/consultancy',
    ),
    ServiceCardData(
      title: 'Software Solutions',
      description: 'Our team of skilled developers can create custom software solutions tailored to your business needs. Whether you need a new website, mobile app, or enterprise software, we have the expertise to bring your vision to life.',
      imagePath: 'assets/software_solutions/ssbi1.jpg',
      navigationRoute: '/software',
    ),
    ServiceCardData(
      title: 'Infrastructure Management',
      description: 'Let us take care of your IT infrastructure so you can focus on growing your business. Our managed IT services include network setup and maintenance, software updates, cybersecurity, and more.',
      imagePath: 'assets/infrastructure_management/imbi1.jpg',
      navigationRoute: '/infrastructure',
    ),
  ];
}
