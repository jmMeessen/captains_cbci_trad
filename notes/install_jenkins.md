# Installing OSS Jenkins server on Ubuntu

* [ ] `wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -`
* [ ] `sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'`
* [ ] `sudo apt update`
* [ ] `sudo apt install jenkins`

## Starting the server
* [ ] `sudo systemctl start jenkins`
* [ ] to check the status: `sudo systemctl status jenkins`