
Terraform vs. Ansible


Configuration management and orchestration are two of the most important aspects of infrastructure management. Terraform and Ansible are two of the most popular DevOps tools for configuration management and orchestration. As a result, Terraform vs. Ansible is a comparison many engineers need to make to find the right solution for their environment. 

In this post, we’ll take a deep dive into configuration management, orchestration, Infrastructure as Code (IaC), and Terraform vs. Ansible to help you choose the right tools for your use case. We’ll also provide a step-by-step tutorial to demonstrate how you can use Terraform and Ansible together to orchestrate and configure cloud resources. 
Terraform vs. Ansible Summary

The table below summarizes the differences between Terraform vs. Ansible. The Terraform vs. Ansible: A deep dive section of this article explores each comparison in depth. 

Terraform vs Ansible
Category 	Terraform	Ansible
Orchestration / Configuration management	Better at orchestration and lifecycle management of infrastructure components	Better at configuration management to provide runtime environment for business application
State management	Dedicated support to manage current state	Workarounds available to query the current state of running processes
Programming Paradigm	Declarative	Procedural
Infrastructure mutability	Tries to keep the infrastructure immutable where possible	Mutable by nature
Cloud vs. On-prem	Better at managing infrastructure components on cloud.	Better at managing configuration both on cloud and on-prem.
Packaging vs. Templating	Modules offer a way to package and reuse Infrastructure as Code (IaC).	Provides a template for configurations that can be reused.
Orchestration and Configuration Management

There are two main parts in provisioning IT infrastructure to host application workloads. They are: 

    Orchestration is the process of procuring and creating infrastructure. Orchestration is often automated with a variety of DevOps tools and cloud portals. 
    Configuration management is the process of configuring apps and environments to run workloads. 

At a high level, Terraform is more of an orchestration tool, while Ansible focuses on configuration management. Therefore, to understand the topic of Terraform vs. Ansible, let’s take a closer look at orchestration and configuration management. 
Orchestration

Provisioning infrastructure to host applications involves planning and designing based on technical requirements including networking, compute power, memory, and storage, as well as business and operational requirements like-like pricing, security, monitoring, and regulations.

Infrastructure diagrams represent the components and various kinds of relationships between them required for the end-to-end working of the product. In orchestration, infrastructure diagrams represent the on-prem or cloud infrastructure created with appropriate network connections.
Example hybrid-cloud infrastructure diagram (source)

Building IT infrastructure involves creating components such as virtual machines, databases, VPCs, subnets, firewall rules, security groups, VPN tunnels, and gateways. Traditionally, administrators manually created these components.

In the case of on-prem infrastructure deployment, bare metal servers, network devices, cables, peripheral devices, etc., are procured from a vendor and set up. It is a time-consuming process that includes procurement, shipping, and physically installing the hardware.

Conversely, cloud providers offer a web UI where infrastructure teams can simply log in, create, and configure the required components. Cloud has made things much easier and faster, thus enabling additional automation possibilities. Traditionally orchestration was about automating these deployments in bits and pieces – wherever possible.

However, orchestration and provisioning tools such as Terraform offer a full-fledged solution to manage the lifecycle of the entire infrastructure with the right configurations within minutes. Terraform is an IaC tool (Infrastructure as Code), where we can describe (declare) the cloud infrastructure in code.

Since Terraform maintains the infrastructure configuration in code and configuration files, it automatically leverages the advantages of code management principles. Since the files can be versioned and kept consistent, human error is greatly reduced – no matter how many times the infrastructure is created or destroyed.

Additionally, modifications to infrastructure are rolled out as new versions, enabling simple roll back to the previous state.
Configuration Management

After provisioning the infrastructure, the next task is to set up appropriate runtime environments for applications and services. For example, apps have requirements related to the operating system, libraries, patches, variables, and dependencies.

Before the emergence of configuration management tools, system administrators manually configured each machine. Unfortunately, manual processes are both slow and error-prone.

The emergence of configuration management tools such as Ansible helps administrators automate configuration workflows. Ansible provides a very efficient configuration management solution in the form of IaC. With Ansible, infrastructure configuration is codified in YAML files that describe ‘tasks’ to be performed on each node.

This process ensures that all the target nodes have a consistent set of steps. No matter how many times the clusters are scaled up or down, Ansible makes sure appropriate environmental dependencies are installed for the business applications to run smoothly.
Infrastructure as Code (IaC)

Both Terraform and Ansible are “IaC tools.” But why is IaC important?

In short, IaC gives DevOps teams a way to consistently and automatically provision and deploy infrastructure.

When expressed in code, infrastructure and configurations have inherent advantages such as version control, easy rollback, and consistency.

Additionally, from an operations perspective, IaC enables faster deployments and increased scalability.

There are various syntaxes available to write IaC. For example, Ansible uses YAML syntax to execute tasks, while Terraform uses HCL (Hashicorp Configuration Language) to declare the desired state of cloud infrastructure.
Terraform vs. Ansible: A deep dive

Now that you know the fundamentals of IaC, configuration management, and orchestration, let’s take a deep dive on Terraform vs. Ansible. The sections below will compare these tools to help you understand which is best for your DevOps team.
Terraform vs. Ansible Similarities

At a high level, both Ansible and Terraform provide orchestration and configuration management functionality.

They can provision cloud infrastructure in major cloud providers like AWS, Microsoft Azure, and GCP by consuming their APIs. Thus both tools are agentless.

Terraform and Ansible can configure resources by SSHing into the target instance and running PowerShell or Bash commands.

Beyond these similarities, Terraform and Ansible differ significantly in how they implement most features and functions. The following sections take a closer look at these differences.
Automated FinOps for Hybrid Cloud Management

Learn More
icob

Customizable guardrails to embed FinOps policies into new workload provisioning
icon

Self-service catalogs to provision compliant, cost-efficient resources in private and public clouds
icon

Accountable FinOps workflows with task assignment, chargeback reports, and scorecards
Terraform vs. Ansible: Orchestration and Configuration

Terraform and Ansible can both perform orchestration and configuration tasks. However, Terraform leans towards infrastructure provisioning, whereas Ansible leans towards configuration management.

Terraform offers lifecycle management for almost all the services by multiple cloud providers. Additionally, it is also possible to extend its capabilities to work with private data centers. However, the environment configuration options are rather limited.

On the other hand, Ansible is great at configuring provisioned resources. With Ansible, it is possible to manage versioned software component installation and environmental configurations easily. It is also possible to create cloud infrastructure. However, support for infrastructure creation is limited compared to Terraform.

    Key takeaway: If your use case requires managing the lifecycle of infrastructure components, Terraform is usually the better choice. If your use case is focused on infrastructure management, Ansible is your best bet.

Terraform vs. Ansible: State management

Both Terraform and Ansible deal with the creation and modification of infrastructure resources in a certain way. To put it simply – they modify the “current state” of the deployment.

Terraform offers a dedicated state management system. The state file stores the details of every operation performed. State files tie the real-world infrastructure deployments in the JSON format in memory. For any new change committed to the IaC, execution occurs without modifying the currently deployed infrastructure.

Apart from local state files, it also offers multiple options to manage state with a remote backend. This enables multiple developers to work together on the same infrastructure.

Ansible, on the other hand, provides no support to retain the current state of configuration changes. There is no direct way to understand the execution details in the last run.

Any changes introduced in the infrastructure are implemented from top to bottom on all the valid target machines. Ansible strives to maintain the current state of infrastructure up to date with the latest changes in IaC. However, workarounds are available to query the current state of the deployed services.

This is not a driving force to select one over another. Both tools have a unique way to query current information. The queried information differs for both tools, so a direct comparison is impossible. If there is a high reliance on state management information, Terraform is a better choice.

    Key takeaway: Terraform offers dedicated support to manage the current state, while Ansible requires workarounds to query the current state.

Terraform vs. Ansible: Declarative vs. Procedural

Continuing from the previous section, Terraform state management works based on the declarative nature of the IaC language. HCL is a declarative language – where the declaration of the desired state of the infrastructure happens beforehand. The system will then execute (apply) and build, modify, or destroy the target infrastructure.

Ansible YAML files contain tasks – steps to be executed on the target infrastructure. These tasks are procedural. Execution of all the steps happens, irrespective of any of the changes.

The programming paradigm is an attribute of respective technologies. Do not choose based only on this attribute. Use Terraform and Ansible to leverage their strengths in their respective domains.
eBook
Demystifying misconceptions about cloud value

Download
Terraform vs. Ansible: Mutable and Immutable

Infrastructure managed by Terraform is immutable – most of the time. It depends on what you are trying to change. Terraform applies changes without modifying the current configuration when it is possible to change infrastructure attributes.

However, certain changes require rebooting the service by nature. In this case, the onus is not on Terraform to protect its immutability.

Ansible on the other hand is mutable. New changes implemented via Ansible are recreated every time. Ansible constantly attempts to keep the configurations to their current state as programmed in the YAML configuration file.

It is generally better to keep the core infrastructure immutable, while application components can be mutable to maintain the current state.

    Key takeaway: Infrastructure managed by Terraform is immutable (in most cases), while configurations managed by Ansible are mutable.

Terraform vs. Ansible: Cloud vs. On-Prem

It is practically impossible to manage the lifecycle of on-prem infrastructure using any IaC. However, configuration management is possible via Ansible after provisioning.

Ansible manages the configurations of on-prem and cloud infrastructures alike.

Since Terraform leans towards lifecycle management of the infrastructure resources by utilizing cloud providers’ APIs, its use is limited as far as on-prem implementations are concerned.

However, developing independent Terraform modules is possible to manage infrastructure private data centers.

In the case of on-prem or cloud infrastructure, Ansible would be a better choice to manage the configurations. However, in the case of the cloud, the infrastructure lifecycle is better managed by Terraform.
Terraform vs. Ansible: Packaging and Templating

Although the infrastructure managed by Terraform is immutable, it packages entire sets of common cloud infrastructure as modules. Terraform modules provide a way to write IaC in a way that can replicate certain components of infrastructure architecture.

To promote the DRY principle in IaC, modules are a great way to encode reusable infrastructure components in Terraform. Importing a module and reusing the same in multiple deployments or environments can speed up and tighten the efficiency.

Ansible maintains the environmental configuration for a given set of target nodes. In a way, Ansible YAML files are templates to maintain a certain environment state.

These templates can specify operating systems, dependencies, patches, environmental variables. Thus making sure all the instances run a version of application components specified in the Ansible YAML file.

Packaging is great if infrastructure components hosted on the cloud vary in type, sizes, network accesses, storage, etc. But if that is not the case, Templating is a better choice for regular components – it would not make sense to template otherwise.

    Key takeaway: Terraform uses modules to package reusable code, while Ansible offers reusable templates.

How to Use Terraform and Ansible Together: A Practical Example

Now that you know the differences between Terraform vs. Ansible, let’s walk through a real-world example of how you can use them together to manage infrastructure. In this tutorial, we will:

    Create a few EC2 instances in AWS using Terraform
    Install NGINX on all of the instances using Ansible

Creation, modification, and destruction of infrastructure is managed by Terraform. Here is the IaC that will create our EC2 instances.

resource "aws_instance" "demo_vm" {
 count                   = 3
 ami                     = “ami-2sd2498r0g47”
 instance_type           = “t2.micro”

 tags = {
   name  = "Demo VM ${count.index}"
   type  = "Middleware"
 }
}

That IaC (Terraform resource) does the following:

    Creates 3 EC2 instance of type “t2.micro”.
    Specifies name and type

Tagging the cloud resource is a best practice as many integrations, processes, and reporting depend on them. In our case, tagging plays a role in qualifying these EC2 instances for configuration management by Ansible. It is a way to communicate with Ansible to let the controller know that these are the resources we want to configure in a specific way.

Apart from tags, instances are also grouped based on instance id, region, availability zones, security groups, etc. Tags as an attribute, remain constant as against other attributes of EC2 instances.

Ansible’s dynamic inventory plugin helps us create an inventory of target hosts by querying the region specified. For this demo, create an ec2.yml file in the /inventory directory with this content:

---
plugin: aws_ec2

aws_access_key: <YOUR-AWS-ACCESS-KEY-HERE>
aws_secret_key: <YOUR-AWS-SECRET-KEY-HERE>

regions:
  - eu-central-1

keyed_groups:
  - key: tags
    prefix: tag

Make sure to replace <YOUR-AWS-ACCESS-KEY-HERE> with your account’s access and secret key. We have specified a region as eu-central-1 since our EC2 instances are running in this region. The keyed_groups: attribute specifies the attributes we may group our EC2 resources in playbooks.

Next, create a playbook to include the steps required to install NGINX with the YAML code below. Note that the NGINX installation happens on correct hosts because we use the tags we defined earlier.

---
- hosts: tag_type_Middleware
  tasks:
   - name: Install NGINX
     apt: name=nginx state=latest
   - name: start nginx
     service:
         name: nginx
         state: started

Terraform may recreate existing/create new EC2 instances. As long as the tags are maintained, Ansible configures them appropriately.
Terraform vs. Ansible: Common Use Cases

Your use case should be a primary driver of the DevOps tools you choose. Let’s take a look at some of the common use cases for Ansible and Terraform, and which tool is better suited for the job.
Hybrid Cloud

It would make more sense for organizations working on a hybrid cloud model to use Ansible for its configuration management across the nodes spread across the public and private clouds. Management of simpler cloud infrastructures (like in the case of lift-and-shift) is possible via Ansible. To take advantage of more non-traditional cloud services (containers, serverless, storage classes, custom databases), Terraform is a better choice for the cloud.
Multi-cloud

Terraform is more useful for organizations trying to adopt a multi-cloud model. Given its support for a vast range of cloud providers, Terraform can shine in managing the cloud infrastructure here.
Legacy applications

Legacy application architectures tend to have fewer moving components. At the same time, their ability to run a production workload depends a lot on the environment. Ansible may be used here to manage complex configurations in a templated manner.
Microservices, containers, and serverless

On the other hand, more complex microservices architectures are more infrastructure-dependent. The individual services are easier to manage with lower configuration risks, but these configurations are required. Ansible is a good choice in the cloud if the architecture implements traditional components. If the cloud adoption is higher, then Terraform is a better choice.

Certain organizations have progressed further in their cloud adoption journeys where they have started using containerization technologies like Docker and Kubernetes, or even serverless. Containers, Kubernetes clusters, and serverless FaaS are usually better managed using Terraform because of its broad support for different cloud providers.
Don’t forget the people factor!

While architecture and technical requirements matter, the people factor is also important. Both the tools require a fair amount of learning. The choice of the right tool depends on the use case and other unforeseen aspects.
Video on-demand
The New FinOps Paradigm: Maximizing Cloud ROI

Featuring guest presenter Tracy Woo, Principal Analyst at Forrester Research

Watch Now
Conclusion

In this post we compared the similarities and differences between Terraform and Ansible as well as the basics of IaC, orchestration, and configuration management.

We also touched upon various use cases to give you an idea of how various factors may affect the choice of tool.  At a high level, Terraform is ideal for infrastructure lifecycle management while Ansible is better suited for configuration management.

Of course, while there are plenty of opinions, there is no one-size-fits-all solution. The right tool depends on your requirements and expertise. In fact, with Terraform being more of an orchestration tool and Ansible being a configuration management tool, sometimes the right answer is “use both.”
