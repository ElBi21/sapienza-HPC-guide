The cluster, or HPC (High Performance Computer), is composed of several computers called nodes.

## Types of nodes

Each node has a different purpose, but the roles of interest for a user are two:

- A login node, also called submitter, is normally the only directly accessible by the users. It lets them submit and manage their jobs, but does not perform any computation. On our cluster, the address of the login node is `192.168.0.102`, which is aliased to `submitter`;
- A compute node is in charge of executing the jobs submitted through the login node.

Normally, a user logged into the login node can submit one or more jobs to be executed by compute nodes.
When they do so, the jobs are assigned to available compute nodes by the job scheduler on the login node.

## Partitions

Cluster's nodes are further split in three partitions based on user's groups:

| Partition | Accepted groups | Time limits per job | Nodes with/without a GPU | Default/Max memory per job | Max CPUs per node | Max nodes per user |
| - | - | - | - | - | - | - |
| `admin` | `sudo` | unlimited | 0/1 | unlimited | unlimited | unlimited | unlimited |
| `department_only` | `sudo`, `department`, `group_leaders` | 3 days (72 hours) | 6/15 | 8 GB/unlimited | unlimited | 8 |
| `multicore` | everyone | 6 hours | 0/2 | 8 GB/unlimited | unlimited | 1 |
| `students` | everyone | 1 day (24 hours) | 3/8 | 8/32 GB | 8 | 1 | 

You can check your group using the `groups` command on the `frontend` or the `submitter`.

??? note "Output of the `groups` command"

    If you're a student with username `<user>`, probably the output would look like this:

    ``` bash
    <user> docker
    ```

    If you're a group leader with username `<user>`, the output would look like this instead:

    ``` bash
    <user> docker group_leaders
    ```

## Storage