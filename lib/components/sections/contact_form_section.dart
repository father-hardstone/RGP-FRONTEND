import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:rgp_landing_take_3/services/contact_service.dart';

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
  
  bool _isSubmitting = false;
  static const int _maxQueryLength = 300;
  
  // Phone number formatting
  static const String _defaultCountryCode = '+92';
  static const int _maxPhoneLength = 16; // +92 331 4554 742 = 16 characters

  final List<String> _queryTypes = [
    'General Inquiry',
    'IT Solutions',
    'Consulting',
    'Infrastructure',
    'Software Development',
    'Support',
  ];
  
  @override
  void initState() {
    super.initState();
    // Initialize phone number with +92 prefix
    _phoneController.text = _defaultCountryCode;
  }

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
  
  /// Format phone number according to Pakistani format: +92 331 4554 742
  String _formatPhoneNumber(String text) {
    // Remove all non-digit characters except +
    String digits = text.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Ensure it starts with +92
    if (!digits.startsWith('+92')) {
      digits = '+92' + digits.replaceAll('+', '');
    }
    
    // Remove the +92 prefix for formatting
    String numberPart = digits.substring(3);
    
    // Format the number part with spaces
    String formatted = '';
    if (numberPart.length > 0) {
      formatted = numberPart.substring(0, min(3, numberPart.length));
    }
    if (numberPart.length > 3) {
      formatted += ' ' + numberPart.substring(3, min(7, numberPart.length));
    }
    if (numberPart.length > 7) {
      formatted += ' ' + numberPart.substring(7, min(11, numberPart.length));
    }
    
    return '+92 ' + formatted;
  }
  
  /// Handle phone number input changes
  void _onPhoneChanged(String value) {
    final formatted = _formatPhoneNumber(value);
    if (formatted != value) {
      _phoneController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // Call the contact service
        final result = await ContactService.submitForm(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          company: _companyController.text.trim(),
          queryType: _queryType,
          query: _queryController.text.trim(),
        );

        // Show result message
        if (mounted) {
          if (result['success'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['message'] ?? 'Thank you! Your message has been sent successfully.'),
                backgroundColor: Colors.green,
              ),
            );
            
            // Clear form
            _formKey.currentState!.reset();
            _queryType = 'General Inquiry';
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['message'] ?? 'Failed to send message. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error sending message: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.6, // Ensure minimum height is 60% of screen height
      ),
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
              right: widget.isMobile ? 24.0 : 32.0,
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
                            maxLength: 50,
                            validator: null, // Can be empty
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            maxLength: 50,
                            validator: null, // Can be empty
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
                            label: 'Email Address *',
                            keyboardType: TextInputType.emailAddress,
                            maxLength: 100,
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
                            label: 'Phone Number *',
                            keyboardType: TextInputType.number,
                            maxLength: _maxPhoneLength,
                            onChanged: _onPhoneChanged,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              // Validate Pakistani phone format: +92 331 4554 742
                              if (!RegExp(r'^\+92 \d{3} \d{4} \d{3}$').hasMatch(value)) {
                                return 'Please enter a valid phone number (e.g., +92 331 4554 742)';
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
                      maxLength: 50,
                      validator: null, // Can be empty
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      maxLength: 50,
                      validator: null, // Can be empty
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email Address *',
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 100,
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
                      label: 'Phone Number *',
                      keyboardType: TextInputType.number,
                      maxLength: _maxPhoneLength,
                      onChanged: _onPhoneChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        // Validate Pakistani phone format: +92 331 4554 742
                        if (!RegExp(r'^\+92 \d{3} \d{4} \d{3}$').hasMatch(value)) {
                          return 'Please enter a valid phone number (e.g., +92 331 4554 742)';
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
                    maxLength: 100,
                    validator: null, // Can be empty
                  ),
                   
                  const SizedBox(height: 16),
                   
                  // Query Type Dropdown
                  _buildDropdownField(),
                   
                  const SizedBox(height: 16),
                   
                  // Query Text Area with character counter
                  _buildTextAreaField(),
                   
                  const SizedBox(height: 16),
                   
                  // Submit Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _isSubmitting ? null : _submitForm,
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
                      child: _isSubmitting
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Sending...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: widget.isMobile ? 16 : widget.textSize * 0.6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Text(
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
    int? maxLength,
    String? Function(String?)? validator,
    Function(String)? onChanged,
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
          maxLength: maxLength,
          validator: validator,
          onChanged: onChanged,
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
            counterStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Query',
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.isMobile ? 14 : widget.textSize * 0.6, // Fixed size for mobile
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${_queryController.text.length}/$_maxQueryLength',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4), // Minimal spacing
        TextFormField(
          controller: _queryController,
          maxLines: 4,
          maxLength: _maxQueryLength,
          style: TextStyle(
            color: Colors.white,
            fontSize: widget.textSize * 0.7, // Smaller text
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your query';
            }
            if (value.length > _maxQueryLength) {
              return 'Query cannot exceed $_maxQueryLength characters';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              // Trigger rebuild to update character counter
            });
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
            counterStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
