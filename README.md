# Containerized Spark Environment
This project started as a way to reproducably run spark jobs. While that basic functionality still remains, the project has expanded to provide the tools to host a remote jupyter server with a complete data science environment. In more recent iterations, capabilities have been added for Scikit-Learn, R, and SSH tunneling.

--------------------------------------------

## Setup

1. Ensure you have podman installed. If on Windows, WSL is also needed.

2. Clone the repo, cd into project directory.

3. Build the image `podman build -t docker-spark-env .`
       
4. Run the image `podman run -p 8888:8888 docker-spark-env`. Other usefull run options

       - SSH: `-p 2222:22` opens port 2222 for connecting to the container via SSH.
       - Mount Volume: `-v /path/to/local/volume:/app` add `:Z` if running into SElinux permissions issues.

5. Access the jupyter server using http://localhost:8888. If running remotely, replace local host with the IP address of the host.

-------------------------------------------

## Todo

- Add pytorch support *This will require changing from a pip managed environment to conda, a rework of the entire dockerfile*

- Add SQL support to run queries in cells and return results via a JDBC connection.