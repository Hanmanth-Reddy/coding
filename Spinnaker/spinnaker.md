<h1>Spinnaker Services</h1>

<h2><u>Spinnaker consists of multiple microservices, including:</u></h2>
•	Deck – UI frontend
•	Gate – API gateway
•	Front50 – Stores application/pipeline metadata
•	Rosco – Bakery service for image creation
•	Igor – Integrates with CI/CD tools (e.g., Jenkins)
•	Echo – Notification service
•	Fiat – Role-based access control (RBAC)
•	Kayenta – Automated canary analysis (optional)
•	Clouddriver – Manages cloud infrastructure
•	Orca – Orchestration engine for pipelines


<h2><u>Deck – UI Frontend</u></h2>
The web-based user interface for Spinnaker. Users interact with Spinnaker through Deck to configure applications, pipelines, and deployments.
Built using AngularJS and communicates with other services via the Gate API.

<h2><u>Gate – API Gateway</u></h2>
Acts as the entry point for all Spinnaker API requests.Exposes a REST API that allows external tools and users to interact with Spinnaker.
Handles authentication and authorization before forwarding requests to other microservices.

<h2><u>Front50: Persistent Storage</u></h2>
Spinnaker uses Front50 to store application and pipeline configurations/metadata  such as. 
	•	Pipeline configurations
	•	Application settings
	•	Deployment history
Supported storage backends include:
	•	Google Cloud Storage (GCS)
	•	Amazon S3
	•	Azure Blob Storage
	•	MinIO (S3-compatible)
	•	Redis
	•	SQL Databases (MySQL, Postgres, etc.)
Configuring storage is crucial since Spinnaker relies on it to store metadata and pipeline states.

<h2><u> Fiat – Authentication & Authorization</u></h2>
Implements Role-Based Access Control (RBAC) in Spinnaker.
Supports multiple authentication methods, including:
	•	OAuth 2.0 (Google, GitHub, Azure, etc.)
	•	LDAP
	•	SAML
	•	x509 Certificates
Works with external identity providers to restrict access to Spinnaker resources.
For authorization, Spinnaker uses Fiat, which integrates with external identity providers to enforce role-based access control.

<h2><u>Clouddriver – Cloud Infrastructure Management</u></h2>
•	Responsible for interacting with cloud providers (AWS, GCP, Azure, Kubernetes, etc.).
•	Fetches real-time cloud resource information (instances, load balancers, security groups).
•	Executes deployments by creating, updating, or deleting cloud resources.

<h2><u>Orca – Pipeline Orchestration Engine</u></h2>
The workflow engine that executes pipelines and deployment strategies.
Manages:
	•	Pipeline execution states
	•	Rollback strategies
	•	Stage dependencies
	•	Approval gates
Works closely with Clouddriver and Front50.

<h2><u>Igor – CI/CD Integration</u></h2>
Bridges Spinnaker with CI/CD tools such as:
	•	Jenkins
	•	GitHub Actions
	•	Travis CI
	•	Google Cloud Build
	•	AWS CodeBuild
Triggers pipeline executions based on CI job results.

<h2><u> Rosco – Image Bakery Service</u></h2>
•	Automates the creation of machine images (AMIs, VM images, etc.) for deployments.
•	Integrates with tools like Packer to bake images.
•	Used in environments where immutable infrastructure (pre-baked images) is a preferred deployment strategy


<h2><u> Echo – Notification & Event Handling</u></h2>
•	Handles event-driven notifications in Spinnaker.
•	Can send alerts via:
o	Slack
o	Email
o	SMS
o	Webhooks
•	Also supports custom event listeners to trigger pipelines based on external events.


<h2><u> Kayenta – Automated Canary Analysis (Optional)</u></h2>
•	Performs automated canary deployments by comparing new and existing versions of applications.
•	Uses metrics from monitoring tools (Prometheus, Datadog, Stackdriver, etc.) to detect performance regressions.
•	Helps in making data-driven release decisions.
