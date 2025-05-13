Command to retrieve violations from a Terraform Plan
```bash
terraform plan -out=test.tfplan
terraform show -json ./test.tfplan > ./tfplan.json
gcloud beta terraform vet tfplan.json --policy-library=../ --format=json
```

Command to convert a Terraform Plan to CAI format
```bash
terraform-tools tfplan-to-cai tfplan.json --output-path cai_assets.json --verbosity debug  --project dbs-validator-dev-1e38
```