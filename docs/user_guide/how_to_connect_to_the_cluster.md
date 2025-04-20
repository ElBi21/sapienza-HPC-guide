You can connect to the cluster via `ssh` from the Sapienza network or through Sapienza's VPN. To do this, you will need to get an account.

## Pre-requisites

### Having an account on the cluster

In order to connect to the cluster, you will need to use your account. It can be created by a group leader (e.g. your supervisor) or an admin. If you're in doubt or want to become a group leader, [ask an admin](mailto:cluster.di@uniroma1.it).

If you're a group leader or an admin and want to create an account, you have to simply use the `add_user_hpc` on the `frontend` node:

```bash
add_user_hpc
```

??? note "Output of the `add_user_hpc` command"

    The output will be something like that:

    ```
    You're about to create a new user in the cluster. There exists three kinds of users:
    1) Students: have access to a subset of nodes in the cluster
    2) Department: have access to all nodes in the cluster
    3) Group leaders: like department, but can create new users. It can be created only by admins, so contact cluster.di@uniroma1.it
    Which kind of user are you adding? (students, department)
    students
    What is the name of the new department user?
    new_user
    Enter new UNIX password:
    Retype new UNIX password:
    passwd: password updated successfully
    make[1]: Entering directory '/var/yp/frontend.nis.htc'
    Updating passwd.byname...
    Updating passwd.byuid...
    Updating group.byname...
    Updating group.bygid...
    Updating netid.byname...
    Updating shadow.byname...
    make[1]: Leaving directory '/var/yp/frontend.nis.htc'
    User 'new_user' has been successfully created.
    ```

### Being connected to the Sapienza network

The cluster will be accessible only if your connection is part of the Sapienza network.
There are three possibilities to accomplish this.

=== "Through Sapienza wifi"

    If you're connected to the `sapienza` or `eduroam` wifi networks from inside the university, then you're all set.

=== "Through Sapienza VPN"

    If you're physically outside of the university, then you can connect to the [Sapienza VPN](https://web.uniroma1.it/infosapienza/servizio-vpn-di-ateneo).

    This is only possible if you have a `@uniroma1.it` email, and so if you're a PhD student, researcher or professor.

=== "Through Department's VPN"

    If you're both physically outside of the university and don't have a `@uniroma1.it` email (e.g. you're a student), then you can connect using [Department's VPN](https://drive.google.com/file/d/14G95lT9PExqIJ1xf942dh_1G22wlQYr1/view?usp=sharing) and your institutional credentials. 
    
    Note that using this VPN lets you direct access to the `submitter` node, so you can bypass the `frontend` hop. 

## Connect to the cluster

For this to work, you have to first connect to the `frontend` node, and from there to th `submitter` node, where you can use Slurm.

1. To connect to the `frontend` server, you can use `ssh` to the address `151.100.174.45`:

    ```bash
    ssh <user>@151.100.174.45
    ```

    Make sure to replace `<user>` with your username, and make sure to be connected to the Sapienza network.

1. Once you're in the `frontend` node, you have to `ssh` again into the `submitter` node:
    
    ```bash
    ssh submitter
    ```
    Once there, you can [use Slurm](how_to_use_slurm.md).

??? note "Connect in a single step"

    If you're using Linux, you can connect in a single step like this:

    ``` bash
    ssh -J <user>@151.100.174.45 <user>@submitter
    ```

