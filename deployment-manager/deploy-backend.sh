#! /bin/bash
gcloud deployment-manager deployments create terrform-backend --config gcs.yml
# gcloud deployment-manager deployments update terrform-backend --config gcs.yml
# gcloud deployment-manager deployments delete terrform-backend