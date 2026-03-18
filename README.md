# SRE E-Commerce Platform

A hands-on SRE platform demonstrating system evolution from manual containerized microservices to fully automated, cloud-native and GitOps-driven infrastructure.

## Project Structure

The project demonstrates how a system evolves from containerized microservices with observability (Docker, Kong API Gateway, Prometheus, Grafana) to automated CI/CD pipelines (Jenkins for build orchestration and Ansible for deployment), then to cloud-native infrastructure (AWS EKS, Kubernetes, Terraform), and finally GitOps (GitHub Actions, ArgoCD). 

The platform also includes simulated failure scenarios to demonstrate monitoring, alerting, and self-healing behavior in distributed systems.

| Phase | Focus | Tools |
|---|---|---|
| [Phase 1 — Containerization & Observability](./phase-1-docker-observability) | Containerize microservices, API gateway, monitoring | Docker, Kong, Prometheus, Grafana |
| [Phase 2 — CI/CD & Automation](./phase-2-orchestration-automation) | Automated build, push and deployment pipeline | Jenkins, Ansible |
| Phase 3 — Cloud & Orchestration *(coming soon)* | Deploy to AWS cloud with Kubernetes and IaC | AWS, EKS, Kubernetes, Terraform |
| Phase 4 — GitOps *(coming soon)* | Full end to end automation | GitHub Actions, ArgoCD |

## Business Problem

In production environments, service failures lead to downtime, financial impact, and loss of customer confidence. This platform demonstrates how modern SRE practices — containerization, observability, automation, and GitOps — work together to build resilient, self-healing systems.

## Author

**Sushmitha Sudarshan**
Site Reliability Engineer | 2+ years managing reliability across 150+ services
[LinkedIn](https://www.linkedin.com/in/sushmitha-sudarshan)