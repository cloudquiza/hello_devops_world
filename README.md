## Project Setup Instructions

### Prerequisites

Ensure you have the following tools installed on your local machine:

- **Docker**
- **Minikube**
- **kubectl**
- **Terraform**
- **AWS CLI**
- **Python 3**
- **A text editor or IDE**
- **An AWS account and Docker Hub account**
- **Open AI Project API key**

### Step 1: Clone the Repository

`git@github.com:cloudquiza/hello_devops_world.git`

### Step 2: Set Up Environment Variables and Secrets

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

### Step 3: Build and Run Locally with Docker

1. Build your Docker image:

`docker build -t hello-devops-world .`

2. Run your Docker container:

`docker run -d -p 80:80 -e OPENAI_API_KEY=your_openai_api_key hello-devops-world`

3. Visit `http://localhost` to see the basic front end and confirm the app is running locally.

### Step 4: Tag and push Your Docker Image:

Example

`docker tag hello-devops-world cloudquiza/hello-devops-world:latest`

Example

`docker push cloudquiza/hello-devops-world:latest`

### Step 5: Deploy with Minikube

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

### Step 6: Deploy to AWS EC2 with Terraform

1. **Configure AWS CLI** with your IAM user credentials:

`aws configure`

2. **Initialize and apply Terraform** to set up your EC2 instance:

`cd terraform`
`terraform init`
`terraform apply`

Confirm the action by typing `yes` when prompted.

3. After Terraform has finished deploying, note the public IP of the instance and visit `http://your-ec2-public-ip` to view the front end.

4. **Avoid Cost**: Use the following command to stop the EC2 instance after you're done testing:

`terraform destroy`
