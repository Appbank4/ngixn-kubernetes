apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
  annotations:
    description: "This is an advanced Nginx pod configuration"
spec:
  containers:
  - name: nginx-container
    image: nginx
    ports:
    - containerPort: 80
    resources:
      requests:
        memory: "64Mi"
        cpu: "300m"
      limits:
        memory: "128Mi"
        cpu: "500m"
    env:
    - name: ENVIRONMENT
      value: "production"
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 15
      periodSeconds: 10
    livenessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 20
      periodSeconds: 15
    volumeMounts:
    - name: nginx-config
      mountPath: /etc/nginx/nginx.conf
      subPath: nginx.conf
  volumes:
  - name: nginx-config
    configMap:
      name: nginx-configmap