TODO:
    - [ ] Sample code using the `MPI` library (with `OpenMPI`)
    - [ ] Multi-threading with [`OpenMP`](https://www.openmp.org) and `std::threads`

## Requirements

- Vagrant
- Docker
- VirtualBox or QEMU

## Workflow

1. Create and provision a new VM.

```sh
vagrant up
```

2. Sync the local directory with the VM. This will block the terminal, so it's better to run it in a separate terminal. Do not close this terminal.

```sh
vagrant rsync-auto
```

3. SSH into the VM. This needs to be done in a separate terminal.

```sh
vagrant ssh
```

4. Change to the synced directory.

```sh
cd ~/workspace
```

5. Generate the build files.

```sh
cmake -S . -B ../build
```

6. Build the project. It could take a while.

```sh
(cd ../build && make)
```

7. Log off from the VM. This will bring back your local shell.

```sh
exit
```

8. Copy the binary to the local machine.

```sh
vagrant scp default:/home/vagrant/build/apps/hpc-lab docker/build/hpc-lab
```

9. Make the binary executable.

```sh
chmod +x docker/build/hpc-lab
```

10. Run the docker-compose file.

```sh
docker-compose up
```

11. Run the file in leader using mpi.

```sh
docker exec docker-leader-1 mpiexec -n 3 -host docker-leader-1,docker-follower-1,docker-follower-2 /shared/hpc-lab
```

The last command will run the binary in the leader container with 3 processes, 1 in the leader container and 1 in each of the follower containers.
