import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';

class ContactFormSection extends StatefulWidget {
  final double textSize;
  final bool isMobile;

  const ContactFormSection({
    super.key,
    required this.textSize,
    required this.isMobile,
  });

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  String _queryType = 'General Inquiry';
  final _queryController = TextEditingController();

  final List<String> _queryTypes = [
    'General Inquiry',
    'IT Solutions',
    'Consulting',
    'Infrastructure',
    'Software Development',
    'Support',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      print('Form submitted');
      // You can add your form submission logic here
    }
  }

  @override
  Widget build(BuildContext context) {
                   return Container(
        padding: EdgeInsets.only(
          left: widget.isMobile ? 16.0 : 24.0,
          right: widget.isMobile ? 16.0 : 24.0,
          top: widget.isMobile ? 32.0 : 48.0, // Extra padding above form
          bottom: widget.isMobile ? 16.0 : 24.0,
        ),
       child: Center( // Center the form
        child: ConstrainedBox( // Constrain form width
                     constraints: BoxConstraints(
             maxWidth: widget.isMobile ? double.infinity : 600, // Expanded width on desktop
           ),
                                           child: Container(
                           decoration: BoxDecoration(
                 border: Border.all(color: Colors.white, width: 1),
                 borderRadius: BorderRadius.circular(10),
                 gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: [
                     Colors.white.withOpacity(0.08), // More transparent at top
                     Colors.white.withOpacity(0.12), // Medium opacity in middle
                     Colors.white.withOpacity(0.18), // Denser at bottom
                   ],
                   stops: [0.0, 0.5, 1.0],
                 ),
               ),
                         padding: EdgeInsets.only(
               left: widget.isMobile ? 16.0 : 24.0,
               right: widget.isMobile ? 16.0 : 24.0,
               top: widget.isMobile ? 16.0 : 24.0,
               bottom: widget.isMobile ? 8.0 : 12.0, // Reduced bottom padding
             ),
                                                   child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // Form fields in two columns for larger screens
                  if (!widget.isMobile) ...[
                    // First row: First Name and Last Name
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Second row: Email and Phone
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    // Mobile layout: Single column
                    _buildTextField(
                      controller: _firstNameController,
                      label: 'First Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  ],
                  
                  const SizedBox(height: 16),
                  
                  // Company Name
                  _buildTextField(
                    controller: _companyController,
                    label: 'Company Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your company name';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Query Type Dropdown
                  _buildDropdownField(),
                  
                  const SizedBox(height: 16),
                  
                  // Query Text Area
                  _buildTextAreaField(),
                  
                                     const SizedBox(height: 16),
                  
                  // Submit Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _submitForm,
                                             style: TextButton.styleFrom(
                         padding: EdgeInsets.symmetric(
                           horizontal: widget.isMobile ? 32 : widget.textSize * 1.8,
                           vertical: widget.isMobile ? 16 : widget.textSize * 0.6, // Bigger for mobile
                         ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.white, width: 0.5),
                        ),
                        backgroundColor: Colors.white.withOpacity(0.1), // Blurred background
                      ),
                                               child: Text(
                           'Submit',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: widget.isMobile ? 16 : widget.textSize * 0.6, // Bigger font for mobile
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                 Text(
           label,
           style: TextStyle(
             color: Colors.white,
             fontSize: widget.isMobile ? 14 : widget.textSize * 0.6, // Fixed size for mobile
             fontWeight: FontWeight.w500,
           ),
         ),
        const SizedBox(height: 4), // Minimal spacing
                 TextFormField(
           controller: controller,
           keyboardType: keyboardType,
           validator: validator,
                       style: TextStyle(
              color: Colors.white,
              fontSize: widget.textSize * 0.7, // Smaller input text
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16, 
                vertical: widget.isMobile ? 6 : 8, // Smaller height for mobile/tablet
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Standard button border radius
              borderSide: const BorderSide(color: Colors.white, width: 0.5), // Reduced border width
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 0.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 0.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                 Text(
           'Query Type',
           style: TextStyle(
             color: Colors.white,
             fontSize: widget.isMobile ? 14 : widget.textSize * 0.6, // Fixed size for mobile
             fontWeight: FontWeight.w500,
           ),
         ),
        const SizedBox(height: 4), // Minimal spacing
                 DropdownButtonFormField<String>(
           value: _queryType,
           decoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(
               horizontal: 16, 
               vertical: widget.isMobile ? 6 : 8, // Smaller height for mobile/tablet
             ),
             filled: true,
             fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Standard button border radius
              borderSide: const BorderSide(color: Colors.white, width: 0.5), // Reduced border width
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 0.5),
            ),
          ),
          dropdownColor: const Color(0xFF143877),
          style: TextStyle(
            color: Colors.white,
            fontSize: widget.textSize * 0.7, // Smaller text
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18), // Smaller icon
          items: _queryTypes.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _queryType = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTextAreaField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                 Text(
           'Query',
           style: TextStyle(
             color: Colors.white,
             fontSize: widget.isMobile ? 14 : widget.textSize * 0.6, // Fixed size for mobile
             fontWeight: FontWeight.w500,
           ),
         ),
        const SizedBox(height: 4), // Minimal spacing
        TextFormField(
          controller: _queryController,
          maxLines: 2, // Reduced from 3 to 2
          style: TextStyle(
            color: Colors.white,
            fontSize: widget.textSize * 0.7, // Smaller text
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your query';
            }
            return null;
          },
                     decoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(
               horizontal: 16, 
               vertical: widget.isMobile ? 6 : 8, // Smaller height for mobile/tablet
             ),
             filled: true,
             fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Standard button border radius
              borderSide: const BorderSide(color: Colors.white, width: 0.5), // Reduced border width
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 0.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 0.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
