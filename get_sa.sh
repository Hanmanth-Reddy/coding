
SA_FILE="sa.text"
DAYS=180
CUTOFF_DATE=$(date -d "-${DAYS} days" --utc +%Y-%m-%dT%H:%M:%SZ)

echo "Checking service accounts in $SA_FILE for keys older than $DAYS days..."
echo "Cutoff date: $CUTOFF_DATE"
echo "-----------------------------------------------"

while read -r SA_EMAIL; do
  [[ -z "$SA_EMAIL" ]] && continue

  PROJECT_ID=$(echo "$SA_EMAIL" | cut -d'@' -f2 | cut -d'.' -f1)

  echo "🔍 Checking: $SA_EMAIL  (Project: $PROJECT_ID)"

  gcloud iam service-accounts keys list \
    --iam-account="$SA_EMAIL" \
    --project="$PROJECT_ID" \
    --format="table(name, keyType, validAfterTime)" \
    --filter="validAfterTime < $CUTOFF_DATE" 2>/dev/null || \
    echo "⚠️  Error checking $SA_EMAIL (likely no permissions or invalid project)"

  echo ""
done < "$SA_FILE"

