## Networking-related

??? note "Script to update InfiniBand drivers"

    ```bash title="update_ib.sh" linenums="1"
    --8<-- "scripts/update_ib.sh"
    ```

## GPU-related

This has to be done in two steps, intertwined by a reboot.

??? note "Scripts to update GPU drivers"

    ```bash title="update_cuda_part1.sh" linenums="1"
    --8<-- "scripts/update_cuda_part1.sh"
    ```

    ```bash title="update_cuda_part2.sh" linenums="1"
    --8<-- "scripts/update_cuda_part2.sh"
    ```