
Terraform Best Practices


HashiCorp’s Terraform is a popular Infrastructure as Code (IaC) tool that helps DevOps teams codify their cloud infrastructure. While it’s a powerful tool that can help automate infrastructure provisioning, Terraform can have a steep learning curve.

To help you hit the ground running with Terraform, this guide will explore Terraform best practices in depth. After reading this guide, you’ll be familiar with Terraform best practices related to: 

    Structure and style
    The Terraform state file
    Development
    Deployment
    Security 

Terraform best practices build on each other to form a pyramid.
Automated FinOps for Hybrid Cloud Management

Learn More
icob

Customizable guardrails to embed FinOps policies into new workload provisioning
icon

Self-service catalogs to provision compliant, cost-efficient resources in private and public clouds
icon

Accountable FinOps workflows with task assignment, chargeback reports, and scorecards
Terraform Best Practices: An Overview

The table below provides an overview of Terraform best practices. The sections that follow will take a closer look at each best practice. . 
Structure and style best practices
Terraform best practice	Description 
Use a consistent file structure and naming convention	A consistent file structure and naming convention will keep maintenance effort low
Use variables appropriately	Use the self variable, tfvars files, and avoid hard coding
Use the lookup function	Data blocks can return maps so use lookup to parse the output
Use a tagging schema	Clearly tagged resources help during security incidents and decrease troubleshooting time
Use modules where necessary	Adhere to DRY principles and use modules to avoid repeating yourself
Use templates for things like AWS EC2 user-data	Bash and HashiCorp Configuration Language (HCL) in the same file is messy and hard to maintain
Use format and validate	Keep your files tidy by using the built-in format and validate features
State file best practices
Terraform best practice	Description 
Store your state file remotely	Configure a backend for your state files to avoid the risk of local state loss
Use one state per environment	Development, testing and production environments must have their own state file for blast radius control
Set up state locking	Avoid concurrent contention issues by configuring state locking
Development best practice
Terraform best practice	Description 
Set up your IDE for streamlined development	Preconfiguring your IDE enables significantly faster development 
Test your Terraform code	Test Terraform code like you test your production software
Deployment best practices
Terraform best practice	Description 
Automate your deployment with a CI / CD pipeline	Use automated deployment for a consistent deployment environment
Use automated security scanning tools	Use tools like checkov to detect misconfigurations
Security best practices
Terraform best practice	Description 
Avoid passing credentials to terraform	Instead, delegate permissions to the automated build environment using roles
Terraform Best Practices: Structure and Style

In their excellent 1999 book, The Pragmatic Programmer, Dave Thomas and Andy Hunt liken bad code and config to having broken windows:

    “One broken window — a badly designed piece of code, a poor management decision that the team must live with for the duration of the project — is all it takes to start the decline. If you find yourself working on a project with quite a few broken windows, it’s all too easy to slip into the mindset of “All the rest of this code is crap, I’ll just follow suit.” It doesn’t matter if the project has been fine up to this point.”

Structure and style best practices are key to keeping good project hygiene and are the cornerstone of a healthy Terraform project. 
Use a consistent file structure and naming conventions
A person cleaning a screen. (Source).

Easy-to-read file structures and naming conventions future-proof your project. Maintainers won’t waste time trying to figure out what everything means. Instead, they can quickly and easily determine what the configuration does.
eBook
Demystifying misconceptions about cloud value

Download
Use variables appropriately

Hard coding values in your Terraform configuration files will save you 30 seconds during development and cost you hours of debug time during deployment.

Use variables for everything and keep them all in the same place with a tfvars file.
Use the lookup function

Use the lookup function to retrieve values from a map using keys. You can define maps in your variables, and some data sources return maps of values.
Use a tagging schema

Define a common set of tags for your cloud resources and apply them in your Terraform.

This Terraform best practice enables cost allocation to projects and cost centers, quicker resolution of incidents, and reduced burden for your operations teams.
Use modules where necessary

Terraform allows you to define a set of resources in a module and call that module as many times as you like with different parameters.

If you find yourself copying code blocks multiple times to just change a few values, consider using a module instead.

With modules, DevOps teams can keep their code and configuration DRY, so be sure to avoid copy/pasting code blocks as much as practical.
Use templates for things like AWS EC2 user-data

Terraform allows you to include non-HCL text in your .tf files using <<EOF. While convenient, this makes templates hard to read.

Use templatefile to separate your non-HCL code and configuration from your Terraform templates.
Use format and validate

Terraform has a built-in function that automatically formats your configuration files. Consider running the formatter every time you save a file to avoid accidentally committing unformatted files (remember those broken windows).

Always run terraform validate before running terraform plan or apply. This will create a fast-feedback loop because validate is a local function that doesn’t need to communicate to your remote backend.

Modern IDEs have these features built-in, and you can install plugins in emacs and vim.
Terraform Best Practices: State File

Terraform keeps track of everything it deploys and what configuration was applied in a state file. It compares what is in the state file to remote resources to define what actions must be taken to align the current state and desired state.
Store your state file remotely

Configuring Terraform to save its state file remotely means you can offload the responsibility for its durability, resilience, and high-availability to a cloud provider. For example, you can enable versioning to save a full change history of your state file if you save your state to AWS S3.

Storing your state file remotely also eliminates the need to commit your state file to source control or edit it manually. Doing either will likely lead to state file conflicts and corruption.
Use one state per environment

Configure Terraform to save separate state files for each of your environments to ensure strong blast radius controls are in place, especially between your non-production and production workloads.
Set up state locking

When multiple developers are working on the same project and deploy at the same time, they might be trying to change the same resources. If two or more developers do change the same resource, you can run into conflicts.

Configure Terraform state locking to avoid conflicts.
Terraform Best Practices: Development

Terraform development best practices focus on how engineers write and test Terraform code and HCL.
Set up your IDE for streamlined development

Time spent streamlining your IDE upfront can save developers weeks in the long run.

If you regularly work with Terraform and HCL, set up syntax highlighting, auto-completion, documentation tooltips, and automatic formatting and validation of your templates.
Test your Terraform Code
A human relaxing at a desk while a robot works on a computer. (Source).

Write unit, contract, integration, and end-to-end tests for your Terraform code. The Terraform documentation has an excellent article on testing.

Use Terratest as an integration test to ensure your configuration files behave as expected.
Terraform Best Practices: Deployment
Automate your deployment with a CI / CD pipeline

Every developer has a different environment that can make getting consistent deploys challenging.

Automating your deployment using a CI / CD pipeline guarantees that every deployment is from an identical environment and reduces the chance of human error creating a failure.
Use automated security scanning tools

DevOps teams should run automated scans and checks of your code and configuration with tools like checkov for every commit.

Finding and fixing misconfigurations before they make it to production will save time, decrease the chance of security incidents, and help enforce security best practices.
Terraform Best Practices: Security

Security is paramount for any production-grade tool, and Terraform is no exception. In fact, with Terraform often codifying enterprise infrastructure across cloud providers, it is vital that DevOps teams harden and secure their Terraform configuration.
Avoid passing credentials to Terraform

Passing credentials for cloud providers to Terraform is usually a symptom of manual deployment patterns. To avoid manually passing credentials into Terraform, run your Terraform code from within the cloud provider in an automated pipeline.

This will also allow you to leverage role-based access patterns, like IAM Roles on AWS, for example.
Video on-demand
The New FinOps Paradigm: Maximizing Cloud ROI

Featuring guest presenter Tracy Woo, Principal Analyst at Forrester Research

Watch Now
Summary

Terraform is a powerful IaC tool that can help enterprises automate the process of configuring, securing, and scaling their infrastructure. By following the best practices we’ve outlined in this guide, you can help ensure your Terraform deployments are a success.

If you found these Terraform best practices useful, read the other articles in this series. They dig deep into Terraform features that you should be using in your day-to-day development.
