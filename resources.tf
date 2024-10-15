resource "aws_s3_bucket" "rss-task-1-bucket" {
  bucket = "rss-task-1-bucket"
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "rss-task-1-bucket-versioning" {
  bucket = aws_s3_bucket.rss-task-1-bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}