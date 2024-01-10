resource "google_project_iam_binding" "sa_iam_bindings" {
  project = var.project_id
  role    = "roles/bigquery.admin"

  members = [
    "serviceAccount:${google_service_account.dbt_sa.email}",
    "serviceAccount:${google_service_account.lightdash_sa.email}"
  ]
}

resource "google_storage_bucket_iam_member" "raw_bucket_view" {
  bucket = "${var.project_id}-raw"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.dbt_sa.email}"
  depends_on = [google_storage_bucket.raw_bucket]
}

resource "google_storage_bucket_iam_binding" "raw_bucket_admin" {
  bucket = "${var.project_id}-raw"
  role   = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.dbt_sa.email}"
  ]
  depends_on = [google_storage_bucket.raw_bucket]
}

resource "google_storage_bucket_iam_member" "raw_bucket_admin_elt" {
  bucket = "${var.project_id}-raw"
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.dbt_sa.email}"
  depends_on = [google_storage_bucket.raw_bucket]
}

