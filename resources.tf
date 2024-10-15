# resource "aws_s3_bucket" "rss-task-2-bucket" {
#   bucket = "rss-task-2-bucket"
#   acl    = "private"
# }

# resource "aws_s3_bucket_versioning" "rss-task-2-bucket-versioning" {
#   bucket = aws_s3_bucket.rss-task-2-bucket.bucket
#   versioning_configuration {
#     status = "Enabled"
#   }
# }