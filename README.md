# ansible-nextcloud

Installs nextcloud as docker container.

## System requirements

* Docker
* Systemd

## Role requirements

* (none so far)

## Tasks

* Template docker environment and pull docker images
* Create volume paths for docker container
* Setup systemd unit file
* Start/Restart systemd service

## Role parameters

| Variable                          | Type           | Mandatory? | Default                    | Description                                                           |
|-----------------------------------|----------------|------------|----------------------------|-----------------------------------------------------------------------|
| nextcloud_image_name              | text           | no         | nextcloud                  | Docker image name (recommended to use the default image)              |
| nextcloud_image_version           | text           | no         | latest                     | Docker image version (recommended to use a fixed version like `18.0`) |
| nextcloud_db_image_name           | text           | no         | postgres                   | Docker image name (recommended to use the `postgres` docker image     |
| nextcloud_db_image_version        | text           | no         | latest                     | Docker image version (recommended to use a fixed version like `12.2`) |
| nextcloud_interface               | ip address     | no         | 0.0.0.0                    | Mapped network for web-interface ports                                |
| nextcloud_http_port               | port           | no         | 80                         | Mapped HTTP port                                                      |
| nextcloud_www_volume              | path           | no         | /srv/nextcloud/www         | Path to nextcloud's www volume                                        |
| nextcloud_database_volume         | path           | no         | /srv/nextcloud/database    | Path to database volume                                               |
| nextcloud_data_volume             | path           | no         | /srv/nextcloud/data        | Path where the file data will be stored                               |
| nextcloud_custom_apps_volume      | path           | no         | /srv/nextcloud/custom_apps | Path where the custom apps will be stored                             |
| nextcloud_db_secret_size          | number         | no         | 16                         | Size of the generated database secret                                 |
| nextcloud_additional_apt_packages | array of texts | no         | []                         | Additional apt package to be installed into docker image              |

## Usage

### Add to `requirement.yml`:

```yaml
- name: install-nextcloud
  src: https://github.com/borisskert/ansible-nextcloud.git
  scm: git
```

Minimal playbook:

```yaml
    - hosts: servers
      roles:
      - role: install-nextcloud
        nextcloud_www_volume: /srv/nextcloud/www
        nextcloud_database_volume: /srv/nextcloud/database
```

Typical playbook:

```yaml
    - hosts: servers
    - role: install-nextcloud
      nextcloud_image_version: '18.0.6'
      nextcloud_db_image_version: '12.3'
      nextcloud_http_port: 80
      nextcloud_interface: 0.0.0.0
      nextcloud_db_secret_size: 32
      nextcloud_www_volume: /srv/nextcloud/www
      nextcloud_database_volume: /srv/nextcloud/database
      nextcloud_data_volume: /srv/nextcloud/data
      nextcloud_custom_apps_volume: /srv/nextcloud/custom_apps
      nextcloud_additional_apt_packages:
        - smbclient
```

## Testing

Requirements:

* [Vagrant](https://www.vagrantup.com/)
* [libvirt](https://www.libvirt.org)
* [Ansible](https://docs.ansible.com/)
* [Molecule](https://molecule.readthedocs.io/en/latest/index.html)
* [yamllint](https://yamllint.readthedocs.io/en/stable/#)
* [ansible-lint](https://docs.ansible.com/ansible-lint/)
* [Docker](https://docs.docker.com/)

### Run within docker

```shell script
molecule test
molecule test -s all-parameters
```

### Run within Vagrant

```shell script
molecule test --scenario-name vagrant --parallel
molecule test --scenario-name vagrant-all-parameters --parallel
```

I recommend to use [pyenv](https://github.com/pyenv/pyenv) for local testing.
Within the GitHub Actions pipeline I use [my own molecule action](https://github.com/borisskert/molecule-action).
