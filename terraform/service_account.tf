# Bigquery Owner
resource "google_service_account" "bq_owner" {
    account_id = "bq-owner"
    project    = var.project_id
    depends_on = [
        google_project_service.data_project_services
    ]
}

# dbt service account
resource "google_service_account" "dbt_sa" {
    account_id   = "dbt-runner"
    project      = var.project_id
    display_name = "dbt Service Account"
    description  = "dbt service account"
    depends_on = [
        google_project_service.data_project_services
    ]
}
# dbt service account key
resource "google_service_account_key" "dbt_sa_key" {
    service_account_id = google_service_account.dbt_sa.name
    public_key_type    = "TYPE_X509_PEM_FILE"
}

# lightdash service account
resource "google_service_account" "lightdash_sa" {
    account_id   = "lightdash-runner"
    project      = var.project_id
    display_name = "lightdash Service Account"
    description  = "lightdash service account"
    depends_on = [
        google_project_service.data_project_services
    ]
}

# lightdash service account key
resource "google_service_account_key" "lightdash_sa_key" {
  service_account_id = google_service_account.lightdash_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}