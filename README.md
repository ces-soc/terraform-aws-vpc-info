# Terraform AWS VPC Info

This module retrieves some VPC and subnet information used to deploy to services and tasks to the campuses supported.

**Note:** This module does not create nor update any resources.

## Usage

```hcl
module "soc-vpcs" {
  source = "github.com/ces-soc/terraform-aws-vpc-info.git?ref=v0.1.0"
  for_each = toset([
    "byu",
    "byui"
  ])
  campus = each.key
}
```

After defining the module you can then retrieve the information you need (see available [outputs](#output) below) using the interpolation syntax:

```hcl
  vpc_id = module.soc-vpcs["byu"].vpc.id

```

## Requirements

* Terraform version 1.0.0 or greater
* AWS Provider version 4.2 or greater

## Input

| Name   | Type   | Description                 | Default Value |
| ------ | ------ | --------------------------- | ------------- |
| campus | string | Campus to retrieve data for | false         |

## Output

| Name               | Type                                                                                           | Description                                                                                                                      |
| ------------------ | ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| vpc                | [object](https://www.terraform.io/docs/providers/aws/d/vpc.html#attributes-reference)          | The VPC object                                                                                                                   |
| private_subnet_ids | list(string)                                                                                   | List of subnet_ids for the private subnets in the specified VPC                                                                  |
| public_subnet_ids  | list(string)                                                                                   | List of subnet_ids for the public subnets in the specified VPC                                                                   |
| data_subnet_ids    | list(string)                                                                                   | List of subnet_ids for the data subnets in the specified VPC                                                                     |
| private_subnets    | list([object](https://www.terraform.io/docs/providers/aws/r/subnet.html#attributes-reference)) | List of private subnet objects in the specified VPC                                                                              |
| public_subnets     | list([object](https://www.terraform.io/docs/providers/aws/r/subnet.html#attributes-reference)) | List of public subnet object in the specified VPC                                                                                |
| data_subnets       | list([object](https://www.terraform.io/docs/providers/aws/r/subnet.html#attributes-reference)) | List of data subnet objects in the specified VPC                                                                                 |
| on_prem_deploy     | string (Either "true" or "false")                                                              | Used to denote whether functions like write.humio should be talking to on the on prem humio endpoint or to the Humio SSH Gateway |

**Note about returning objects**: Because objects are returned (as opposed to just values), autocomplete may not work. Just add on the key to the end out the output accessor. Even though autocomplete won't work, those values will still be correctly returned.