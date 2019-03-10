resource "kubernetes_secret" "postgres" {
  metadata {
    name      = "postgres"
    namespace = "giffy"
  }

  data {
    DB_NAME     = "giffy"
    DB_USER     = "giffy"
    DB_PASSWORD = "???"
  }
}
