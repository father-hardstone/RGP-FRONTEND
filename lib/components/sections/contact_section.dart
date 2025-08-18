import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rgp_landing_take_3/config.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';

class ContactSection extends StatefulWidget {
  final ScrollController scrollController;
  final ScrollControllerHelper scrollHelper;

  const ContactSection({
    super.key,
    required this.scrollController,
    required this.scrollHelper,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController querytypeController = TextEditingController();
  final TextEditingController queryController = TextEditingController();

  bool _submitting = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    querytypeController.dispose();
    queryController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    final Uri url = Uri.parse(Config.fullEnquiryUrl);
    final Map<String, dynamic> payload = {
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'company': companyController.text.trim(),
      'queryType': querytypeController.text.trim(),
      'query': queryController.text.trim(),
    };

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      String message;
      if (res.statusCode == 200 || res.statusCode == 201) {
        final body = jsonDecode(res.body);
        message = body['message']?.toString() ?? 'Thanks! We will get back to you soon.';
      } else {
        message = 'Submission failed (${res.statusCode}). Please try again later.';
      }

      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Message from the Team'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            )
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error sending enquiry: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            )
          ],
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = MediaQuery.of(context).size.height;
              final bool isMobile = width < 800;
              final double sectionHeight = isMobile ? height * 0.9 : height * 0.8;

              return Container(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : width * 0.1),
                width: width,
                height: sectionHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: sectionHeight * 0.05),
                    const Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: sectionHeight * 0.04),
                    Form(
                      key: _formKey,
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _input('First name', firstNameController),
                          _input('Last name', lastNameController),
                          _input('Email', emailController, keyboard: TextInputType.emailAddress),
                          _input('Phone', phoneController, keyboard: TextInputType.phone),
                          _input('Company', companyController),
                          _input('Query type', querytypeController),
                          _input('Your message', queryController, maxLines: 4, fullWidth: true),
                          SizedBox(
                            width: isMobile ? double.infinity : 220,
                            height: 44,
                            child: PrimaryButton(
                              text: _submitting ? 'Submitting...' : 'Submit',
                              onPressed: _submitting ? null : _submit,
                              isMobile: isMobile,
                              isLoading: _submitting,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _input(
    String label,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    bool fullWidth = false,
  }) {
    final field = SizedBox(
      width: 320,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
        ),
      ),
    );

    if (fullWidth) {
      return SizedBox(width: 660, child: field);
    }
    return field;
  }
}
