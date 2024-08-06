import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fetcher/src/submit_builder.dart';
import 'package:fetcher/src/utils/utils.dart';
import 'widgets/clear_focus_background.dart';

/// Wrapper around [SubmitBuilder] adapted for form validation.
class AsyncForm<T> extends StatelessWidget {
  const AsyncForm({super.key, required this.builder, this.onValidated, this.onSuccess});

  /// Child widget builder that provide a [validate] callback to be called when needed.
  final SubmitChildBuilder<T> builder;

  /// Called when the form has been validated
  final AsyncValueGetter<T>? onValidated;

  /// Called when the [onValidated] task has successfully completed
  final AsyncValueSetter<T>? onSuccess;

  @override
  Widget build(BuildContext context) {
    return ClearFocusBackground(
      child: Form(
        child: Builder(
          builder: (context) {
            return SubmitBuilder<T>(
              task: onValidated,
              onSuccess: onSuccess,
              builder: (context, runTask) => builder(context, ([task]) => context.validateForm(
                onSuccess: () => runTask(task),
              )),
            );
          },
        ),
      ),
    );
  }
}
