import 'package:flutter/material.dart';

class consultancy extends StatefulWidget {
  final double mpl1;
  final double mpl2;
  final double mpl3;
  final double mpl4;
  final double mpl5;
  final double mpl6;
  final ScrollController newscrollController;
  consultancy({
    required this.mpl1,
    required this.mpl2,
    required this.mpl3,
    required this.mpl4,
    required this.mpl5,
    required this.mpl6,
    required this.newscrollController,
  });
  @override
  _ConsultancyState createState() => _ConsultancyState();
}

class _ConsultancyState extends State<consultancy> {
  final ScrollController _scrollController = ScrollController();
  double pl1 = 0;
  double pl2 = 0;
  double pl3 = 0;
  double pl4 = 0;
  double pl5 = 0;
  double pl6 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IT Consultancy',
        ),
      ),
      body: ListView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          LayoutBuilder(builder: (context, constraints) {
            double threshold1 = 830.0;
            double threshold2 = 850.0;
            double threshold3 = 1400.0;
            pl2 = 1.0 * MediaQuery.of(context).size.height;
            double headingSize = 25;
            double columnHeaderSize = 30;
            double containerWidth = MediaQuery.of(context).size.width;
            if (containerWidth < threshold3 && pl1 < threshold2) {
              //if width of screen is lesser than the threshold...
              pl1 = 950;
              headingSize = 50;
            } else if (containerWidth >= threshold3 && pl1 < threshold2) {
              pl1 = 920;
              headingSize = containerWidth * 0.04;
            } else if (containerWidth < threshold3 && pl1 >= threshold2) {
              //if width of screen is greater than than the threshold...
              pl1 = 0.92 * MediaQuery.of(context).size.height;
              headingSize = 50;
            } else if (containerWidth >= threshold3 && pl1 >= threshold2) {
              pl1 = 0.92 * MediaQuery.of(context).size.height;
              headingSize = containerWidth * 0.04;
            }
            if (containerWidth < threshold1) {
              pl1 = 700;
            }
            if (containerWidth < 450.0) {
              pl4 = 900;
            }
            return Stack(children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/consultancy/cbi1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: containerWidth,
                height: pl1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Your IT\nConsultancy',
                          style: TextStyle(
                              fontSize: headingSize, color: Colors.white),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(height: 20, width: 50),
                        Text(
                          'Navigate Strategically\nExplore Infinitely!',
                          style: TextStyle(
                              fontSize: columnHeaderSize, color: Colors.white),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(height: 30, width: 50),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: TextButton(
                            onPressed: () {
                              _scrollController.animateTo(
                                _scrollController.offset + pl1 - _scrollController.offset,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeInOut,
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors
                                  .blue, // Specify the desired background color
                            ),
                            child: Text(
                              'Read More', // Text displayed on the button
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                        width: 0.05 *
                            containerWidth), // Adjust the width of the second SizedBox as needed
                  ],
                ),
              ),
            ]);
          }),
          LayoutBuilder(builder: (context, constraints) {
            double threshold1 = 830.0;
            double threshold2 = 850.0;
            double threshold3 = 1400.0;
            pl2 =  MediaQuery.of(context).size.height;
            double headingSize = 25;
            double columnHeaderSize = 30;
            double textSize = 20;
            double containerWidth = MediaQuery.of(context).size.width;
            if (containerWidth < threshold3 && pl2 < threshold2) {
              //if width of screen is lesser than the threshold...
              pl2 = 1200;
              headingSize = 25;
              columnHeaderSize = 30;
              textSize = 17;
            } else if (containerWidth >= threshold3 && pl2 < threshold2) {
              pl2 = 1150;
              headingSize = containerWidth * 0.018;
              columnHeaderSize = containerWidth * 0.022;
              textSize = containerWidth * 0.013;
            } else if (containerWidth < threshold3 && pl2 >= threshold2) {
              //if width of screen is greater than than the threshold...
              pl2 = 1.0 * MediaQuery.of(context).size.height;
              headingSize = 25;
              columnHeaderSize = 30;
              textSize = 17;
            } else if (containerWidth >= threshold3 && pl2 >= threshold2) {
              pl2 = 0.92 * MediaQuery.of(context).size.height;
              headingSize = containerWidth * 0.014;
              columnHeaderSize = containerWidth * 0.015;
              textSize = containerWidth * 0.011;
            }
            if (containerWidth < threshold1) {
              pl2 = 1340;
            }
            if (containerWidth < 450.0) {
              pl2 = 1700;
            }
            return Stack(children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/consultancy/cbi2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: containerWidth,
                height: pl2,
                child: containerWidth < threshold1
                    //about us: column setting...
                    ? Column(
                        // Add your column content here
                        // This will be displayed when containerWidth is less than threshold3.
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Add your column items here
                          // For example, Text, Buttons, etc.
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: pl2 * 0.03,
                                  width: containerWidth * 0.1,
                                ),
                                SizedBox(
                                    height: pl2 * 0.05,
                                    width: containerWidth * 0.5,
                                    child: Text(
                                      'Consultancy Expertise',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: headingSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                                SizedBox(
                                  height: pl2 * 0.01,
                                  width: containerWidth * 0.1,
                                ),
                                SizedBox(
                                  
                                    height: pl2 * 0.12,
                                    width: containerWidth * 0.8,
                                    child: Text(
                                      "Professional IT Consultancy\nTailored to Your Business Needs",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: columnHeaderSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                                SizedBox(
                                  height: pl2 * 0.015,
                                  width: containerWidth * 0.1,
                                ),
                                SizedBox(
                                  height: pl2 * 0.27,
                                  width: containerWidth * 0.7,

                                    child: Text(
                                      'We take immense pride in our role as trusted IT consultants, guiding businesses through the complex landscape of technology. With a deep understanding of the ever-evolving IT industry, we leverage our expertise to provide tailored consultancy services. Our dedicated team of consultants collaborates closely with your organization, delving into the core of your business processes and challenges. We identify strategic opportunities where technology can be a catalyst for growth and efficiency.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                                 //   SizedBox(height: 30, width: 50),
                                    SizedBox(
                          height: 50,
                          width: 200,
                          child: TextButton(
                            onPressed: () {
                              // Handle button press
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors
                                  .blue, // Specify the desired background color
                            ),
                            child: Text(
                              'Contact Us', // Text displayed on the button
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                        ),
                              ]),
                              SizedBox(height: 50, width: 50),
                          Column(
                            children: [
                              SizedBox(
                                height: pl2 * 0.43,
                                width: containerWidth,
                                child: ClipRect(
                                  child: Image.asset(
                                    'assets/consultancy/cdp1.jpg',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            // Add your row items here
                            // For example, Text, Buttons, etc.
                            //  SizedBox(
                            //     height: containerHeight * 0.15,
                            //     width: containerWidth * 0.1,
                            //   ),
                            SizedBox(
                              height: pl2 * 0.005,
                              width: containerWidth * 0.07,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: pl2 * 0.15,
                                  width: containerWidth * 0.1,
                                ),
                                SizedBox(
                                    height: pl2 * 0.07,
                                    width: containerWidth * 0.3,
                                    child: Text(
                                      'Consultancy Expertise',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: headingSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                                SizedBox(
                                  height: pl2 * 0.01,
                                  width: containerWidth * 0.01,
                                ),
                                SizedBox(
                                    height: pl2 * 0.15,
                                    width: containerWidth * 0.3,
                                    child: Text(
                                      "Professional IT Consultancy Tailored to Your Business Needs",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: columnHeaderSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),

                                SizedBox(
                                    height: pl2 * 0.4,
                                    width: containerWidth * 0.26,
                                    child: Text(
                                      'We take immense pride in our role as trusted IT consultants, guiding businesses through the complex landscape of technology. With a deep understanding of the ever-evolving IT industry, we leverage our expertise to provide tailored consultancy services. Our dedicated team of consultants collaborates closely with your organization, delving into the core of your business processes and challenges. We identify strategic opportunities where technology can be a catalyst for growth and efficiency.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                                    SizedBox(height: 30, width: 50),
                                    SizedBox(
                          height: 50,
                          width: 200,
                          child: TextButton(
                            onPressed: () {
            // Calculate the total scroll offset
            double totalOffset = widget.mpl1 +
                widget.mpl2 +
                widget.mpl3 +
                widget.mpl4 +
                widget.mpl5 +
                widget.mpl6 +
                45;

            // Access the global ScrollController


            // Scroll to the calculated offset
            widget.newscrollController.animateTo(
              totalOffset,
              duration: Duration(milliseconds: 10),
              curve: Curves.easeInOut,
            );

            // Navigate back to the main page
            Navigator.pop(context);
          },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors
                                  .blue, // Specify the desired background color
                            ),
                            child: Text(
                              'Contact Us', // Text displayed on the button
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                        ),
                              ],
                            ),
                            //
                            //
                            //
                            SizedBox(
                              height: pl2 * 0.03,
                              width: containerWidth * 0.18,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: pl2,
                                  width: containerWidth * 0.45,
                                  child: ClipRect(
                                    child: Image.asset(
                                      'assets/consultancy/cdp1.jpg',
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

        ],
      ),
    );
  }
}
