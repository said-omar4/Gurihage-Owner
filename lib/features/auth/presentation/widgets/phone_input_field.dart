// TODO Implement this library.
// lib/features/auth/presentation/widgets/phone_input_field.dart
import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const PhoneInputField({
    super.key,
    required this.label,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Country Code
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              child: Row(
                children: [
                  const Text('🇸🇴'),
                  const SizedBox(width: 8),
                  Text(
                    '+252',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Phone Input
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.phone,
                onChanged: onChanged,
                validator: validator,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
