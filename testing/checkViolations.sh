#!/bin/bash
terraform plan -out=test.tfplan
terraform show -json ./test.tfplan > ./tfplan.json
gcloud beta terraform vet tfplan.json --policy-library=../ --format=json