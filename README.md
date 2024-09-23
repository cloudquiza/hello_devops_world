## Project Summary

This project demonstrates essential DevOps practices, including infrastructure automation with Terraform, container orchestration using Kubernetes and Docker, automated front-end testing with Playwright, and continuous integration through GitHub Actions. The automated front-end tests ensure the front-end functionality is validated across different browsers, making the development process more reliable and streamlined.

## Project Setup Instructions

### Prerequisites

Ensure you have the following tools installed on your local machine:

- **Docker**
- **Minikube**
- **kubectl**
- **Terraform**
- **AWS CLI**
- **Python 3**
- **Playwright**
- **IDE**
- **AWS account**
- **Docker Hub account**
- **Open AI Project API key**

### Step 1: Clone the Repository

<details>

<summary></summary>

`git@github.com:cloudquiza/hello_devops_world.git`

</details>

### Step 2: Set Up Environment Variables and Run Python Script

<details>

<summary></summary>

1. **Create a `.env` file** in the root directory with your `OPENAI_API_KEY`. The file should look like this:

`OPENAI_API_KEY=your_openai_api_key`

### Verify Python script and AI message works locally

`python3 hello_devops.py`

### View front end locally:

`python3 -m http.server 8000`

`http://localhost:8000/index.html`

2. **Docker Hub Access Token**: Add your Docker Hub access token to your environment

`export DOCKERHUB_ACCESS_TOKEN=YOUR_ACCESS_TOKEN`

`echo $DOCKERHUB_ACCESS_TOKEN`

OR

`docker login -u cloudquiza`

Enter docker access token at password prompt

</details>

### Step 3: Build and Run Docker Container Locally

<details>

<summary></summary>

1. Build your Docker image:

`docker build -t hello-devops-world .`

2. Run your Docker container:

`docker run -d -p 80:80 -e OPENAI_API_KEY=your_openai_api_key hello-devops-world`

3. Visit `http://localhost` to see the basic front end and confirm the app is running locally.

</details>

### Step 4: Tag and push Your Docker Image:

<details>

<summary></summary>

`docker tag hello-devops-world cloudquiza/hello-devops-world:latest`

`docker push cloudquiza/hello-devops-world:latest`

</details>

### Step 5: Deploy with Minikube

<details>

<summary></summary>

1. Start Minikube:

`minikube start --driver=docker`

2. Apply the Kubernetes manifests:

`kubectl apply -f k8s-manifests/deployment.yaml`

`kubectl apply -f k8s-manifests/service.yaml`

3. Verify the Deployment:

`kubectl get pods`

4. Verify the Service:

`kubectl get services`

5. Access the service URL:

`minikube service hello-devops-world-service --url`

6. Open the URL in your browser to view the front end.

</details>

### Step 6: Deploy to AWS EC2 with Terraform

<details>

<summary></summary>

1. **Configure AWS CLI** with your IAM user credentials:

`aws configure`

2. **Initialize and apply Terraform** to set up your EC2 instance:

`cd terraform`

`terraform init`

`terraform apply`

Confirm the action by typing `yes` when prompted.

3. After Terraform has finished deploying, note the public IP of the instance and visit `http://your-ec2-public-ip` to view the front end.

</details>

### Step 7: Install and Run Playwright Tests

<details>

<summary></summary>

**1. Install Playwright and its dependencies**

`npm install @playwright/test`

`npx playwright install-deps`

`npx playwright install`

**2. On seperate terminal windown spin up front end locally:**

`python3 -m http.server 8000`

`http://localhost:8000/index.html`

**3. Run Playwright tests**

`npx playwright test`

`npx playwright test --headed`

</details>

### Step 8: Delete Minikube and Destroy EC2 AWS Instance (Avoid Cost)

<details>

<summary></summary>

**1. Run the following to stop and delete minikube**

`minikube stop`

`minikube delete`

**2. Avoid Cost**: Use the following command to stop the EC2 instance after you're done testing:

`terraform destroy`

</details>
