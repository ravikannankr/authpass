import 'package:authpass/cloud_storage/cloud_storage_provider.dart';
import 'package:authpass/cloud_storage/dropbox/dropbox_provider.dart';
import 'package:authpass/cloud_storage/google_drive/google_drive_provider.dart';
import 'package:authpass/env/_base.dart';

/// manages available cloud storages.
/// BloC is definitely the wrong name here...
class CloudStorageBloc {
  CloudStorageBloc(this.env)
      : _helper = CloudStorageHelper(),
        availableCloudStorage = {} {
    if (env.featureCloudStorage) {
      availableCloudStorage.addAll({
        DropboxProvider(env: env, helper: _helper),
        GoogleDriveProvider(env: env, helper: _helper),
      });
    }
  }

  final Env env;
  final CloudStorageHelper _helper;
  final Set<CloudStorageProvider> availableCloudStorage;

  CloudStorageProvider providerById(String id) =>
      availableCloudStorage.firstWhere((p) => p.id == id, orElse: () => null);
}