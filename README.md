# esc-logstash

ESC infrastructure and services ar sending their logs over kafka.
This k8s deployment creates a pod running logstash to receive the logs and send them to syslog over TLS.

## prerequisites

The current configuration is dependend on secret/esc-logs secrets in Vault:

- client_crt contains the kafka client crt (used for TLS encription)
- client_key contains the kafka private key (used for TLS encription)
- <keystore>.jks contains a java keystore for logstash
- <trusted_keystore>.jks contains the trusted keystore for logstash
- keystore_password contains the password for both keystores

## configuration

In the folder base/config you can find the following files, that all are included in the logstash-config configmap:

- config-init.hcl : configuration for vault agent injector
- pipelines.yml : references the pipeline conf, in this case logstash.conf
- logstash.conf : contains input and output plugin configs

the other files are contained in the base setup and can be adjusted if necessary