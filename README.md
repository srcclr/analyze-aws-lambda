# analyze-aws-lambda
A couple of shell scripts to download and inspect all lambda functions and layers

The scripts provided will use the default AWS profile configured in ~/.aws/credentials to download and inspect either all lambda functions, or all lambda layers.

## Pre-requisites
- Veracode SCA Agent installed, and default profile activated
- Default AWS CLI Credentials configured in ~/.aws/credentials
- chmod +x <script.sh>

## Usage
- Scanning all lambda functions: ./download_scan_all_lambdas.sh
- Scanning all lambda layers: ./download_scan_all_layers.sh

## Usage with non-default profile(s)
- Include `--profile <profile name>` in each instance of the `aws lambda ....` command
- Include `--profile <profile name>` in each instance of the `srcclr scan` command
