#Setup
1) Install WSL2 https://learn.microsoft.com/en-us/windows/wsl/install-manual and Docker desktop https://www.docker.com/products/docker-desktop/.

2) Clone the repo from within WSL terminal, cd into project directory.

3) run 'docker build -t docker-spark-env .'
       'docker run -p 8888:8888 -v /mnt/c/users/INSERT-YOUR-USERNAME:/app docker-spark-env' where your username is your windows username. This mounts your windows home directory to the jupyter server so your files will persist. Anything written to the container itself is volatile.

4) Access the notebook in a browser from http://localhost:8888/tree?token=INSERT-YOUR-TOKEN where your token is taken from the terminal output, it should look something like this: 1622b38d00299b7e98eabc6089520fe82e487076612a54eb

It is also possible to connect to the jupyter server from any ide that supports it.
