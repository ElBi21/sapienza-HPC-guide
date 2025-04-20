## General

### How do I access the cluster?

You have to first login to the `frontend` node and then to the `submitter` using your account `<user>`:

```bash
ssh -J <user>@151.100.174.45 <user>@submitter
```

Once in the `submitter` you can use Slurm.

For details, please refer to [this page](/user_guide/how_to_connect_to_the_cluster).

### How do I get an account?

Contact an admin at `cluster.di@uniroma1.it` stating which is your role (student, PhD., researcher, professor etc.).

Eventually, if you have the `group_leaders` role, you can create a new account using the `add_user_hpc` command from the `frontend`.

### How do I get `department` or `group_leaders` role?

Contact an admin at `cluster.di@uniroma1.it` stating which is your role (student, PhD., researcher, professor etc.).

If you are a PhD., a researcher or a professor at our Department, then you're eligible to have the `department` role.

If you are a professor and you lead a laboratory, then you're eligible to have the `group_leaders` role.

### How do I change my password?

Once in the `frontend`, use the `change_password` command.

## Storage

### How do I transfer files from/to the cluster?

Please take a look at [this page](/user_guide/storage.html#transfer-files-fromto-the-cluster) of the docs.

## Jobs

### How do I check the resources of each node?

You can do this using the `sinfo` command with custom formatting.

=== "`sinfo` with no formatting"

    The basic command is the following:

    ```bash
    sinfo
    ```

    The output is not much detailed though:

    ```bash
    PARTITION       AVAIL  TIMELIMIT  NODES  STATE NODELIST
    admin              up   infinite      3   idle node[120-122]
    department_only    up 3-00:00:00     20  alloc node[103,112-114,116,123-124,126,130,132-135,137-143]
    students*          up 1-00:00:00     12   idle node[106-111,145-149,151]
    ```

=== "`sinfo` with custom formatting"

    If you need to know more specific info about each node, you can use a custom formatter for the output of `sinfo`.
    The following formatters will show node names, partitions, number of CPUs per node, MBs of memory per node, GPUs per node, and time limit, and the numbers mean how much character are needed per column: 

    ```bash
    sinfo --format="%40N %16P %4c %8m %24G %12l"
    ```

    For a list of all the available formatters, please refer to the [Slurm's official docs](https://slurm.schedmd.com/sinfo.html#OPT_format).
    The result will then be detailed as will:

    ```bash
    NODELIST                                 PARTITION        CPUS MEMORY   GRES                     TIMELIMIT
    node120                                  admin            64   257566   gpu:quadro_rtx_6000:2    infinite
    node121                                  admin            64   257566   (null)                   infinite
    node122                                  admin            64   257566   gpu:quadro_rtx_6000:1    infinite
    node[103,114,116,130,132-135,137-143]    department_only  64   257566+  (null)                   3-00:00:00
    node[112-113,123-124,126]                department_only  64   257566   gpu:quadro_rtx_6000:2    3-00:00:00
    node[106-109,145-149,151]                students*        32+  257566+  (null)                   1-00:00:00
    node110                                  students*        64   257566   gpu:quadro_rtx_6000:1    1-00:00:00
    node111                                  students*        64   257566   gpu:quadro_rtx_6000:2    1-00:00:00
    ```

### How do I use NVCC?

To use NVCC (Nvidia CUDA Compiler) you need to be in a node with a GPU.
Once there, you need to append some lines to your `~/.bashrc` file:

```bash
echo "export PATH=/usr/local/cuda-12.8/bin:$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc
```

After that, `nvcc` will be available.

??? note "Check `nvcc`'s version"

    You can do this with the `nvcc --version` command:

    ```bash
    $ nvcc --version
    nvcc: NVIDIA (R) Cuda compiler driver
    Copyright (c) 2005-2025 NVIDIA Corporation
    Built on Fri_Feb_21_20:23:50_PST_2025
    Cuda compilation tools, release 12.8, V12.8.93
    Build cuda_12.8.r12.8/compiler.35583870_0
    ```

### How do I use MPI?

Every node has OpenMPI 5.0.7 installed. You can check the details using the `ompi_info` command.

Please refer to [Slurm's official MPI documentation](https://slurm.schedmd.com/mpi_guide.html#open_mpi) about how to use it.

### How do I launch a container?

You can launch containers using either Docker or Singularity.
You're encouraged to use Singularity as [Docker is known to have issues on HPCs](https://www.reddit.com/r/HPC/comments/10gg2pn/using_docker_containers_in_hpc/?rdt=46664).

=== "Launch a non-interactive container"

    To launch a non-interactive container from image `<image_name>` in the Docker Hub with command `<command>`, simply run:

    ```bash
    srun [requirements] -p <partition> singularity exec docker://<image_name> <command>
    ```

    ??? note "Example"

        For example, to get to know the GPU characteristics of a node from inside a container:
    
        ```bash
        srun --gpus=1 -p students singularity exec --nv docker://pytorch/pytorch:2.6.0-cuda11.8-cudnn9-devel nvidia-smi
        ```

        It will take a while since the image is big and Singularity must convert from the Docker to Singularity format:

        ```
        INFO:    Converting OCI blobs to SIF format
        INFO:    Starting build...
        INFO:    Fetching OCI image...
        INFO:    Extracting OCI image...
        INFO:    Inserting Singularity configuration...
        INFO:    Creating SIF file...
        Tue Mar 25 11:04:36 2025
        +-----------------------------------------------------------------------------------------+
        | NVIDIA-SMI 570.124.06             Driver Version: 570.124.06     CUDA Version: 12.8     |
        |-----------------------------------------+------------------------+----------------------+
        | GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
        | Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
        |                                         |                        |               MIG M. |
        |=========================================+========================+======================|
        |   0  Quadro RTX 6000                Off |   00000000:41:00.0 Off |                  Off |
        | 32%   36C    P0             62W /  260W |       1MiB /  24576MiB |      6%      Default |
        |                                         |                        |                  N/A |
        +-----------------------------------------+------------------------+----------------------+

        +-----------------------------------------------------------------------------------------+
        | Processes:                                                                              |
        |  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
        |        ID   ID                                                               Usage      |
        |=========================================================================================|
        |  No running processes found                                                             |
        +-----------------------------------------------------------------------------------------+
        ```

=== "Launch an interactive container"

    To launch an interactive container from image `<image_name>` in the Docker Hub, simply run:

    ```bash
    srun [requirements] -p <partition> --pty singularity shell docker://<image_name> 
    ```

    ??? note "Example"

        For example, to connect to bash on a node with a GPU:
    
        ```bash
        srun --gpus=1 -p students singularity shell --nv docker://pytorch/pytorch:2.6.0-cuda11.8-cudnn9-devel
        ```

        It will take a while since the image is big and Singularity must convert from the Docker to Singularity format.
        If I were to start a Python terminal, the output will look like this:

        ```
        INFO:    Using cached SIF image
        Singularity> python
        Python 3.11.11 | packaged by conda-forge | (main, Dec  5 2024, 14:17:24) [GCC 13.3.0] on linux
        Type "help", "copyright", "credits" or "license" for more information.
        >>> import torch
        >>> torch.cuda.device_count()
        1
        >>>
        ```