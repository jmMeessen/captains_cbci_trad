# Installing OSS Jenkins server on Ubuntu

## Java
* [ ] `wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -`
* [ ] `sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/`
* [ ] `sudo apt-get update`
* [ ] `sudo apt-get install adoptopenjdk-8-hotspot`

## Jenkins
* [ ] `wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -`
* [ ] `sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'`
* [ ] `sudo apt update`
* [ ] `sudo apt-get install jenkins`

## Starting the server
* [ ] `sudo systemctl start jenkins`
* [ ] to check the status: `sudo systemctl status jenkins`

```
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install adoptopenjdk-8-hotspot
sudo apt-get -y install jenkins
```