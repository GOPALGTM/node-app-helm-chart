# Node Hello World

Simple node.js app that servers "hello world"

Great for testing simple deployments to the cloud

To deploy the project on Kubernetes using kubeadm, you will need to follow these steps on both the master and worker nodes:

To create a Kubernetes cluster with a master and worker nodes using EC2 instances, first create Two ec2 instances for master and worker nodes.

connect both the nodes and follow this steps:

---------------------------------------- Kubeadm Installation ------------------------------------------ 

-------------------------------------- Both Master & Worker Node ---------------------------------------

sudo su
apt update -y
apt install docker.io -y

systemctl start docker
systemctl enable docker

curl -fsSL "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg
echo 'deb https://packages.cloud.google.com/apt kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

apt update -y
apt install kubeadm=1.20.0-00 kubectl=1.20.0-00 kubelet=1.20.0-00 -y

--------------------------------------------- Master Node -------------------------------------------------- 
sudo su
kubeadm init

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

kubeadm token create --print-join-command
  

------------------------------------------- Worker Node ------------------------------------------------ 
sudo su
kubeadm reset pre-flight checks

#add 6447 port on the worker node security group 
-----> Paste the Join command on worker node and append `--v=5` at end

#To verify cluster connection  
---------------------------------------on Master Node-----------------------------------------

kubectl get nodes

#install helm
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh

git clone https://github.com/GOPALGTM/node-app-helm-chart.git

cd node-app-helm-chart

helm install node-app node-app-helm-chart

kubectl get svc

#add NodePort to the security group of the worker node

#then go to browser http://workernodepublic-ip:nodeport
