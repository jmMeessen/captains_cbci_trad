# Generate a new SSH key

the SSH key is used for AWS and Ansible

* Create the key: `ssh-keygen -t ed25519 -C "jean-marc@meessen-web.org" -f ~/.ssh/captains_cbci_trad`
* Copy the public key to the terraform directory: `cp ~/.ssh/captains_cbci_trad.pub terraform/`