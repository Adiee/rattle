# Create an EKS cluster
resource "aws_eks_cluster" "rattle_eks_cluster" {
  name     = "rattle-eks01-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.private_subnets[*].id
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
  tags = {
      Name                    = "rattle-eks01_nodeGroup"
      tag_cost_center         = "rattle-eks01-test-vaule"
      tag_jira                = "rattle-eks01-test-vaule"
      tag_env                 = "rattle-eks01-test-vaule"
      tag_tf                  = "rattle-eks01-test-vaule"
    }

  depends_on = [aws_subnet.private_subnets, aws_security_group.eks_cluster_sg]
}

# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "rattle-eks01-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = "rattle-eks01-sg"
  description = "Security group for EKS cluster"
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/24"]
  }

  egress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/24"]
  }

  vpc_id = aws_vpc.rattle_vpc.id
}

resource "aws_iam_role" "eks_node_group_role" {
  name = "rattle-eks01-node-group-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  depends_on = [aws_iam_policy.eks_node_group_policy]
}

resource "aws_iam_policy" "eks_node_group_policy" {
  name        = "rattle-eks01-node-group-policy"
  description = "IAM policy for rattle-eks01 node group"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "eks:DescribeCluster",
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = "eks:ListNodegroups",
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = "eks:DescribeNodegroup",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}


resource "aws_key_pair" "my_key_pair" {
  key_name   = "rattle-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")  
}


resource "aws_eks_node_group" "rattle-eks01_node_group" {
  cluster_name    = aws_eks_cluster.rattle_eks_cluster.name
  node_group_name = "rattle-eks01-node-group"
  node_role_arn = aws_iam_role.eks_node_group_role.arn

  subnet_ids = aws_subnet.private_subnets[*].id

  remote_access {
    ec2_ssh_key = "rattle-key-pair" 
  }

  scaling_config {
    min_size = 1
    max_size = 2
    desired_size = 1
  }
  tags = {
      Name                    = "rattle-eks01_nodeGroup"
      tag_cost_center         = "rattle-eks01-test-vaule"
      tag_jira                = "rattle-eks01-test-vaule"
      tag_env                 = "rattle-eks01-test-vaule"
      tag_tf                  = "rattle-eks01-test-vaule"
    }

  depends_on = [aws_eks_cluster.rattle_eks_cluster, aws_key_pair.my_key_pair, aws_iam_role.eks_node_group_role]
}
