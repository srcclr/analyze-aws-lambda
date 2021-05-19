# analyze-aws-lambda
A couple of shell scripts to download and inspect all lambda functions and layers

The scripts provided will use the default AWS profile configured in ~/.aws/credentials to download and inspect either all lambda functions, or all lambda layers.

## Background 
AWS Lambda serverless functions typically contain code that will be executed upon a trigger. Serverless functions are not required, nor expected to install any dependencies during its runtime, and any dependencies should be pre-installed. They are typically pre-installed either in a custom Docker image provided by the user, or a pre-defined image such as Python 3.8 + the usage of AWS Layers to be included on top of the pre-defined images.

Hence, one could typically scan AWS Lambda functions by scanning the AWS Layers, or in rare circumstances, directly in the AWS Lambda functions.

## Using Veracode SCA Agent to effectively scan serverless functions (eg. AWS Lambda)
As established, the typical way to run SCA scan on these serverless functions is to run a scan on the additional layers attached to the functions. 

An SCA scan on serverless functions would look like this:
- Download the layer(s) used by the function
- Run SCA scan on the downloaded layer(s)

OR

Run the two scripts provided. (See the Usage section)

The results would be all additional third party dependencies that were not already installed by default.
Note: Scanning default installed package would be trivial and possible if a custom Docker image has been used through the use of Container scanning.

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

## Tutorial
Here we created a Lambda function called "serverless-demo" with our included "serverless-demo" zip file.
![serverless-demo](https://user-images.githubusercontent.com/5872086/118753820-56754d80-b898-11eb-8ef3-89b246c522e9.png)

We also create the 2 layers with our included "random-jar" and "flask" zip files.
![layers](https://user-images.githubusercontent.com/5872086/118753985-a81dd800-b898-11eb-882b-ffb63dceecb3.png)

Next, we ensure the 2 layers are attached to the serverless-demo function.
![function-overview](https://user-images.githubusercontent.com/5872086/118754069-d3082c00-b898-11eb-9a89-e8b18a41f628.png)

And now we're ready to run the 2 scripts above.

Screenshot of the script downloading the layers
<img width="1595" alt="image" src="https://user-images.githubusercontent.com/5872086/118754217-27aba700-b899-11eb-847e-2d105b9a8835.png">

Screenshot of the script running SCA scan
<img width="1267" alt="image" src="https://user-images.githubusercontent.com/5872086/118754388-8b35d480-b899-11eb-944b-d57f6aca8da6.png">


## Miscellaneous Files
- serverless-demo.zip: This contains a simple serverless function written in Python that requires Flask, a third party dependency
- flask.zip: This contains the Flask dependencies which is used to demonstrate how third party dependencies are included in AWS Lambda
- random-jar.zip: This contains a couple of third party libraries in the JAR format, which could be uploaded as an AWS Lambda Layer 
