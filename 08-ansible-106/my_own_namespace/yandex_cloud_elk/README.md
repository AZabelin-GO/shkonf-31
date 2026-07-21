# Ansible Collection - my_own_namespace.yandex_cloud_elk

This Ansible collection provides custom plugins, modules, and roles for managing configuration files on target hosts with full idempotency and `--check` mode support.

---

## Prerequisites

- **Ansible Core**: `>= 2.10.0`
- **Python**: `>= 3.8` (on both control and managed nodes)

---

## Collection Contents

### Custom Modules

**`my_own_namespace.yandex_cloud_elk.shkonf_31_module`** A custom Python-based module that manages file creation and content synchronization.

  **Parameters:**

  | Parameter | Type | Required | Description |
  | :--- | :--- | :--- | :--- |
  | `path` | `str` | **true** | Absolute path on the target host where the file should be created or updated. |
  | `content` | `str` | **true** | Desired text content to write into the destination file. |

---

### Roles

**`my_own_namespace.yandex_cloud_elk.create_file`** A role that encapsulates `shkonf_31_module` execution with configurable default variables.

  **Default Variables (`defaults/main.yml`):**

  ```yaml
  file_path: "/tmp/default_collection_file.txt"
  file_content: "Default content from collection role\n"
  ```
