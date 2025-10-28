PROJECT_ID="esearch-sandbox-wsdc"
OUTPUT="sa_keys_older_than_180days.json"
> $OUTPUT

for sa in $(gcloud iam service-accounts list --project "$PROJECT_ID" --format="value(email)"); do
  gcloud iam service-accounts keys list \
    --iam-account="$sa" \
    --project="$PROJECT_ID" \
    --format="json" \
    --filter="validAfterTime < $(date -d '-180 days' --utc +%Y-%m-%dT%H:%M:%SZ)" >> $OUTPUT
done
