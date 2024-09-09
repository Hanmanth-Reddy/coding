## To search charts from Hub/repo

    helm search hub <keyword> --list-repo-url
    helm search hub elastic --list-repo-url

    helm search repo <keyword>
    helm search repo elastic 


## To list/add/update/remove repos

    helm repo list

    helm repo add <repo-name> <repo-url>
    helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

    helm repo update


## To download and publish chartS
    
    helm pull spark-operator/spark-operator
    helm pull https://googlecloudplatform.github.io/spark-on-k8s-operator

    helm push ./my-chart/ https://mychartrepo.example.com --username myuser --password mypassword

    helm registry login <host>
    helm registry logout <host>



## To list, install, uninstall, history, rollback, upgrade, get info of releases
    
    helm list --all-namespaces
    
    helm install [RELEASE_NAME] <repo>/<chart-name> --namespace <namespace> -f values.yaml --service-account <service-account> --timeout 300s --dry-run --debug
    helm install [RELEASE_NAME] <repo>/<chart-name> --namespace <namespace> --set key1=value1,key2=value2 --service-account <service-account> --timeout 300s --dry-run --debug 
    helm install spark-release-5 spark-operator/spark-operator --namespace spark-operator --set batchScheduler.enable=true --set webhook.enable=true --set operatorImageName=spark-operator/spark-operator --create-namespace

    helm history [RELEASE_NAME]
    helm history spark-release-5

    helm rollback [RELEASE_NAME] <revision-name> -f custom-values.yaml
    helm rollback spark-release-5 2 -f custom-values.yaml

    helm uninstall [RELEASE_NAME] --namespace <namespace> --wait --timeout 300s
    helm uninstall spark-release-5  --namespace spark-operator --wait --timeout 300s
 
    helm upgrade [RELEASE_NAME] [CHART_NAME]
    helm upgrade myapp stable/mysql
    helm upgrade myapp stable/mysql --version 1.2.3 --atomic -f custom-values.yaml
    helm upgrade myapp stable/mysql --version 1.2.3 --atomic --set mysqlRootPassword=newpassword
    helm upgrade myapp stable/mysql --recreate-pods

    helm status [RELEASE_NAME] 

    helm get all [RELEASE_NAME]]
    helm get all spark-relase-5


## To create custom Charts

    helm create hello

    helm lint </path/to/mychart>
    helm lint hello

    helm template [RELEASE_NAME] [CHART_NAME]
    helm template spark-release-5 spark-operator --set key1=val1,key2=val2


    helm get values [RELEASE_NAME]
    kubectl get pods -n default -l release=myapp

    helm dependency update [CHART_NAME]
    helm dependency update [CHART_NAME]

	helm status [RELEASE_NAME]
