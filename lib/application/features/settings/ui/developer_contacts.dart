import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/metadata.dart';
import 'package:zawya_islamic/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/images.dart';

class DeveloperContacts extends StatelessWidget {
  const DeveloperContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddingsSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppMetadata.developerName,
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              AppMetadata.developerEmail,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: AppMeasures.paddingsSmall,
            ),
            const _LogoLink(
                label: AppMetadata.iconsLabel,
                
                iconPath: AppResources.githubIcon),
            const _LogoLink(
                label: AppMetadata.iconsLabel,
                iconPath: AppResources.facebookIcon),
            const _LogoLink(
                label: AppMetadata.developerPhone,
                iconPath: AppResources.phoneIcon),
          ],
        ),
      ),
    );
  }
}

class _LogoLink extends StatelessWidget {
  final String label;
  final String iconPath;
  final double size = 30;

  const _LogoLink({
    Key? key,
    required this.label,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaultToleratedImage(imageUrl: iconPath,width: size,height: size,),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textDirection: TextDirection.ltr,
        )
      ],
    );
  }
}

class DeveloperContactDialog extends StatelessWidget {
  const DeveloperContactDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      content: const Padding(
        padding: EdgeInsets.all(AppMeasures.paddingsSmall),
        child: DeveloperContacts(),
      ),
      actions: [
        Center(
          child: ButtonPrimary(
              onPressed: () => NavigationService.pop(),
              text: localizations.confirmLabel),
        )
      ],
    );
  }
}
