import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:rgp_landing_take_3/services/contact_service.dart';
import 'package:visibility_detector/visibility_detector.dart'; // add this
class ContactFormSection extends StatefulWidget {
  final double textSize;
  final bool isMobile;

  const ContactFormSection({super.key, required this.textSize, required this.isMobile});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController(text: '+92');
  final _companyController = TextEditingController();
  final _queryController = TextEditingController();

  String _queryType = 'General Inquiry';
  bool _isSubmitting = false;

  static const int _maxQueryLength = 300;
  static const int _maxPhoneLength = 16;
  final List<String> _queryTypes = [
    'General Inquiry', 'IT Solutions', 'Consulting', 'Infrastructure', 'Software Development', 'Support'
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

  String _formatPhoneNumber(String text) {
    String digits = text.replaceAll(RegExp(r'[^\d+]'), '');
    if (!digits.startsWith('+92')) digits = '+92' + digits.replaceAll('+', '');
    String numberPart = digits.substring(3);
    String formatted = numberPart.length > 0 ? numberPart.substring(0, min(3, numberPart.length)) : '';
    if (numberPart.length > 3) formatted += ' ' + numberPart.substring(3, min(7, numberPart.length));
    if (numberPart.length > 7) formatted += ' ' + numberPart.substring(7, min(11, numberPart.length));
    return '+92 ' + formatted;
  }

  void _onPhoneChanged(String value) {
    final formatted = _formatPhoneNumber(value);
    if (formatted != value) {
      _phoneController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      try {
        final result = await ContactService.submitForm(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          company: _companyController.text.trim(),
          queryType: _queryType,
          query: _queryController.text.trim(),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result['message'] ?? (result['success'] == true ? 'Message sent!' : 'Failed to send message')),
          backgroundColor: result['success'] == true ? Colors.green : Colors.red,
        ));

        if (result['success'] == true) {
          _formKey.currentState!.reset();
          _queryType = 'General Inquiry';
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error sending message: ${e.toString()}'),
            backgroundColor: Colors.red,
          ));
        }
      } finally {
        if (mounted) setState(() => _isSubmitting = false);
      }
    }
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white, fontSize: widget.isMobile ? 16 : widget.textSize * 0.8),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: widget.isMobile ? 16 : widget.textSize * 0.8),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: widget.isMobile ? 12 : 16),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white, width: 0.5)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white, width: 0.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.blue, width: 0.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.red, width: 0.5)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.red, width: 0.5)),
      counterStyle: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: widget.isMobile ? 14 : 12),
    );
  }

  Widget _responsiveRow(List<Widget> children) {
    if (widget.isMobile) {
      return Column(
        children: children.map((child) => Padding(padding: const EdgeInsets.only(bottom: 16), child: child)).toList(),
      );
    } else {
      return Row(
        children: children.asMap().entries.map((entry) {
          final int index = entry.key;
          final Widget child = entry.value;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index < children.length - 1 ? 16 : 0),
              child: child,
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int? maxLength,
    String? Function(String?)? validator,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(color: Colors.white, fontSize: widget.isMobile ? 16 : widget.textSize * 0.8),
      decoration: _fieldDecoration(label),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _queryType,
      decoration: _fieldDecoration('Query Type'),
      dropdownColor: const Color(0xFF143877),
      style: TextStyle(color: Colors.white, fontSize: widget.isMobile ? 16 : widget.textSize * 0.8),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
      items: _queryTypes.map((type) => DropdownMenuItem(
        value: type, 
        child: Text(type, style: TextStyle(color: Colors.white, fontSize: widget.isMobile ? 16 : widget.textSize * 0.8))
      )).toList(),
      onChanged: (value) => setState(() => _queryType = value!),
    );
  }

  Widget _buildTextAreaField() {
    return TextFormField(
      controller: _queryController,
      maxLines: 4,
      maxLength: _maxQueryLength,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your query';
        if (value.length > _maxQueryLength) return 'Query cannot exceed $_maxQueryLength characters';
        return null;
      },
      onChanged: (value) => setState(() {}),
      style: TextStyle(color: Colors.white, fontSize: widget.isMobile ? 16 : widget.textSize * 0.8),
      decoration: _fieldDecoration('Query'),
    );
  }

  Widget _buildSubmitButton() {
    return TextButton(
      onPressed: _isSubmitting ? null : _submitForm,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 32 : widget.textSize * 1.8, vertical: widget.isMobile ? 16 : widget.textSize * 0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Colors.white, width: 0.5)),
        backgroundColor: Colors.white.withOpacity(0.1),
      ),
      child: _isSubmitting
          ? Row(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white))),
              const SizedBox(width: 8),
              Text('Sending...', style: TextStyle(color: Colors.white, fontSize: widget.isMobile ? 16 : widget.textSize * 0.6, fontWeight: FontWeight.bold)),
            ])
          : Text('Submit', style: TextStyle(color: Colors.white, fontSize: widget.isMobile ? 16 : widget.textSize * 0.6, fontWeight: FontWeight.bold)),
    );
  }

    bool _formVisible = false;
  List<bool> _fieldVisible = List.filled(6, false); // 7 fields to animate individually

  void _animateFields() {
    for (int i = 0; i < _fieldVisible.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) setState(() => _fieldVisible[i] = true);
      });
    }
  }

  void _hideFields() {
    for (int i = 0; i < _fieldVisible.length; i++) {
      if (mounted) setState(() => _fieldVisible[i] = false);
    }
  }

  Widget _animatedField({required Widget child, required int index}) {
    return AnimatedSlide(
      offset: _fieldVisible[index] ? Offset(0,0) : Offset(0,0.2),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _fieldVisible[index] ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double minHeight = widget.isMobile ? MediaQuery.of(context).size.height * 0.6 
      : max(700, MediaQuery.of(context).size.height * 0.6);

    return VisibilityDetector(
      key: Key('contact_form_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_formVisible) {
          setState(() => _formVisible = true);
          _animateFields();
        } else if (info.visibleFraction < 0.1 && _formVisible) {
          setState(() => _formVisible = false);
          _hideFields();
        }
      },
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 16 : 24, vertical: widget.isMobile ? 32 : 48),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widget.isMobile ? double.infinity : 600),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.12),
                    Colors.white.withOpacity(0.18)
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 20 : 32, vertical: widget.isMobile ? 24 : 32),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _animatedField(
                        index: 0,
                        child: _responsiveRow([
                          _buildTextField(controller: _firstNameController, label: 'First Name', maxLength: 50),
                          _buildTextField(controller: _lastNameController, label: 'Last Name', maxLength: 50),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      _animatedField(
                        index: 1,
                        child: _responsiveRow([
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email Address *',
                            keyboardType: TextInputType.emailAddress,
                            maxLength: 100,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter your email';
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Please enter a valid email';
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number *',
                            keyboardType: TextInputType.number,
                            maxLength: _maxPhoneLength,
                            onChanged: _onPhoneChanged,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter your phone number';
                              if (!RegExp(r'^\+92 \d{3} \d{4} \d{3}$').hasMatch(value)) return 'Please enter a valid phone number (e.g., +92 331 4554 742)';
                              return null;
                            },
                          ),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      _animatedField(index: 2, child: _buildTextField(controller: _companyController, label: 'Company Name', maxLength: 100)),
                      const SizedBox(height: 20),
                      _animatedField(index: 3, child: _buildDropdownField()),
                      const SizedBox(height: 20),
                      _animatedField(index: 4, child: _buildTextAreaField()),
                      const SizedBox(height: 20),
                      _animatedField(index: 5, child: Align(alignment: Alignment.centerRight, child: _buildSubmitButton())),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
