import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/consultancy.dart';
import 'package:rgp_landing_take_3/software.dart';
import 'package:rgp_landing_take_3/infrastructure.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SliverAppBarExample(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 0, 0)),
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData(
            thumbVisibility: MaterialStateProperty.all<bool>(true),
            thumbColor: MaterialStateProperty.all(Color.fromARGB(
                255, 255, 255, 255)), // Change the thumb color to white
          )),
    );
  }
}

class SliverAppBarExample extends StatefulWidget {
  const SliverAppBarExample({super.key});

  @override
  State<SliverAppBarExample> createState() => _SliverAppBarExampleState();
}

class _SliverAppBarExampleState extends State<SliverAppBarExample> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  double threshold1 = 800.0;
  double threshold2 = 850.0;
  double threshold3 = 1200.0;
  String? newDropdownValue;
  //universal container length...
  double pl1 = 0; //length of page 1.
  double pl2 = 0; //length of page 2.
  double pl3 = 0; //length of page 3.
  double pl4 = 0; //length of page 4.
  double pl5 = 0; //length of page 5.
  double pl6 = 0; //length of page 6.
  // Calculate the container size based on the screen height
  //double containerHeight =0.88 * MediaQuery.of(context).size.height;

  double containerHeight = 0;

  // You can adjust the width as needed, e.g., 100% of screen width
  double containerWidth = 0;
  // Calculate alignment percentages (e.g., 10% from the top and 10% from the right)

  ScrollController _scrollController = ScrollController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController querytypeController = TextEditingController();
  final TextEditingController queryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Uri uri = Uri.parse(
      'https://cosmic-tensor-400614.uc.r.appspot.com/enquiry'); // Replace with your backend URL
// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Background image
        Image.asset(
          'assets/bti5.jpg', // Replace with your image path
          fit: BoxFit.cover, // Adjust the fit as needed
          width: double.infinity,
          height: double.infinity,
        ),

        LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
                controller: _scrollController,
                physics: CustomBouncingScrollPhysics(),

                // or ClampingScrollPhysics() for non-bouncing
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    toolbarHeight:
                        32.0, // Set a custom toolbarHeight to make the app bar thin
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color: Color.fromARGB(255, 0, 0,
                                0), // Solid color for the app bar background
                          ),
                        ),
                        FlexibleSpaceBar(
                            //title: Text(""), // Use the 'title' directly
                            ),
                        Positioned(
                          top: 0.12, // Adjust the top position as needed
                          right: 24.50, // Adjust the right position as needed
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Handle button press

                                  // Scroll to the calculated offset
                                  _scrollController.animateTo(
                                    //_scrollController.offset +
                                    pl1 + pl2 + pl3 + 10,
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'About Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Add some space between the buttons
                              TextButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                child: Text(
                                  '+1 234 456 890',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pinned:
                        true, // The app bar stays at the top while scrolling
                  ),
                  //2nd bar: main title bar...
                  SliverAppBar(
                    backgroundColor: Color.fromARGB(
                        255, 20, 56, 119), // Set the background color here

                    pinned: _pinned,
                    snap: _snap,
                    floating: _floating,
                    toolbarHeight: 70,
                    collapsedHeight: 70.0,
                    expandedHeight: 70.0,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate font size based on the available height
                        double fontSize = constraints.biggest.height *
                            0.25; // Adjust as needed

                        return FlexibleSpaceBar(
                          title: Text(
                            'RGP IT GLOBAL',
                            style: TextStyle(
                              color: Color.fromARGB(231, 255, 255, 255),
                              fontSize:
                                  fontSize, // Use the calculated font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    actions: [
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              containerWidth = constraints.maxWidth;
                              double buttonWidth =
                                  containerWidth >= 450 ? 200.0 : 150.0;
                              //constraints.biggest.width * 0.11;
                              double buttonHeight = constraints.maxHeight * 0.7;

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding:
                                          EdgeInsets.all(0), // Set padding to 0
                                    ),
                                    onPressed: () {
                                      // Handle contact us
                                      _scrollController.animateTo(
                                        pl1 + pl2 + pl3 + pl4 + pl5 + 20,
                                        duration: Duration(milliseconds: 1000),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Container(
                                      width: buttonWidth,
                                      height: buttonHeight,
                                      child: Center(
                                        child: Text(
                                          'Contact Us',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: buttonHeight * 0.1,
                                    width: containerWidth >= 450
                                        ? containerWidth * 0.05
                                        : containerWidth * 0.02,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),

                  //sliver list 1: screen 1: Title Screen...
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            double threshold1 = 800.0;
                            double threshold2 = 850.0;
                            double threshold3 = 1400.0;
                            // Calculate the container size based on the screen height
                            //double containerHeight =0.88 * MediaQuery.of(context).size.height;

                            pl1 = 0.92 * MediaQuery.of(context).size.height;

                            // You can adjust the width as needed, e.g., 100% of screen width
                            double containerWidth = constraints.maxWidth;
                            // Calculate alignment percentages (e.g., 10% from the top and 10% from the right)
                            double headingSize = 50;
                            double textSize = 20;
                            if (containerWidth < threshold3 &&
                                pl1 < threshold2) {
                              //if width of screen is lesser than the threshold...
                              pl1 = 950;
                              headingSize = 50;

                              textSize = 20;
                            } else if (containerWidth >= threshold3 &&
                                pl1 < threshold2) {
                              pl1 = 920;
                              headingSize = containerWidth * 0.04;
                              textSize = containerWidth * 0.018;
                            } else if (containerWidth < threshold3 &&
                                pl1 >= threshold2) {
                              //if width of screen is greater than than the threshold...
                              pl1 = 0.92 * MediaQuery.of(context).size.height;
                              headingSize = 50;

                              textSize = 20;
                            } else if (containerWidth >= threshold3 &&
                                pl1 >= threshold2) {
                              pl1 = 0.92 * MediaQuery.of(context).size.height;
                              headingSize = containerWidth * 0.04;

                              textSize = containerWidth * 0.018;
                            }
                            if (containerWidth < threshold1) {
                              pl1 = 600;
                            }
                            return Stack(
                              children: [
                                // Background image
                                Container(
                                  color: const Color.fromARGB(0, 33, 149,
                                      243), // Replace with your desired background color
                                ),
                                // Content inside the container
                                Container(
                                  width: containerWidth,
                                  height: pl1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Empowering\n',
                                                  style: TextStyle(
                                                      fontSize: headingSize,
                                                      color: Colors.white),
                                                ),
                                                TextSpan(
                                                  text: 'Your',
                                                  style: TextStyle(
                                                      fontSize: headingSize,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text: ' IT Journey',
                                                  style: TextStyle(
                                                      fontSize: headingSize,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                          SizedBox(height: 25),
                                          Text(
                                            'Unleash the Potential of Cutting-Edge\nIT Solutions and Consultation Services',
                                            style: TextStyle(
                                                fontSize: textSize,
                                                color: Colors.white),
                                            textAlign: TextAlign.end,
                                          ),
                                          SizedBox(height: 35),
                                          SizedBox(
                                            height: 50,
                                            width: 200,
                                            child: TextButton(
                                              onPressed: () {
                                                // Handle button press

                                                // Scroll to the calculated offset
                                                _scrollController.animateTo(
                                                  _scrollController.offset +
                                                      pl1 +
                                                      45 -
                                                      _scrollController.offset,
                                                  duration: Duration(
                                                      milliseconds: 1000),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors
                                                    .blue, // Specify the desired background color
                                              ),
                                              child: Text(
                                                'Learn More', // Text displayed on the button
                                                style: TextStyle(
                                                  color: Colors
                                                      .white, // Text color
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 0.05 *
                                            containerWidth, // Adjust the width of the second SizedBox as needed
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      childCount: 1,
                    ),
                  ),

                  //sliver list 2: screen 2: Our Services...
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            double hFactor = 0.15;
                            double wfactor = 0.8;
                            double threshold1 = 760.0;
                            double threshold2 = 850.0;
                            double threshold3 = 1400.0;
                            pl2 = 1.0 * MediaQuery.of(context).size.height;
                            double headingSize = 45;
                            double columnHeaderSize = 20;
                            double textSize = 10;
                            double containerWidth =
                                MediaQuery.of(context).size.width;
                            if (containerWidth < threshold3 &&
                                pl2 < threshold2) {
                              //if width of screen is lesser than the threshold...
                              pl2 = 1210;
                              headingSize = 50;
                              columnHeaderSize = 25;
                              textSize = 19;
                            } else if (containerWidth >= threshold3 &&
                                pl2 < threshold2) {
                              pl2 = 920;
                              headingSize = containerWidth * 0.04;
                              columnHeaderSize = containerWidth * 0.018;
                              textSize = containerWidth * 0.011;
                            } else if (containerWidth < threshold3 &&
                                pl2 >= threshold2) {
                              //if width of screen is greater than than the threshold...
                              pl2 = 1.0 * MediaQuery.of(context).size.height;
                              headingSize = 50;
                              columnHeaderSize = 25;
                              textSize = 19;
                            } else if (containerWidth >= threshold3 &&
                                pl2 >= threshold2) {
                              pl2 = 1.0 * MediaQuery.of(context).size.height;
                              headingSize = containerWidth * 0.04;
                              columnHeaderSize = containerWidth * 0.018;
                              textSize = containerWidth * 0.011;
                            }
                            if (containerWidth < threshold1) {
                              pl2 = 1430;
                            }
                            if (containerWidth < 450.0) {
                              pl2 = 1430;
                              columnHeaderSize = 25;
                              textSize = 19;
                              hFactor = 0.17;
                              wfactor = 0.9;
                            }

                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.asset(
                                    'assets/bti11.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: containerWidth,
                                  height: pl2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      containerWidth < threshold1
                                          ? SizedBox(
                                              height: pl2 * 0.09,
                                              width: containerWidth * 0.16,
                                            )
                                          : SizedBox(
                                              height: pl2 * 0.10,
                                              width: containerWidth * 0.16,
                                            ),
                                      Text(
                                        'Our Services',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: headingSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      containerWidth < threshold1
                                          ? SizedBox(
                                              height: pl2 * 0.03,
                                              width: containerWidth * 0.16,
                                            )
                                          : SizedBox(
                                              height: pl2 * 0.09,
                                              width: containerWidth * 0.16,
                                            ),

                                      //the conditional...
                                      containerWidth < threshold1
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              // Display columns vertically if screen width is below the threshold
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'IT Consultancy',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * hFactor,
                                                      width: containerWidth *
                                                          wfactor,
                                                      child: Text(
                                                        '\n\nAt RGP, we offer expert IT consultations to help you make the most out of your technology investments. We work with you to understand your unique business needs and develop solutions that drive your business forward.\n\n',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          containerWidth * 0.3,
                                                      height:
                                                          pl2 * hFactor * 0.15,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Handle button press
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      consultancy(
                                                                mpl1: pl1,
                                                                mpl2: pl2,
                                                                mpl3: pl3,
                                                                mpl4: pl4,
                                                                mpl5: pl5,
                                                                mpl6: pl6,
                                                                newscrollController:
                                                                    _scrollController,
                                                              ), // Navigate to your new page
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(Size(170,
                                                                      40)), // Set the width and height as needed
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blue), // Set the desired background color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl2 * 0.025,
                                                  width: containerWidth * 0.09,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Software Solutions',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * hFactor,
                                                      width: containerWidth *
                                                          wfactor,
                                                      child: Text(
                                                        '\n\nOur team of skilled developers can create custom software solutions tailored to your business needs. Whether you need a new website, mobile app, or enterprise software, we have the expertise to bring your vision to life.\n\n',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          containerWidth * 0.3,
                                                      height:
                                                          pl2 * hFactor * 0.15,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Handle button press
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      software(
                                                                mpl1: pl1,
                                                                mpl2: pl2,
                                                                mpl3: pl3,
                                                                mpl4: pl4,
                                                                mpl5: pl5,
                                                                mpl6: pl6,
                                                                newscrollController:
                                                                    _scrollController,
                                                              ), // Navigate to your new page
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(Size(170,
                                                                      40)), // Set the width and height as needed
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blue), // Set the desired background color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl2 * 0.025,
                                                  width: containerWidth * 0.05,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Infrastructure Management',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * hFactor,
                                                      width: containerWidth *
                                                          wfactor,
                                                      child: Text(
                                                        '\n\nLet us take care of your IT infrastructure so you can focus on growing your business. Our managed IT services include network setup and maintenance, software updates, cybersecurity, and more.\n\n\n',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.02,
                                                      width:
                                                          containerWidth * 0.02,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          containerWidth * 0.3,
                                                      height:
                                                          pl2 * hFactor * 0.15,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Handle button press
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  infrastructure(
                                                                mpl1: pl1,
                                                                mpl2: pl2,
                                                                mpl3: pl3,
                                                                mpl4: pl4,
                                                                mpl5: pl5,
                                                                mpl6: pl6,
                                                                newscrollController:
                                                                    _scrollController,
                                                              ), // Navigate to your new page
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(Size(170,
                                                                      40)), // Set the width and height as needed
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blue), // Set the desired background color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: pl2 * 0.12,
                                                      width:
                                                          containerWidth * 0.21,
                                                      child: Text(
                                                        'IT Consultancy',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              columnHeaderSize,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.4,
                                                      width:
                                                          containerWidth * 0.2,
                                                      child: Text(
                                                        '\n\nAt RGP, we offer expert IT consultations to help you make the most out of your technology investments. We work with you to understand your unique business needs and develop solutions that drive your business forward.\n\n',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          containerWidth * 0.15,
                                                      height: pl2 == 1210
                                                          ? pl2 * 0.04
                                                          : pl2 * 0.06,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Handle button press
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      consultancy(
                                                                mpl1: pl1,
                                                                mpl2: pl2,
                                                                mpl3: pl3,
                                                                mpl4: pl4,
                                                                mpl5: pl5,
                                                                mpl6: pl6,
                                                                newscrollController:
                                                                    _scrollController,
                                                              ), // Navigate to your new page
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(Size(170,
                                                                      40)), // Set the width and height as needed
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blue), // Set the desired background color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height:
                                                //       containerHeight * 0.02,
                                                //   width: containerWidth * 0.04,
                                                // ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: pl2 * 0.12,
                                                      width:
                                                          containerWidth * 0.21,
                                                      child: Text(
                                                        'Software Solutions',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              columnHeaderSize,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.4,
                                                      width:
                                                          containerWidth * 0.2,
                                                      child: Text(
                                                        '\n\nOur team of skilled developers can create custom software solutions tailored to your business needs. Whether you need a new website, mobile app, or enterprise software, we have the expertise to bring your vision to life.\n\n',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          containerWidth * 0.15,
                                                      height: pl2 * 0.06,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Handle button press
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      software(
                                                                mpl1: pl1,
                                                                mpl2: pl2,
                                                                mpl3: pl3,
                                                                mpl4: pl4,
                                                                mpl5: pl5,
                                                                mpl6: pl6,
                                                                newscrollController:
                                                                    _scrollController,
                                                              ), // Navigate to your new page
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(Size(170,
                                                                      40)), // Set the width and height as needed
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blue), // Set the desired background color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height:
                                                //       containerHeight * 0.02,
                                                //   width: containerWidth * 0.01,
                                                // ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: pl2 * 0.12,
                                                      width:
                                                          containerWidth * 0.21,
                                                      child: Text(
                                                        'Infrastructure Management',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              columnHeaderSize,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.4,
                                                      width:
                                                          containerWidth * 0.2,
                                                      child: Text(
                                                        '\n\nLet us take care of your IT infrastructure so you can focus on growing your business. Our managed IT services include network setup and maintenance, software updates, cybersecurity, and more.\n\n\n',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl2 * 0.02,
                                                      width:
                                                          containerWidth * 0.02,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          containerWidth * 0.15,
                                                      height: pl2 * 0.06,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Handle button press
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  infrastructure(
                                                                mpl1: pl1,
                                                                mpl2: pl2,
                                                                mpl3: pl3,
                                                                mpl4: pl4,
                                                                mpl5: pl5,
                                                                mpl6: pl6,
                                                                newscrollController:
                                                                    _scrollController,
                                                              ), // Navigate to your new page
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(Size(170,
                                                                      40)), // Set the width and height as needed
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blue), // Set the desired background color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      childCount: 1,
                    ),
                  ),

//sliver list 3: screen 3: Why Choose Us...
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            // Get the screen's width and height using MediaQuery
                            //double containerHeight = 0.7 * MediaQuery.of(context).size.height;
                            double threshold1 = 700.0;
                            double threshold2 = 850.0;
                            double threshold3 = 1400.0;
                            pl3 = 0.7 * MediaQuery.of(context).size.height;
                            double headingSize = 45;
                            double columnHeaderSize = 50;
                            double textSize = 20;
                            double containerWidth =
                                MediaQuery.of(context).size.width;
                            if (containerWidth < threshold3 &&
                                pl3 < threshold2) {
                              //if width of screen is lesser than the threshold...
                              pl3 = 600;
                              headingSize = 45;
                              columnHeaderSize = 60;
                              textSize = 20;
                            } else if (containerWidth >= threshold3 &&
                                pl3 < threshold2) {
                              pl3 = 650;
                              headingSize = containerWidth * 0.025;
                              columnHeaderSize = containerWidth * 0.05;
                              textSize = containerWidth * 0.015;
                            } else if (containerWidth < threshold3 &&
                                pl3 >= threshold2) {
                              //if width of screen is greater than than the threshold...
                              pl3 = 1.0 * MediaQuery.of(context).size.height;
                              headingSize = 50;
                              columnHeaderSize = 50;
                              textSize = 20;
                            } else if (containerWidth >= threshold3 &&
                                pl3 >= threshold2) {
                              pl3 = 0.7 * MediaQuery.of(context).size.height;
                              headingSize = containerWidth * 0.04;
                              columnHeaderSize = containerWidth * 0.018;
                              textSize = containerWidth * 0.011;
                            }
                            if (containerWidth < threshold1) {
                              pl3 = 1200;
                            }
                            if (containerWidth < 450) {
                              pl3 = 1400;
                            }

                            return Stack(
                              children: [
                                // Background image
                                // Positioned.fill(
                                //   child: Image.asset(
                                //     'assets/bti7.jpg', // Replace with your image path
                                //     fit: BoxFit.cover, // Adjust the fit as needed
                                //   ),
                                // ),
                                // Content inside the container
                                Container(
                                  color: const Color.fromARGB(0, 33, 149,
                                      243), // Replace with your desired color
                                  width: containerWidth,
                                  height: pl3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      containerWidth < threshold1
                                          ? SizedBox(
                                              height: pl3 * 0.09,
                                              width: containerWidth * 0.16,
                                            )
                                          : SizedBox(
                                              height: pl3 * 0.12,
                                              width: containerWidth * 0.16,
                                            ),
                                      Text(
                                        'Why Choose Us',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: headingSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      containerWidth < threshold1
                                          ? SizedBox(
                                              height: pl3 * 0.03,
                                              width: containerWidth * 0.16,
                                            )
                                          : SizedBox(
                                              height: pl3 * 0.19,
                                              width: containerWidth * 0.16,
                                            ),
                                      containerWidth < threshold1
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      '5',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.1,
                                                      width:
                                                          containerWidth * 0.3,
                                                      child: Text(
                                                        'Years of Experience',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl3 * 0.02,
                                                  width: containerWidth * 0.02,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '25+',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.1,
                                                      width:
                                                          containerWidth * 0.3,
                                                      child: Text(
                                                        'Expert Consultants',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl3 * 0.02,
                                                  width: containerWidth * 0.02,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '100+',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.1,
                                                      width:
                                                          containerWidth * 0.3,
                                                      child: Text(
                                                        'Projects Completed',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.02,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl3 * 0.02,
                                                  width: containerWidth * 0.02,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '10',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.1,
                                                      width:
                                                          containerWidth * 0.2,
                                                      child: Text(
                                                        'Industry Partners',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.02,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: pl3 * 0.001,
                                                      width:
                                                          containerWidth * 0.02,
                                                    ),
                                                    Text(
                                                      '5',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.3,
                                                      width:
                                                          containerWidth * 0.2,
                                                      child: Text(
                                                        'Years of Experience',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl3 * 0.001,
                                                  width: containerWidth * 0.02,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '25+',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.3,
                                                      width:
                                                          containerWidth * 0.2,
                                                      child: Text(
                                                        'Expert Consultants',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.05,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl3 * 0.02,
                                                  width: containerWidth * 0.02,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '100+',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.3,
                                                      width:
                                                          containerWidth * 0.17,
                                                      child: Text(
                                                        'Projects Completed',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.02,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: pl3 * 0.02,
                                                  width: containerWidth * 0.02,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '10',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            columnHeaderSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.3,
                                                      width:
                                                          containerWidth * 0.17,
                                                      child: Text(
                                                        'Industry Partners',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl3 * 0.02,
                                                      width:
                                                          containerWidth * 0.02,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      childCount: 1,
                    ),
                  ),

/*
//sliver list 5. screen 5...
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            // Calculate containerHeight and containerWidth based on constraints
                            pl5 = 0.8 * constraints.maxHeight;
                            double containerWidth = constraints.maxWidth;
                            return Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      'assets/bti12.jpg', // Replace with your background image path
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                              width: containerWidth,
                              height: pl5,
                              child:
                                  Column(
                                    children: [
                                      SizedBox(
                                          height: 30), // Add padding at the top
                                      Text(
                                        'Client Testimonials',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              50, // Adjust font size as needed
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              70), // Add spacing under the Heading
                                      CarouselSlider(
                                        items: [
                                          Image.asset(
                                            'assets/testimonials/tpic1.jpg',
                                            width:
                                                700, // Adjust width as needed
                                            height:
                                                300, // Adjust height as needed
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/testimonials/tpic2.jpg',
                                            width:
                                                700, // Adjust width as needed
                                            height:
                                                300, // Adjust height as needed
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/testimonials/tpic3.jpg',
                                            width:
                                                700, // Adjust width as needed
                                            height:
                                                300, // Adjust height as needed
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/intropics/ipic4.jpg',
                                            width:
                                                700, // Adjust width as needed
                                            height:
                                                300, // Adjust height as needed
                                            fit: BoxFit.cover,
                                          ),
                                          // Add more images as needed
                                        ],
                                        options: CarouselOptions(
                                          height: 700.0,
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _currentIndex = index;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              70), // Add padding at the bottom
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List<Widget>.generate(
                                          4,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _currentIndex = index;
                                              });
                                            },
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      10), // Adjust spacing here
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _currentIndex == index
                                                    ? Colors.blue
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ),
                                ],
                            );
                          },
                        ),
                        SizedBox(height: pl5), // Add padding at the top
                        // Add other widgets below the slideshow as needed
                      ],
                    ),
                  ),
*/

//sliver list 4: screen 4 (new): about us...
                  SliverList(
                    delegate: SliverChildListDelegate([
                      LayoutBuilder(builder: (context, constraints) {
                        double threshold1 = 830.0;
                        double threshold2 = 850.0;
                        double threshold3 = 1400.0;
                        pl4 = 0.92 * MediaQuery.of(context).size.height;
                        double headingSize = 25;
                        double columnHeaderSize = 30;
                        double textSize = 20;
                        double containerWidth =
                            MediaQuery.of(context).size.width;
                        if (containerWidth < threshold3 && pl4 < threshold2) {
                          //if width of screen is lesser than the threshold...
                          pl4 = 1000;
                          headingSize = 25;
                          columnHeaderSize = 30;
                          textSize = 17;
                        } else if (containerWidth >= threshold3 &&
                            pl4 < threshold2) {
                          pl4 = 950;
                          headingSize = containerWidth * 0.020;
                          columnHeaderSize = containerWidth * 0.030;
                          textSize = containerWidth * 0.013;
                        } else if (containerWidth < threshold3 &&
                            pl4 >= threshold2) {
                          //if width of screen is greater than than the threshold...
                          pl4 = 1.0 * MediaQuery.of(context).size.height;
                          headingSize = 25;
                          columnHeaderSize = 30;
                          textSize = 17;
                        } else if (containerWidth >= threshold3 &&
                            pl4 >= threshold2) {
                          pl4 = 0.92 * MediaQuery.of(context).size.height;
                          headingSize = containerWidth * 0.014;
                          columnHeaderSize = containerWidth * 0.015;
                          textSize = containerWidth * 0.011;
                        }
                        if (containerWidth < threshold1) {
                          pl4 = 1100;
                        }
                        if (containerWidth < 450.0) {
                          pl4 = 1300;
                        }
                        return Stack(children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/bti7.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: containerWidth,
                            height: pl4,
                            child: containerWidth < threshold1
                                //about us: column setting...
                                ? Column(
                                    // Add your column content here
                                    // This will be displayed when containerWidth is less than threshold3.
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Add your column items here
                                      // For example, Text, Buttons, etc.
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: pl4 * 0.03,
                                              width: containerWidth * 0.1,
                                            ),
                                            SizedBox(
                                                height: pl4 * 0.04,
                                                width: containerWidth * 0.5,
                                                child: Text(
                                                  'About Us',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: headingSize,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: pl4 * 0.01,
                                              width: containerWidth * 0.1,
                                            ),
                                            SizedBox(
                                                height: pl4 * 0.08,
                                                width: containerWidth * 0.8,
                                                child: Text(
                                                  "Expert IT Solutions for Your Business",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: columnHeaderSize,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: pl4 * 0.015,
                                              width: containerWidth * 0.1,
                                            ),
                                            SizedBox(
                                                height: pl4 * 0.3,
                                                width: containerWidth * 0.7,
                                                child: Text(
                                                  'At RGP IT Global, we are passionate about technology and its transformative power. Our team of expert consultants and developers work together to provide IT solutions that drive your business forward. We understand that every business is unique, which is why we take the time to get to know your business and develop customized solutions that meet your specific needs and provide exponential grouth.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: textSize,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )),
                                          ]),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: pl4 * 0.525,
                                            width: containerWidth,
                                            child: ClipRect(
                                              child: Image.asset(
                                                'assets/aup1.jpg',
                                                fit: BoxFit
                                                    .cover, // You can adjust the BoxFit property according to your needs
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                //about us: row setting...
                                : Row(
                                    // Add your row content here
                                    // This will be displayed when containerWidth is greater than or equal to threshold3.
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                        // Add your row items here
                                        // For example, Text, Buttons, etc.
                                        //  SizedBox(
                                        //     height: containerHeight * 0.15,
                                        //     width: containerWidth * 0.1,
                                        //   ),
                                        SizedBox(
                                          height: pl4 * 0.03,
                                          width: containerWidth * 0.07,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: pl4 * 0.22,
                                              width: containerWidth * 0.1,
                                            ),
                                            SizedBox(
                                                height: pl4 * 0.07,
                                                width: containerWidth * 0.3,
                                                child: Text(
                                                  'About Us',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: headingSize,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: pl4 * 0.01,
                                              width: containerWidth * 0.01,
                                            ),
                                            SizedBox(
                                                height: pl4 * 0.15,
                                                width: containerWidth * 0.3,
                                                child: Text(
                                                  "Expert IT Solutions for Your Business",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: columnHeaderSize,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )),
                                            // SizedBox(
                                            //   height: containerHeight * 0.03,
                                            //   width: containerWidth * 0.01,
                                            // ),
                                            SizedBox(
                                                height: pl4 * 0.4,
                                                width: containerWidth * 0.26,
                                                child: Text(
                                                  'At RGP IT Global, we are passionate about technology and its transformative power. Our team of expert consultants and developers work together to provide IT solutions that drive your business forward. We understand that every business is unique, which is why we take the time to get to know your business and develop customized solutions that meet your specific needs and provide exponential grouth.',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: textSize,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        //
                                        //
                                        //
                                        SizedBox(
                                          height: pl4 * 0.03,
                                          width: containerWidth * 0.18,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: pl4,
                                              width: containerWidth * 0.45,
                                              child: ClipRect(
                                                child: Image.asset(
                                                  'assets/aup1.jpg',
                                                  fit: BoxFit
                                                      .cover, // You can adjust the BoxFit property according to your needs
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                          ),
                        ]);
                      }),
                    ]),
                  ),

//sliver list 6: screen 6: contact us...
                  SliverList(
                    delegate: SliverChildListDelegate([
                      LayoutBuilder(builder: (context, constraints) {
                        String dropdownValue =
                            ' - empty - '; // Variable to store the selected value
                        double threshold1 = 830.0;
                        double threshold2 = 850.0;
                        double threshold3 = 1400.0;
                        double pl6 = 0.92 * MediaQuery.of(context).size.height;
                        double headingSize = 25;
                        double columnHeaderSize = 30;
                        double textSize = 20;
                        double containerWidth =
                            MediaQuery.of(context).size.width;
                        if (containerWidth < threshold3 && pl6 < threshold2) {
                          //if width of screen is lesser than the threshold...
                          pl6 = 1000;
                          headingSize = 25;
                          columnHeaderSize = 30;
                          textSize = 17;
                        } else if (containerWidth >= threshold3 &&
                            pl6 < threshold2) {
                          pl6 = 950;
                          headingSize = containerWidth * 0.020;
                          columnHeaderSize = containerWidth * 0.030;
                          textSize = containerWidth * 0.013;
                        } else if (containerWidth < threshold3 &&
                            pl6 >= threshold2) {
                          //if width of screen is greater than than the threshold...
                          pl6 = 1.0 * MediaQuery.of(context).size.height;
                          headingSize = 25;
                          columnHeaderSize = 30;
                          textSize = 17;
                        } else if (containerWidth >= threshold3 &&
                            pl6 >= threshold2) {
                          pl6 = 0.92 * MediaQuery.of(context).size.height;
                          headingSize = containerWidth * 0.014;
                          columnHeaderSize = containerWidth * 0.015;
                          textSize = containerWidth * 0.011;
                        }
                        if (containerWidth < threshold1) {
                          pl6 = 1100;
                        }
                        if (containerWidth < 450.0) {
                          pl6 = 1300;
                        }
                        return Stack(children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/bti7.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: containerWidth,
                            height: pl6,
                            child: containerWidth < threshold1
                                ? Column(
                                    // Add your column content here
                                    // This will be displayed when containerWidth is less than threshold3.
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Add your column items here
                                      // For example, Text, Buttons, etc.
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: pl6 * 0.03,
                                            width: containerWidth * 0.1,
                                          ),
                                          SizedBox(
                                              height: pl6 * 0.04,
                                              width: containerWidth * 0.5,
                                              child: Text(
                                                'Contact Us',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: headingSize,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )),
                                          SizedBox(
                                            height: pl6 * 0.01,
                                            width: containerWidth * 0.1,
                                          ),
                                          SizedBox(
                                              height: pl6 * 0.045,
                                              width: containerWidth * 0.8,
                                              child: Text(
                                                "Let's Work Together!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: columnHeaderSize,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )),
                                          SizedBox(
                                            height: pl6 * 0.015,
                                            width: containerWidth * 0.1,
                                          ),
                                          SizedBox(
                                              height: pl6 * 0.17,
                                              width: containerWidth * 0.6,
                                              child: Text(
                                                'Get in touch with us to discuss how we can help your business with our expert IT solutions. You can reach us at info@rgpitglobal.com or by phone at 123-456-7890.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: textSize,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: containerHeight * 0.01,
                                      //   width: containerWidth * 0.1,
                                      // ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  //for facebook...
                                                  GestureDetector(
                                                    onTap: () async {
                                                      const facebookURL =
                                                          'https://www.facebook.com/groups/fluttercommunity/'; // Replace with the desired Instagram URL

                                                      if (await canLaunchUrl(
                                                          Uri.parse(
                                                              facebookURL))) {
                                                        await launchUrl(
                                                            Uri.parse(
                                                                facebookURL));
                                                      } else {
                                                        throw 'Could not launch $facebookURL';
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      'assets/logos/facebook_logo.png', // Replace with your image path
                                                      width:
                                                          55, // Set the desired width
                                                      height:
                                                          55, // Set the desired height
                                                    ),
                                                  ),

                                                  //for linkedin...

                                                  GestureDetector(
                                                    onTap: () async {
                                                      const linkedinURL =
                                                          'https://www.facebook.com/groups/fluttercommunity/'; // Replace with the desired Instagram URL

                                                      if (await canLaunchUrl(
                                                          Uri.parse(
                                                              linkedinURL))) {
                                                        await launchUrl(
                                                            Uri.parse(
                                                                linkedinURL));
                                                      } else {
                                                        throw 'Could not launch $linkedinURL';
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      'assets/logos/linkedin_logo.png', // Replace with your image path
                                                      width:
                                                          50, // Set the desired width
                                                      height:
                                                          50, // Set the desired height
                                                    ),
                                                  ),

                                                  //for twitter
                                                  GestureDetector(
                                                    onTap: () async {
                                                      const twitterURL =
                                                          'https://www.facebook.com/groups/fluttercommunity/'; // Replace with the desired Instagram URL

                                                      if (await canLaunchUrl(
                                                          Uri.parse(
                                                              twitterURL))) {
                                                        await launchUrl(
                                                            Uri.parse(
                                                                twitterURL));
                                                      } else {
                                                        throw 'Could not launch $twitterURL';
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      'assets/logos/twitter_logo.png', // Replace with your image path
                                                      width:
                                                          65, // Set the desired width
                                                      height:
                                                          65, // Set the desired height
                                                    ),
                                                  )
                                                ]),
                                          ]),
                                      SizedBox(
                                        height: pl6 * 0.03,
                                        width: containerWidth * 0.1,
                                      ),
                                      Column(
                                        // Add your column content here
                                        children: [
                                          Container(
                                            height: pl6 * 0.6,
                                            width: containerWidth * 0.9,
                                            child:
                                                // Form starts here
                                                Form(
                                              key: _formKey,
                                              // Add your form fields inside the Form widget
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width: containerWidth * 0.4,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        firstNameController, // Use the correct controller
                                                    decoration: InputDecoration(
                                                      labelText: 'First Name',
                                                      labelStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintText:
                                                          'Enter your first name...',
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              159,
                                                              165,
                                                              170)), // Change hint text color
                                                      hoverColor:
                                                          Color.fromARGB(255,
                                                              255, 255, 255),

                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                      // Add more decoration options as needed
                                                    ),
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      //fontSize: 12.0
                                                    ), // Change text color of input
                                                  ),

                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        lastNameController, // Use the correct controller
                                                    decoration: InputDecoration(
                                                        labelText: 'Last Name',
                                                        labelStyle: TextStyle(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change label text color
                                                        hintText:
                                                            'Enter your last name...',
                                                        hintStyle: TextStyle(
                                                            color: Color.fromARGB(
                                                                255,
                                                                195,
                                                                201,
                                                                206)), // Change hint text color
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255)), // Change border color
                                                        ),
                                                        hoverColor:
                                                            Colors.white,
                                                        fillColor: Colors.white
                                                        // Add more decoration options as needed
                                                        ),
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      //fontSize: 12.0
                                                    ), // Change text color of input
                                                  ),

                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),

                                                  TextFormField(
                                                    controller:
                                                        emailController, // Use the correct controller
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Email Address',
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                      hoverColor: Colors.white,
                                                      fillColor: Colors.white,
                                                      // Add more decoration options as needed
                                                    ),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)), // Change text color of input
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter an email address';
                                                      }
                                                      // Use a regular expression to validate the email format
                                                      // You can use a more advanced email validation regex if needed
                                                      if (!RegExp(
                                                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                                          .hasMatch(value)) {
                                                        return 'Please enter a valid email address';
                                                      }
                                                      return null; // Return null to indicate no error
                                                    },
                                                  ),

                                                  SizedBox(
                                                    height: pl6 * 0.008,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),

                                                  TextFormField(
                                                    controller:
                                                        phoneController, // Use the correct controller
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: 'Phone Number',
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                      hoverColor: Colors.white,
                                                      fillColor: Colors.white,
                                                      // Add more decoration options as needed
                                                    ),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)), // Change text color of input
                                                  ),

                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        companyController, // Use the correct controller
                                                    decoration: InputDecoration(
                                                      labelText: 'Company Name',
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintText:
                                                          'Enter your company name...',
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                      hoverColor: Colors.white,
                                                      fillColor: Colors.white,
                                                      // Add more decoration options as needed
                                                    ),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)), // Change text color of input
                                                  ),
                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),

                                                  DropdownButtonFormField<
                                                      String>(
                                                    value:
                                                        dropdownValue, // Initially selected value (if any)
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255), // Change the text color here
                                                    ),

                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Query Type', // Label for the dropdown
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                    ),
                                                    items: <String>[
                                                      ' - empty - ',
                                                      'General Enquiry',
                                                      'Consultancy Enquiry',
                                                      'Management Enquiry',
                                                      'Cyber Security Enquiry',
                                                      'Book a Meeting',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            color: Color.fromARGB(
                                                                255,
                                                                0,
                                                                0,
                                                                0), // Change the text color here
                                                          ),
                                                        ), // Display text for each option
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      // Callback when the dropdown value changes
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue!; // Provide a default value if newValue is null

                                                        newDropdownValue =
                                                            dropdownValue;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        queryController, // Use the correct controller
                                                    maxLines:
                                                        2, // To limit query box to 2 lines
                                                    decoration: InputDecoration(
                                                      labelText: 'Query',
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintText:
                                                          'Leave us a message...',
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                      hoverColor: Colors.white,
                                                      fillColor: Colors.white,
                                                      // Add more decoration options as needed
                                                    ),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)), // Change text color of input
                                                  ),
                                                  SizedBox(
                                                    height: pl6 * 0.04,
                                                    width:
                                                        containerWidth * 0.04,
                                                  ), // Add spacing
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      // Handle form submission here
                                                      // You can access the form values using a FormState
                                                      String firstName =
                                                          firstNameController
                                                              .text;
                                                      String lastName =
                                                          lastNameController
                                                              .text;
                                                      String emailAddress =
                                                          emailController.text;
                                                      String phoneNumber =
                                                          phoneController.text;
                                                      String companyName =
                                                          companyController
                                                              .text;
                                                      String? queryType =
                                                          newDropdownValue; // Get the selected value from the dropdown

                                                      String query =
                                                          queryController.text;
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        // Form is valid, you can process the data

                                                        // Create a JSON object
                                                        Map<String, dynamic>
                                                            jsonData = {
                                                          'first_name':
                                                              firstName,
                                                          'last_name': lastName,
                                                          'email': emailAddress,
                                                          'phone_number':
                                                              phoneNumber,
                                                          'company_name':
                                                              companyName,
                                                          'enquiry_type':
                                                              queryType, // Include the selected dropdown value
                                                          'message': query,
                                                        };
                                                        // Convert the JSON object to a JSON string
                                                        String jsonString = json
                                                            .encode(jsonData);
                                                        try {
                                                          // Create an HTTP client (import 'package:http/http.dart' for this)
                                                          final client =
                                                              http.Client();

                                                          // Define the URL of your backend
                                                          final url = Uri.parse(
                                                              'https://cosmic-tensor-400614.uc.r.appspot.com/enquiry');

                                                          // Send a POST request with the JSON data
                                                          final response =
                                                              await client.post(
                                                            url,
                                                            body: jsonString,
                                                          );

                                                          // Check the response status code (200 means success)
                                                          if (response.statusCode ==
                                                                  200 ||
                                                              response.statusCode ==
                                                                  201) {
                                                            final responseBody =
                                                                json.decode(
                                                                    response
                                                                        .body);
                                                            final messageFromBackend =
                                                                responseBody[
                                                                    'message']; // Replace 'message' with the actual key your backend uses
                                                            print(
                                                                'Message from the Team: $messageFromBackend');
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message from the Team'),
                                                                  content: Text(
                                                                      messageFromBackend),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: Text(
                                                                          'Close'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            // You can display the message in your Flutter UI, for example, using a Text widget
                                                            // You might want to use a state management solution like Provider to update your UI
                                                          } else {
                                                            final responseBody =
                                                                json.decode(
                                                                    response
                                                                        .body);
                                                            final messageFromBackend =
                                                                responseBody[
                                                                    'message']; // Replace 'message' with the actual key your backend uses
                                                            print(
                                                                'Failed to submit enquiry. Status code: ${response.statusCode}');
                                                            print(
                                                                'Message from the Team: $messageFromBackend');
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message from the Team'),
                                                                  content: Text(
                                                                      messageFromBackend),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: Text(
                                                                          'Close'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            // You can handle error actions here
                                                          }
                                                        } catch (e) {
                                                          print(
                                                              'Error sending enquiry: $e');
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message from the Team'),
                                                                  content: Text(
                                                                      'error: $e'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: Text(
                                                                          'Close'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              }

                                                              // Handle any exceptions that may occur during the request
                                                              );
                                                        }
                                                        // Print or save the JSON string
                                                        print(jsonString);
                                                        // Clear the form fields if needed
                                                        firstNameController
                                                            .clear();
                                                        lastNameController
                                                            .clear();
                                                        emailController.clear();
                                                        phoneController.clear();
                                                        companyController
                                                            .clear();
                                                        queryController.clear();
                                                        setState(() {
                                                          newDropdownValue =
                                                              '- empty -'; // Reset the dropdown value
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(Size(170,
                                                                  40)), // Set the width and height as needed
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .blue), // Set the desired background color
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Row(
                                    // Add your row content here
                                    // This will be displayed when containerWidth is greater than or equal to threshold3.
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Add your row items here
                                      // For example, Text, Buttons, etc.
                                      //  SizedBox(
                                      //     height: containerHeight * 0.15,
                                      //     width: containerWidth * 0.1,
                                      //   ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: pl6 * 0.25,
                                            width: containerWidth * 0.1,
                                          ),
                                          SizedBox(
                                              height: pl6 * 0.07,
                                              width: containerWidth * 0.3,
                                              child: Text(
                                                'Contact Us',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: headingSize,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )),
                                          SizedBox(
                                            height: pl6 * 0.01,
                                            width: containerWidth * 0.01,
                                          ),
                                          SizedBox(
                                              height: pl6 * 0.15,
                                              width: containerWidth * 0.3,
                                              child: Text(
                                                "Let's Work Together!",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: columnHeaderSize,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )),
                                          // SizedBox(
                                          //   height: containerHeight * 0.03,
                                          //   width: containerWidth * 0.01,
                                          // ),
                                          SizedBox(
                                              height: pl6 * 0.3,
                                              width: containerWidth * 0.24,
                                              child: Text(
                                                'Get in touch with us to discuss how we can help your business with our expert IT solutions.\nYou can reach us at info@rgpitglobal.com or by phone at 123-456-7890.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: textSize,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )),
                                          SizedBox(
                                            height: pl6 * 0.01,
                                            width: containerWidth * 0.1,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                //for facebook...
                                                GestureDetector(
                                                  onTap: () async {
                                                    const facebookURL =
                                                        'https://www.facebook.com/groups/fluttercommunity/'; // Replace with the desired Instagram URL

                                                    if (await canLaunchUrl(
                                                        Uri.parse(
                                                            facebookURL))) {
                                                      await launchUrl(Uri.parse(
                                                          facebookURL));
                                                    } else {
                                                      throw 'Could not launch $facebookURL';
                                                    }
                                                  },
                                                  child: Image.asset(
                                                    'assets/logos/facebook_logo.png', // Replace with your image path
                                                    width:
                                                        55, // Set the desired width
                                                    height:
                                                        55, // Set the desired height
                                                  ),
                                                ),

//for linkedin...

                                                GestureDetector(
                                                  onTap: () async {
                                                    const linkedinURL =
                                                        'https://www.facebook.com/groups/fluttercommunity/'; // Replace with the desired Instagram URL

                                                    if (await canLaunchUrl(
                                                        Uri.parse(
                                                            linkedinURL))) {
                                                      await launchUrl(Uri.parse(
                                                          linkedinURL));
                                                    } else {
                                                      throw 'Could not launch $linkedinURL';
                                                    }
                                                  },
                                                  child: Image.asset(
                                                    'assets/logos/linkedin_logo.png', // Replace with your image path
                                                    width:
                                                        50, // Set the desired width
                                                    height:
                                                        50, // Set the desired height
                                                  ),
                                                ),

//for twitter
                                                GestureDetector(
                                                  onTap: () async {
                                                    const twitterURL =
                                                        'https://www.facebook.com/groups/fluttercommunity/'; // Replace with the desired Instagram URL

                                                    if (await canLaunchUrl(
                                                        Uri.parse(
                                                            twitterURL))) {
                                                      await launchUrl(Uri.parse(
                                                          twitterURL));
                                                    } else {
                                                      throw 'Could not launch $twitterURL';
                                                    }
                                                  },
                                                  child: Image.asset(
                                                    'assets/logos/twitter_logo.png', // Replace with your image path
                                                    width:
                                                        65, // Set the desired width
                                                    height:
                                                        65, // Set the desired height
                                                  ),
                                                )
                                              ]),
                                        ],
                                      ),

                                      SizedBox(
                                        height: pl6 * 0.05,
                                        width: containerWidth * 0.03,
                                      ),
                                      //
                                      //
                                      //

                                      Column(
                                        // Add your column content here
                                        children: [
                                          Container(
                                            height: pl6 * 0.9,
                                            width: containerWidth * 0.4,
                                            child:
                                                // Form starts here
                                                Form(
                                              key: _formKey,
                                              // Add your form fields inside the Form widget
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: pl6 * 0.2,
                                                    width: containerWidth * 0.4,
                                                  ),
                                                  // child:
                                                  Row(children: [
                                                    SizedBox(
                                                      height: pl6 * 0.1,
                                                      width: containerWidth *
                                                          0.195,
                                                      child: TextFormField(
                                                        controller:
                                                            firstNameController, // Use the correct controller
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'First Name',
                                                          labelStyle: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255)), // Change label text color
                                                          hintText:
                                                              'Enter your first name...',
                                                          hintStyle: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255,
                                                                  159,
                                                                  165,
                                                                  170)), // Change hint text color
                                                          hoverColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255),

                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)), // Change border color
                                                          ),
                                                          // Add more decoration options as needed
                                                        ),
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          //fontSize: 12.0
                                                        ), // Change text color of input
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: pl6 * 0.1,
                                                      width:
                                                          containerWidth * 0.01,
                                                    ),
                                                    SizedBox(
                                                      height: pl6 * 0.1,
                                                      width: containerWidth *
                                                          0.195,
                                                      child: TextFormField(
                                                        controller:
                                                            lastNameController, // Use the correct controller
                                                        decoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    'Last Name',
                                                                labelStyle: TextStyle(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)), // Change label text color
                                                                hintText:
                                                                    'Enter your last name...',
                                                                hintStyle: TextStyle(
                                                                    color: Color.fromARGB(
                                                                        255,
                                                                        195,
                                                                        201,
                                                                        206)), // Change hint text color
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)), // Change border color
                                                                ),
                                                                hoverColor:
                                                                    Colors
                                                                        .white,
                                                                fillColor:
                                                                    Colors.white
                                                                // Add more decoration options as needed
                                                                ),
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          //fontSize: 12.0
                                                        ), // Change text color of input
                                                      ),
                                                    ),
                                                  ]),

                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),
                                                  Row(children: [
                                                    SizedBox(
                                                        height: pl6 * 0.1,
                                                        width: containerWidth *
                                                            0.25,
                                                        child: TextFormField(
                                                          controller:
                                                              emailController, // Use the correct controller
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Email Address',
                                                            labelStyle: TextStyle(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)), // Change label text color
                                                            hintStyle: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        195,
                                                                        201,
                                                                        206)), // Change hint text color
                                                            enabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255)), // Change border color
                                                            ),
                                                            hoverColor:
                                                                Colors.white,
                                                            fillColor:
                                                                Colors.white,
                                                            // Add more decoration options as needed
                                                          ),
                                                          style: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255)), // Change text color of input
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please enter an email address';
                                                            }
                                                            // Use a regular expression to validate the email format
                                                            // You can use a more advanced email validation regex if needed
                                                            if (!RegExp(
                                                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                                                .hasMatch(
                                                                    value)) {
                                                              return 'Please enter a valid email address';
                                                            }
                                                            return null; // Return null to indicate no error
                                                          },
                                                        )),
                                                    SizedBox(
                                                      height: pl6 * 0.008,
                                                      width:
                                                          containerWidth * 0.01,
                                                    ),
                                                    SizedBox(
                                                      height: pl6 * 0.1,
                                                      width:
                                                          containerWidth * 0.14,
                                                      child: TextFormField(
                                                        controller:
                                                            phoneController, // Use the correct controller
                                                        keyboardType: TextInputType
                                                            .phone, // Set the keyboard type to phone
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Phone Number',
                                                          labelStyle: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255)), // Change label text color
                                                          hintText:
                                                              '015556464217',
                                                          hintStyle: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255,
                                                                  195,
                                                                  201,
                                                                  206)), // Change hint text color
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)), // Change border color
                                                          ),
                                                          hoverColor:
                                                              Colors.white,
                                                          fillColor:
                                                              Colors.white,
                                                          // Add more decoration options as needed
                                                        ),
                                                        validator: (value) {
                                                          // Define a regular expression pattern for a valid phone number
                                                          // Modify the pattern to match your desired phone number format
                                                          final phoneRegex = RegExp(
                                                              r'^\d{12}$'); // Assumes a 10-digit phone number

                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter a phone number';
                                                          } else if (!phoneRegex
                                                              .hasMatch(
                                                                  value)) {
                                                            return 'Please enter a valid 12-digit phone number';
                                                          }
                                                          return null; // Return null to indicate no error
                                                        },
                                                        style: TextStyle(
                                                            color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change text color of input
                                                      ),
                                                    ),
                                                  ]),
                                                  SizedBox(
                                                    height: pl6 * 0.01,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        companyController, // Use the correct controller
                                                    decoration: InputDecoration(
                                                      labelText: 'Company Name',
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintText:
                                                          'Enter your company name...',
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                      hoverColor: Colors.white,
                                                      fillColor: Colors.white,
                                                      // Add more decoration options as needed
                                                    ),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)), // Change text color of input
                                                  ),
                                                  SizedBox(
                                                    height: pl6 * 0.05,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),

                                                  DropdownButtonFormField<
                                                      String>(
                                                    value:
                                                        dropdownValue, // Initially selected value (if any)
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Query Type', // Label for the dropdown
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                    ),
                                                    items: <String>[
                                                      ' - empty - ',
                                                      'General Enquiry',
                                                      'Consultancy Enquiry',
                                                      'Management Enquiry',
                                                      'Cyber Security Enquiry',
                                                      'Book a Meeting',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      final itemStyle =
                                                          TextStyle(
                                                        color: newDropdownValue ==
                                                                value
                                                            ? Colors
                                                                .white // Change the text color here for the selected item
                                                            : Color.fromARGB(
                                                                255,
                                                                0,
                                                                0,
                                                                0), // Change the text color here for other items
                                                      );
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: itemStyle,
                                                        ), // Display text for each option
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      // Callback when the dropdown value changes
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue!; // Provide a default value if newValue is null

                                                        newDropdownValue =
                                                            dropdownValue;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: pl6 * 0.05,
                                                    width:
                                                        containerWidth * 0.01,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        queryController, // Use the correct controller
                                                    maxLines:
                                                        2, // To limit query box to 2 lines
                                                    decoration: InputDecoration(
                                                      labelText: 'Query',
                                                      labelStyle: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)), // Change label text color
                                                      hintText:
                                                          'Leave us a message...',
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              195,
                                                              201,
                                                              206)), // Change hint text color
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)), // Change border color
                                                      ),
                                                      hoverColor: Colors.white,
                                                      fillColor: Colors.white,
                                                      // Add more decoration options as needed
                                                    ),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)), // Change text color of input
                                                  ),
                                                  SizedBox(
                                                    height: pl6 * 0.04,
                                                    width:
                                                        containerWidth * 0.04,
                                                  ), // Add spacing
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      // Handle form submission here
                                                      // You can access the form values using a FormState
                                                      String firstName =
                                                          firstNameController
                                                              .text;
                                                      String lastName =
                                                          lastNameController
                                                              .text;
                                                      String emailAddress =
                                                          emailController.text;
                                                      String phoneNumber =
                                                          phoneController.text;
                                                      String companyName =
                                                          companyController
                                                              .text;
                                                      String? queryType =
                                                          newDropdownValue; // Get the selected value from the dropdown

                                                      String query =
                                                          queryController.text;
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        // Form is valid, you can process the data

                                                        // Create a JSON object
                                                        Map<String, dynamic>
                                                            jsonData = {
                                                          'first_name':
                                                              firstName,
                                                          'last_name': lastName,
                                                          'email': emailAddress,
                                                          'phone_number':
                                                              phoneNumber,
                                                          'company_name':
                                                              companyName,
                                                          'enquiry_type':
                                                              queryType, // Include the selected dropdown value
                                                          'message': query,
                                                        };
                                                        // Convert the JSON object to a JSON string
                                                        String jsonString = json
                                                            .encode(jsonData);
                                                        try {
                                                          // Create an HTTP client (import 'package:http/http.dart' for this)
                                                          final client =
                                                              http.Client();

                                                          // Define the URL of your backend
                                                          final url = Uri.parse(
                                                              'https://cosmic-tensor-400614.uc.r.appspot.com/enquiry');

                                                          // Send a POST request with the JSON data
                                                          final response =
                                                              await client.post(
                                                            url,
                                                            body: jsonString,
                                                          );

                                                          // Check the response status code (200 means success)
                                                          if (response.statusCode ==
                                                                  200 ||
                                                              response.statusCode ==
                                                                  201) {
                                                            final responseBody =
                                                                json.decode(
                                                                    response
                                                                        .body);
                                                            final messageFromBackend =
                                                                responseBody[
                                                                    'message']; // Replace 'message' with the actual key your backend uses
                                                            print(
                                                                'Message from the Team: $messageFromBackend');
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message from the Team'),
                                                                  content: Text(
                                                                      messageFromBackend),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: Text(
                                                                          'Close'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            // You can display the message in your Flutter UI, for example, using a Text widget
                                                            // You might want to use a state management solution like Provider to update your UI
                                                          } else {
                                                            final responseBody =
                                                                json.decode(
                                                                    response
                                                                        .body);
                                                            final messageFromBackend =
                                                                responseBody[
                                                                    'message']; // Replace 'message' with the actual key your backend uses
                                                            print(
                                                                'Failed to submit enquiry. Status code: ${response.statusCode}');
                                                            print(
                                                                'Message from the Team: $messageFromBackend');
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message from the Team'),
                                                                  content: Text(
                                                                      messageFromBackend),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: Text(
                                                                          'Close'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            // You can handle error actions here
                                                          }
                                                        } catch (e) {
                                                          print(
                                                              'Error sending enquiry: $e');
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message from the Team'),
                                                                  content: Text(
                                                                      'error: $e'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: Text(
                                                                          'Close'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              }

                                                              // Handle any exceptions that may occur during the request
                                                              );
                                                        }
                                                        // Print or save the JSON string
                                                        print(jsonString);
                                                        // Clear the form fields if needed
                                                        firstNameController
                                                            .clear();
                                                        lastNameController
                                                            .clear();
                                                        emailController.clear();
                                                        phoneController.clear();
                                                        companyController
                                                            .clear();
                                                        queryController.clear();
                                                        setState(() {
                                                          newDropdownValue =
                                                              '- empty -'; // Reset the dropdown value
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(Size(170,
                                                                  40)), // Set the width and height as needed
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .blue), // Set the desired background color
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                          ),
                        ]);
                      }),
                    ]),
                  ),
                ]);
          },
        )
      ],
    ));
  }
}

class CustomBouncingScrollPhysics extends BouncingScrollPhysics {
  // Create a custom SpringDescription with modified values
  final SpringDescription customSpring = SpringDescription(
    mass: 2.0, // Adjust the mass as needed
    stiffness: 100.0, // Adjust the stiffness for speed
    damping: 10.0, // Adjust the damping for "bounciness"
  );

  @override
  SpringDescription get spring => customSpring;
}
