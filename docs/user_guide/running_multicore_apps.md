The cluster allows to run various applications with some of the most famous multicore libraries, such as MPI, PThreads, OpenMP and CUDA. In this page we show how to compile and run an application made with any of these libraries.

## Using MPI

The [MPI library](https://www.open-mpi.org/) is well known for its versatility in multi-processing tasks, making it ideal for HPC applications. In order to build an application with MPI, you can use the MPI compiler, `mpicc`, directly on the submitter. A code snippet follows:

```sh
mpicc [flags] main.c -o main_mpi.out
```

In order to run it, we use in combination `srun` and `mpirun` (or `mpiexec`). Depending on the number of cores that you need, check out the [cluster's architecture](./cluster_architecture.html) and select a partition accordingly. Remember that MPI **can run** across multiple nodes; the process communicator will adapt depending on the running configuration that you chose. So, for instance, if you need to use the `students` partition but you need to run MPI with 16 processes, you can do so by running MPI on two nodes and specifying a total number of 16 cores.

```sh
srun --partition=<partition> --nodes=<num_of_nodes> --cpus-per-task=<num_cores> mpirun -np <num_processes> --oversubscribe main_mpi.out [app_args]
```

Here, we used 2 extra `srun` flags and one `mpirun` flag, which are essential for running the application:

 - `--nodes <num_of_nodes>` for choosing the number of nodes on which we want to run our application. The number may vary depending on the chosen partition;
 - `--cpus-per-task <num_cores>` for requesting a given number of CPU **logical** cores. This number may be different from the number of processes spawned by `mpirun`. This number should consider the **total number of cores across all the nodes** (if more than one has been requested);
 - `-np <num_processes> --oversubscribe` for specifying how many processes MPI should spawn. Beware that `num_processes` $\leq$ `num_cores`.

## Using PThreads

The POSIX Threads library defines a standard for thread modeling, and is available on multiple Unix systems. Due to its versatility and portability, it's often chosen for modeling multi-threaded applications. In order to compile it, it's enough to use a C compiler such as `gcc` and to add the `-lpthread` flag. Compilation can happen on the submitter node through the following command:

```sh
gcc [flags] -lpthread main.c -o main_pt.out
```

In order to run the application, just use `srun` as for any other application:
```sh
srun --partition=<partition> --cpus-per-task=<num_cores> main_pt.out [app_args]
```

It is vital that you specify on how many cores the app should run with `--cpus-per-task=<num_cores>`: without this flag, your application will run in a single-thread setting. It is up to the user for choosing a method for spawning a set amount of threads: by hardcoding it into the app, or by passing it as a parameter... remember to specify that too. Here, we assume that the number of threads is hardcoded in the app.

## Using OpenMP

The OpenMP library offers a simple, yet effective way to parallelize on a thread level an application, through the use of well-defined pragmas. It is often used for its versatility and ease of use. In order to compile an application for OpenMP, we can use any compiler such as `gcc` which **must support** OpenMP, alongside the `-fopenmp` flag. You can look at a full list of compatible compilers [here](https://www.openmp.org/resources/openmp-compilers-tools/). For this guide, we'll use `gcc`:

```sh
gcc [flags] -fopenmp main.c -o main_omp.out
```

For running the application, it's enough to launch a job with `srun`, similarly to PThreads. Again, we also assume that the user has a way for telling the application how many threads should be spawned. Since OpenMP allows to set the number of threads also through an enviromental variable, we'll make two examples: one where we assume that the number of threads has been hardcoded in the app, and one where the number of threads is set through the enviromental variable:

=== "With the number hardcoded"

    Similarly to PThreads, it's enough to launch a job and specify the quantity of needed cores:
    
    ```sh
    srun --partition=<partition> --cpus-per-task=<num_cores> main_omp.out [app_args]
    ```
=== "With the enviromental variable"

    In order to use the enviromental variable, it must be first set on the submitter node, and then the application can be submitted:
    ```sh
    export OMP_NUM_THREADS=<num_threads>
    srun --partition=<partition> --cpus-per-task=<num_cores> main_omp.out [app_args]
    ```

## Using CUDA

The CUDA computing platform has been created by NVIDIA in order to program applications that can run on their GPUs. The cluster has some nodes with NVIDIA's RTX Quadro 6000 (more specifications on the [cluster's architecture page](./cluster_architecture.html)), with a compute capability of 7.5 (build your applications accordingly!). In order to compile a CUDA application, a job must be submitted, since NVIDIA's compiler, `nvcc`, is not available in the submitter node, but only on the nodes with a GPU. 

First, some lines must be added to your `.bashrc` file in order to update the `PATH` enviromental variable: without those you won't be able to use `nvcc`.

```sh
echo "export PATH=/usr/local/cuda-12.8/bin:$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc
```

Once done, you can proceed to compile your application. The compilation can be done as follows:

```sh
srun --partition=<partition> --gpus=1 nvcc [flags] --arch=sm_75 main.cu -o main.out
```

Pay attention to the `--arch=sm_75` flag: it's important that you compile your application with the correct CUDA architecture, otherwise the app won't run and will crash. Once the job will end, your executable will be placed in the folderwhere you ran the build command (if instead of `main.out` you specified another path, then you will find the build artifact on the specified path).

In order to run the application, it's important that you select a partition that has nodes with a GPU; then, you can submit a job with the following command:

```sh
srun --partition=<partition> --gpus=<num_of_gpus> main.out [app_args]
```

## Using MPI and other libraries

In most HPC settings, MPI is usually employed for coordinating multiple processes on different nodes, and then each process works locally through multi-threading libraries or with some hardware accelerators, such as CUDA. Here we show how to compile and run MPI with other libraries.

### MPI + PThreads and MPI + OpenMP

For MPI with PThreads or OpenMP, we just need to compile with `mpicc` and then add:

 - the `-lpthread` flag if we want to use PThreads;
 - the `-fopenmp` flag if we want to use OpenMP.

Two examples follow:

```sh
# For MPI + PThreads
mpicc -lpthread [flags] main.c -o main_mpi_pt.out

# For MPI + OpenMP
mpicc -fopenmp [flags] main.c -o main_mpi_omp.out
```

For running the application, the `mpirun` wrapper must be used. We assume that the programmer specifies the number of threads either in the app (hardcoded) or as a parameter (or, in the case of OpenMP, with the enviromental variable):
```sh
# For MPI + PThreads and MPI + OpenMP
srun --partition=<partition> --nodes=<num_nodes> --cpus-per-task=<num_cores> mpirun -np <num_processes> --oversubscribe main_mpi_pt_omp.out [app_args]
```

With MPI, it's possible to run multi-threaded apps with multiple nodes. Just be aware that a process should only spawn as many threads as the cluster configuration allows. For instance, in the partition student, a process should spawn only up to 8 threads, and not, say, 16: this would incur in performance degradation.

As a guideline, we suggest that the total number of threads $t_{\text{total}}$ should always be less or equal than the number of requested nodes $n_{\text{nodes}}$ times the number of requested cores per node $t_{\text{per node}}$:

$$t_{\text{total}} \leq n_{\text{nodes}} \cdot t_{\text{per node}}$$