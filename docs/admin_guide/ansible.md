## Inventory

??? note "Ansible's inventory file"

    ```ini title="inventory.ini" linenums="1"
    --8<-- "ansible/inventory.ini"
    ```

## Environment

??? note "Sets environment variables and essential packages"

    ```ini title="ansible/setup_env.yaml" linenums="1"
    --8<-- "ansible/setup_env.yaml"
    ```

??? note "Install OpenMPI"

    ```ini title="ansible/install_openmpi.yaml" linenums="1"
    --8<-- "ansible/install_openmpi.yaml"
    ```

??? note "Install Anaconda on all nodes"

    ```ini title="ansible/install_anaconda.yaml" linenums="1"
    --8<-- "ansible/install_anaconda.yaml"
    ```

??? note "Install Visual Studio Code Tunnel on all nodes"

    ```ini title="ansible/install_code.yaml" linenums="1"
    --8<-- "ansible/install_code.yaml"
    ```

## Slurm

??? note "Slurm's configuration file"
    
    ```conf title="slurm.conf" linenums="1"
    --8<-- "slurm/slurm.conf"
    ```

??? note "Propagate Slurm's configuration file from controller to all nodes"
    
    ```yaml title="propagate_slurm_conf.yaml" linenums="1"
    --8<-- "ansible/propagate_slurm_conf.yaml"
    ```

??? note "Reboot `department_only` partition nodes"
    
    ```yaml title="reboot_department_only_nodes.yaml" linenums="1"
    --8<-- "ansible/propagate_slurm_conf.yaml"
    ```