# Deploy EVE-NG to Google Cloud using IaC

## Features

- Deploys an EVE-NG (Community Edition) VM instance in Google Cloud that mostly follows the steps outlined in the [official documentation](https://www.eve-ng.net/index.php/documentation/community-cookbook/).
- Automatically downloads lab images from a Google Cloud bucket and fixes permissions.
- Easily tears down the entire VM with a single command so that it costs virtually nothing when not in use.
- Integrates with the [No-IP](https://www.noip.com/) API to update the DDNS entry on boot.
- Automatically create a secure admin password for the web GUI.
- **TODO** Automatically download and backup lab configuration files.

## Why

I am a heavy user of EVE-NG for my professional studies, and I wanted a way to have a lab in the cloud at minimal cost. I have deployed EVE-NG instances in Google Cloud in the past, but even with the instance completely turned off, there are still charges to maintain the boot disk and the custom EVE-NG image. This meant I was paying over $10/month to not use something. By using Terraform, I only paying for what I use and nothing more. I could save an additional few dollars by uploading the lab images directly from my local machine instead of keeping them in a bucket, but since my internet is not the fastest, I think the time saved is worth it.

My second reason is for professional development. I find that the best way to learn a technology is to use it to solve a problem, and this project has taught me a lot about Terraform, Ansible, IaC, and cloud technologies.

## Install

- TODO
