resource "aws_dynamodb_table" "simple_table" {
  name = var.db_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }
}