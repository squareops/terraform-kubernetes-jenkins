## IAM Permission

The Policy required to deploy this module:
```hcl
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:CreateRole",
                "iam:DeleteRole",  
                "iam:GetRolePolicy",
                "iam:PutRolePolicy",
                "iam:ListRolePolicies",
                "iam:ListAttachedRolePolicies",
                "iam:ListInstanceProfilesForRole"  
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:CreateSecret",
                "secretsmanager:DeleteSecret",
                "secretsmanager:DescribeSecret",  
                "secretsmanager:GetSecretValue",
                "secretsmanager:PutSecretValue",
                "secretsmanager:GetResourcePolicy"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```
## Azure Role Permissions

```hcl
{
    "Name": "AzureJenkinsRole",
    "Actions": [
        "Microsoft.Authorization/*/read",
        "Microsoft.Authorization/*/write",
        "Microsoft.Authorization/elevateAccess/Action",
        "Microsoft.Authorization/policies/read",
        "Microsoft.Authorization/policies/write",
        "Microsoft.Authorization/policyAssignments/read",
        "Microsoft.Authorization/policyAssignments/write",
        "Microsoft.Authorization/roleAssignments/read",
        "Microsoft.Authorization/roleAssignments/write",
        "Microsoft.Authorization/roleDefinitions/read",
        "Microsoft.Authorization/roleDefinitions/write",
        "Microsoft.ManagedIdentity/userAssignedIdentities/read",
        "Microsoft.ManagedIdentity/userAssignedIdentities/write",
        "Microsoft.KeyVault/vaults/read",
        "Microsoft.KeyVault/vaults/write",
        "Microsoft.KeyVault/vaults/keys/read",
        "Microsoft.KeyVault/vaults/keys/write",
        "Microsoft.KeyVault/vaults/secrets/read",
        "Microsoft.KeyVault/vaults/secrets/write",
        "Microsoft.KeyVault/vaults/certificates/read",
        "Microsoft.KeyVault/vaults/certificates/write"
    ],
    "NotActions": [],
    "AssignableScopes": ["/subscriptions/{subscriptionId}"]
}
```

## Google IAM Permissions

```hcl
permissions = [
    "roles/container.viewer",
    "role": "roles/iam.securityReviewer",
    "role": "roles/iam.roleAdmin",
    "role": "roles/secretmanager.secretAccessor",
    "role": "roles/secretmanager.secretVersionManager"
]
```