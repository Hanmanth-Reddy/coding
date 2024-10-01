```---
apiVersion: sparkoperator.k8s.io/v1beta2
kind: ScheduledSparkApplication
metadata:
  name: scheduled-spark-app
  namespace: default
spec:
  schedule: "0 3 * * *"  # Schedule to run at 3 AM every day using cron syntax
  concurrencyPolicy: Allow  # Options: Allow, Forbid, Replace
  successfulRunHistoryLimit: 3  # How many successful runs to keep
  failedRunHistoryLimit: 1  # How many failed runs to keep

  template:
    batchScheduler: volcano  
    type: Scala  # Options: Java, Scala, Python, R
    mode: cluster  # Options: cluster, client
    image: gcr.io/spark-operator/spark:v3.1.1  # Spark Docker image
    imagePullPolicy: Always
    mainClass: org.apache.spark.examples.SparkPi
    mainApplicationFile: "local:///opt/spark/examples/jars/spark-examples_2.12-3.1.1.jar"
    sparkVersion: "3.1.1"

    arguments:  # Arguments passed to the main class
      - "1000"

    restartPolicy:
      type: Never  # Restart policy: Never, OnFailure, Always
      onFailureRetries: 3
      onFailureRetryInterval: 10
      onSubmissionFailureRetries: 5
      onSubmissionFailureRetryInterval: 20

    deps:  # Dependencies
      jars: []
      files: []
      pyFiles: []

    hadoopConf:
      "fs.defaultFS": "hdfs://namenode:8020"
      "dfs.client.use.datanode.hostname": "true"
    volumes:
    - name: test-volume
      hostPath:
          path: /apps/tmp
          type: Directory

    - name: json-data
      hostPath:
          path: /apps/json/admin
          type: Directory
    - name: test-volume
      hostPath:
          path: /mnt/tmp/db
          type: DirectoryOrCreate
    -  name: sa-volume
       hostPath:
          path: /mnt/apps/sa
          type: Directory      
    - name: gcp-platform-secure-connector-prd
      secret:
          secretName: platform-secure-connector-prd      
    driver:
      cores: 1
      coreLimit: "1200m"
      memory: "512m"
      memoryOverhead: "512m"
      serviceAccount: spark
      labels:
        version: 3.1.1
      envVars:
        SPARK_WORKER_INSTANCES: "2"
      tolerations:
        - key: "example-key"
          operator: "Exists"
          effect: "NoSchedule"
      nodeSelector:
        disktype: ssd
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: kubernetes.io/e2e-az-name
                    operator: In
                    values:
                      - e2e-az1
                      - e2e-az2
                      
    executor:
      cores: 2
      instances: 3
      memory: "1024m"
      memoryOverhead: "1024m"
      labels:
        version: 3.1.1
      envVars:
        SPARK_EXECUTOR_CORES: "2"
      volumeMounts:
      - name: test-volume
        mountPath: /tmp
      - name: sa-volume
        mountPath: /sa
      - name: gcp-platform-secure-connector-prd
        mountPath: /sa        
      nodeSelector:
        disktype: ssd
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            labelSelector:
              matchExpressions:
                - key: security
                  operator: In
                  values:
                    - S1
      tolerations:
        - key: "example-key"
          operator: "Exists"
          effect: "NoSchedule"
