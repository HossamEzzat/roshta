import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:photo_view/photo_view.dart';
import '../data/medication.dart';

class ResultScreen extends StatelessWidget {
  final List<Medication> medications;
  final File image;

  const ResultScreen({
    super.key,
    required this.medications,
    required this.image,
  });

  void _shareResults() {
    final buffer = StringBuffer();
    buffer.writeln('📋 *تحليل روشتة - تطبيق روشتة*\n');

    for (var med in medications) {
      buffer.writeln('💊 *${med.name}*');
      if (med.dosage.isNotEmpty) {
        buffer.writeln('   الجرعة: ${med.dosage}');
      }
      if (med.frequency.isNotEmpty) {
        buffer.writeln('   التكرار: ${med.frequency}');
      }
      if (med.usage.isNotEmpty) {
        buffer.writeln('   الاستخدام: ${med.usage}');
      }
      buffer.writeln('');
    }

    buffer.writeln('تم التحليل بواسطة تطبيق روشتة');
    Share.share(buffer.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الروشتة'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: _shareResults,
          ),
        ],
      ),
      body: Column(
        children: [
          // Image Preview
          SizedBox(
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              child: PhotoView(
                imageProvider: FileImage(image),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3.0,
                initialScale: PhotoViewComputedScale.covered,
                backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ).animate().fadeIn(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: medications.length + 1, // +1 for header
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'الأدوية المكتشفة (${medications.length})',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final medication = medications[index - 1];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.tertiaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.medication_rounded,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiaryContainer,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  medication.name,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          _buildInfoRow(context, 'الجرعة', medication.dosage),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            context,
                            'التكرار',
                            medication.frequency,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(context, 'الاستخدام', medication.usage),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: (100 * index).ms).slideX();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? 'غير متوفر' : value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
