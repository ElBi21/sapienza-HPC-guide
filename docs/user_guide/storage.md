The cluster has a storage system which is persistent across all nodes: this means that the files you edit on `frontend` will be the same across all nodes.

## Transfer files from/to the cluster

There are plenty of methods to transfer files to the cluster.
We will analyze two methods.

=== "`rsync` method"

    `rsync` is a command-line utility that efficiently synchronizes files and directories between two locations by transferring only the differences between the source and destination files, making it ideal for large data transfers and backups. 
    
    While rsync offers many advantages, including security, flexibility, and scriptability, it also has a steep learning curve and limited file browsing capabilities due to its command-line interface, which can be a drawback for some users.

    Transferring files and folders recursively is as simple as executing this command from your local terminal:

    ```bash
    rsync -vr <src_path> <dst_path>
    ```

    As an example:

    ```bash
    rsync -vr local_file.txt <user>@151.100.174.45:~ # (1)
    rsync -vr <user>@151.100.174.45:~/remote_file.txt . # (2)
    ``` 

    1. Transfer a local file `local_file.txt` to the home directory of your user on the cluster `/home/<user>`
    2. Transfer a file `remote_file.txt` from the home directory of your user on the cluster `/home/<user>` to the current folder of the local terminal

=== "FileZilla method"

    [FileZilla](https://filezilla-project.org/) is an open-source FTP (File Transfer Protocol) client software that allows users to transfer files between their local computer and a remote server, providing a graphical user interface that simplifies file management tasks. 
    
    It might be preferred over rsync for users who are not comfortable with command-line interfaces or need to perform more complex file management tasks, such as browsing and editing files on the remote server, as it offers a more intuitive and user-friendly experience.

    In order to connect to the cluster, you have to create a site on the FileZilla's Site Manager:
    
    1. Click on File :arrow_forward: Site Manager :arrow_forward: My Sites :arrow_forward: New site
    1. Change the following fields:

        | Field | Value |
        |-|-|
        | Name of the site on FileZilla's Site Manager | whatever name you prefer, `frontend` for example |
        | Protocol | `SFTP - SSH File Transfer Protocol` |
        | Host | `151.100.174.45` |
        | Logon type | `Normal` |
        | User | your username on the cluster |
        | Password | your password on the cluster |

        After this procedure, your Site Manager should look like this:

        ![Example of FileZilla's site manager](/assets/images/filezilla_site_manager.png)
    
    Now that the site has been created, you can connect to it by clicking, on the Site Manager, on the name of the new created site and then to Connect.
    Now that you've opened a connection to the site, you can use FileZilla to transfer files.

## Limits

Each user has up to 3TB available.