For easeness of use, you can create custom commands to automatize some actions.
For example, you can define a custom command `drain_node` to drain a Slurm node from all jobs and put it to idle so you don't have to remember the exact command each time. 

## How to add a custom command

To add a custom script, you have to create a new file in `~/bin`.
Note that this location is **not** shared between nodes and is **not** shared between users.
Once you create a file here and set the right permissions, the command will be immediately available.

This is a step-by-step guide to create a custom command:

1. Create a folder that will contain all your custom scripts. It can be located everywhere, but for easeness of use we will create it in our home directory:

    ```bash
    mkdir ~/bin
    ```

1. Add this folder to your `PATH` by adding this line at the end of your `~/.bashrc` (e.g. using `nano ~/.bashrc`):

    ```bash title="~/.bashrc"
    ...
    export PATH="$HOME/bin:$PATH"
    ```

    After that, either run `source ~/.bashrc` or reload your shell to apply changes.

1. Create the new script inside your newly created `~/bin`. Remember to prepend `#!/bin/bash` to the file to tell the system to run it using the shell. The following script, called `custom_command`, will simply print a string:

    ```bash title="~/bin/custom_command"
    #!/bin/bash
    echo "Hello world! I'm a custom command!"
    ```

1. Set the new permissions accordingly. For easiness, you can set them for the entire folder:

    ```bash
    chown -R $USER ~/bin && chmod -R 744 ~/bin
    ```

Now you can run `custom_command` from your shell to print the string.

## List of implemented admin custom commands

### Connections

#### `connect_to_node`

Connect to a node through `ssh`. 
Requires a node ID as a parameter (e.g. `102`).

```bash linenums="1"
--8<-- "scripts/commands/connect_to_node"
```

#### `connect_to_submitter`

Connect to the submitter node through `ssh`.

```bash linenums="1"
--8<-- "scripts/commands/connect_to_submitter"
```

#### `connect_to_controller`

Connect to the controller node through `ssh`.

```bash linenums="1"
--8<-- "scripts/commands/connect_to_controller"
```

### Slurm

#### `drain_node`

Drains a Slurm node from all jobs and put it idle.
    
```bash linenums="1"
--8<-- "scripts/commands/drain_node"
```

