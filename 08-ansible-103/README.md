# Lesson 03 - Ansible 103

## Precondition

Create environment in Yandex Cloud

```sh
cd 08-ansible-103/terraform

# Create "terraform.tfvars" with variables: api_token, cloud_id, folder_id
yc iam create-token
yc resource-manager cloud list
yc resource-manager folder list


terraform init
terraform apply -auto-approve

terraform output -raw ansible_inventory > ../ansible/inventory/inventory.yaml
terraform output -raw ansible_ssh_private_key > ../ansible/private_key
chmod 0600 ../ansible/private_key
```

## Solution

### Plays

1. Clickhouse Installation (Hosts group: `clickhouse`)
    * **Pre-tasks:**
        * Creates the APT GPG keyring directory structure.
    * **Tasks:**
        * Dynamically detects the host architecture (`amd64` or `arm64`).
        * Adds the official Clickhouse repository using the modern DEB822 format.
        * Installs Clickhouse packages and updates the package manager cache.
    * **Handlers:**
        * Starts and enables the `clickhouse-server` service.
    * **Post-tasks:**
        * Creates a default database (ignoring errors if the database already exists).

2. Lighthouse Installation (Hosts group: `lighthouse`)
    * **Pre-tasks:**
        * Installs prerequisites (e.g., `git`, `nginx`) and creates the working directory.
    * **Tasks:**
        * Clones the Lighthouse source code from the official Git repository.
        * Deploys the Nginx configuration template (`default`) to serve the UI.
    * **Handlers:**
        * Restarts the `nginx` service to apply new configurations.

### Variables

The following variables must be defined in your `group_vars`, `host_vars`, or play variables for the playbook to execute correctly:

| Variable | Description | Example Value |
| --- | --- | --- |
| `apt_gpg_keyrings_dir_path` | Target directory for GPG keyrings | `/etc/apt/keyrings` |
| `apt_clickhouse_repository_url` | URL of the official Clickhouse repository | `https://packages.clickhouse.com/deb` |
| `apt_clickhouse_gpg_key_src_url` | URL of the Clickhouse repository GPG key | `https://packages.clickhouse.com/deb/clickhouse.gpg` |
| `apt_clickhouse_packages` | List of Clickhouse packages to install | `['clickhouse-server', 'clickhouse-client']` |
| `clickhouse_db_name` | Name of the default database to create | `analytics` |
| `apt_required_packages` | System dependencies for Lighthouse | `['git', 'nginx']` |
| `lighthouse_working_dir` | Target directory for the Lighthouse web root | `/var/www/lighthouse` |
| `lighthouse_git_repository_url` | URL of the Lighthouse Git repository | `https://github.com/VKCOM/lighthouse.git` |

### Tags

Currently, **no explicit `tags` are assigned** to the tasks within this playbook.

You can run the entire playbook or restrict execution to specific host groups using the `--limit` flag:

* Target Clickhouse only: `ansible-playbook site.yml --limit clickhouse`
* Target Lighthouse only: `ansible-playbook site.yml --limit lighthouse`

### How-To

1. Run steps from precondition section
2. Start ansible playbook

    ```sh
    ansible-playbook --private-key private_key playbook/site.yaml
    ```

## Notes

* Lighthouse Git repository does not have any tags or versions so `ansible-lint` will always give a warning about it:

    ```sh
    latest[git]: Result of the command may vary on subsequent runs.
    playbook/site.yaml:60 Task/Handler: Clone lighthouse Git repository

    Read documentation for instructions on how to ignore specific rule violations.

    # Rule Violation Summary

        1 latest profile:safety tags:idempotency

    Failed: 1 failure(s), 0 warning(s) in 1 files processed of 1 encountered. Last profile that met the validation criteria was 'moderate'. Rating: 2/5 star
    ```
