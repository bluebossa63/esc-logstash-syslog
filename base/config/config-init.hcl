"auto_auth" = {
  "method" = {
    "config" = {
      "role" = "logstash-syslog"
    }
    "mount_path" = "auth/<your-env>"
    "type" = "kubernetes"
  }
  "sink" = {
    "config" = {
      "path" = "/home/vault/.token"
    }
    "type" = "file"
  }
}
"exit_after_auth" = true
"pid_file" = "/home/vault/.pid"

"template" = {
  "source" = "/vault/configs/logstash.conf"
  "destination" = "/vault/secrets/logstash.conf"
}

"template" = {
  "contents" = <<EOF
{{ with secret "kv-v2/secret/esc-logs" -}}{{ base64Decode .Data.data.client_crt }}{{- end }}
EOF
  "destination" = "/vault/secrets/client.crt"
}

"template" = {
  "contents" = <<EOF
{{ with secret "kv-v2/secret/esc-logs" -}}{{ base64Decode .Data.data.client_key }}{{- end }}
EOF
  "destination" = "/vault/secrets/client.key"
}

"template" = {
  "contents" = <<EOF
{{ with secret "kv-v2/secret/esc-logs" -}}{{ base64Decode .Data.data.draco_910_ca_jks }}{{- end }}
EOF
  "destination" = "/vault/secrets/<trusted_keystore>.jks"
}

"template" = {
  "contents" = <<EOF
{{ with secret "kv-v2/secret/esc-logs" -}}{{ base64Decode .Data.data.draco_910_jks }}{{- end }}
EOF
  "destination" = "/vault/secrets/<keystore>.jks"
}

"vault" = {
  "address" = "<your vault>"
  "ca_cert" = "/vault/tls/ca.crt"
  "client_cert" = "/vault/tls/tls.crt"
  "client_key" = "/vault/tls/tls.key"
}