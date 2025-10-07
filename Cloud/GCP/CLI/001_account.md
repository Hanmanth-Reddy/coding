## gcloud authentication 
```bash
gcloud auth login 
gcloud auth list 
```

## TO View, Edit Gcloud CLI properties
```bash
gcloud config set/get/list/unset
gcloud config list
gcloud config set project <project-1>
gcloud config set account <account-1>
```





# IAM - Indentity and Access management 

Directory Structure

Resource hierarchy 
Organization
 └── Folder(s)
      └── Project(s)
           └── Resources (Buckets, Topics, Functions, etc.)


Identities (User,Group,Service Account , G Suite / Google Workspace (Google Cloud Identity + Productivity apps like Gmail, Calendar, Drive, Docs, Sheets, Meet), domain)
Roles (Basic/Primitive roles, Predefined roles, Custom roles)
<b> policies <\b>: 
<b>Binding <\b>: role + member
IAM policy scopes: organization, Folder, projects, individula Resources



IAM Policy is a full access control document
```yaml
bindings:
- members:
  - user:hanmanth@gmail.com
  role: roles/storage.admin
- members:
  - serviceAccount:ci-bot@myproject.iam.gserviceaccount.com
  role: roles/logging.logWriter
etag: BwWkdf8723G=
version: 1
```

Policy: 
memebers -- which indetity  
roles -- has which role 
binding -- role + memeber combinations 


## This command create,manage,delete IAM resources user/serviceaccount/groups, roles , policies
```bash
gcloud iam

gcloud iam service-accounts SA-1
gcliud iam service-accounts list

gcloud iam roles create <role-1>

```


add-iam-policy-binding 
set-iam-policy
get-iam-policy
remove-iam-policy-binding 

--member="user:hanmanth@example.com"
--member="serviceAccount:ci-bot@myproject.iam.gserviceaccount.com"
--member="group:devops-team@example.com"
--member="domain:example.com"

--role="roles/resourcemanager.organizationAdmin"




## To add, set, delete  and manage permissions at organization, folder, project and resource level
🔹 1️⃣ Organization Level IAM Policy
gcloud organizations add-iam-policy-binding ORG_ID \
  --member="user:hanmanth@gmail.com" \
  --role="roles/resourcemanager.organizationAdmin"

gcloud organizations add-iam-policy-binding 123456789012 \
  --member="group:admins@mycompany.com" \
  --role="roles/resourcemanager.organizationAdmin"


🔹 2️⃣ Folder Level IAM Policy
gcloud resource-manager folders add-iam-policy-binding FOLDER_ID \
  --member="user:hanmanth@gmail.com" \
  --role="roles/resourcemanager.folderAdmin"

gcloud resource-manager folders add-iam-policy-binding 456789123456 \
  --member="user:devopslead@mycompany.com" \
  --role="roles/resourcemanager.folderEditor"


🔹 3️⃣ Project Level IAM Policy
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:ci-bot@myproject.iam.gserviceaccount.com" \
  --role="roles/storage.admin"


🔹 4️⃣ Resource Level IAM Policy
gcloud <service> <resource-type> add-iam-policy-binding <RESOURCE_NAME> \
  --member="user:hanmanth@gmail.com" \
  --role="roles/<role>"

gcloud storage buckets add-iam-policy-binding my-bucket \
  --member="user:hanmanth@gmail.com" \
  --role="roles/storage.objectViewer"

gcloud pubsub topics add-iam-policy-binding my-topic \
  --member="serviceAccount:publisher@myproject.iam.gserviceaccount.com" \
  --role="roles/pubsub.publisher"

gcloud secrets add-iam-policy-binding my-secret \
  --member="user:developer@mycompany.com" \
  --role="roles/secretmanager.secretAccessor"

gcloud iam service-accounts add-iam-policy-binding \
  ci-bot@myproject.iam.gserviceaccount.com \
  --member="user:hanmanth@gmail.com" \
  --role="roles/iam.serviceAccountUser"
