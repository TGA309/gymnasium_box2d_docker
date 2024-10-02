# Gymnasium & Box2D Docker Container

A fully configured Docker-based development environment for Farama Gymnasium (the improved fork of OpenAI Gym) and Box2D (for physics-based simulation and GUI rendering). This setup includes VcXsrv for forwarding graphical outputs to Windows systems and integrates seamlessly with VSCode Dev Containers. The environment ensures smooth development, testing, and interaction with both visual and physical simulations, making it ideal for machine learning and robotics projects that require rendering and simulation.

## Features:

-   Preconfigured **Docker** container for Gymnasium and Box2D environments.
-   **VcXsrv** setup for GUI support on Windows, allowing seamless integration with VSCode Dev Containers.
-   Works with **X11 forwarding** for Linux-based systems.
-   Automatically mounts the `src` folder between the local and container environments for persistent development.

---

## Prerequisites

Before starting, ensure you have the following installed on your system:

1. [Docker Desktop](https://www.docker.com/products/docker-desktop) - for running containers. It is recommended to use **Docker Desktop with WSL2** (Windows Subsystem for Linux 2) for improved performance and better integration with Linux-based containers. Follow the official [Docker WSL2 setup guide](https://docs.docker.com/desktop/windows/wsl/) for more information.
2. [Visual Studio Code](https://code.visualstudio.com/) - for using dev containers.
3. [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) - for managing Docker containers.
4. [Dev Containers Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) - for development inside containers.

---

## Steps to Run:

### 1. Install Docker Desktop and Visual Studio Code

-   Download **Docker Desktop** from [here](https://www.docker.com/products/docker-desktop).
    -   **For Windows users**, it is recommended to use **WSL2** (Windows Subsystem for Linux 2) with Docker Desktop for better performance. You can follow the [Docker WSL2 setup guide](https://docs.docker.com/desktop/windows/wsl/) to install and configure WSL2.
-   Download and install **Visual Studio Code** from [here](https://code.visualstudio.com/Download).

### 2. Install the Required VSCode Extensions

Install the following extensions from within Visual Studio Code:

-   [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
-   [Dev Containers Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 3. Set Up VcXsrv for Windows or X11 Forwarding for Linux

#### Windows Systems:

-   Run the `install_and_start_vcxsrv.bat` script as an **Administrator** to automatically install **VcXsrv**, add it to your user PATH, and configure the `DISPLAY` environment variable using your local IPv4 address.
    -   Ensure that you run this script from the Windows Terminal or Command Prompt, rather than using extensions like VSCode's batch runner, as these might cause unexpected issues.
    -   The script also handles restarting VcXsrv if it is already running.
    -   **VcXsrv** is required to forward graphical interfaces from the Docker container to your Windows environment.

#### Linux Systems:

-   Run the `x11_forwarding_linux.sh` script to configure **X11 forwarding** on Linux-based systems.

### 4. Open the Repository in a Dev Container

1. Launch Visual Studio Code and open this repository. Ensure that Docker Desktop is running, as the Docker Engine must be active before proceeding.
2. Press `Ctrl + Shift + P` to bring up the VSCode command palette and select `Dev Containers: Reopen in Container`.
    - This will automatically:
        - Copy the `src` folder to the Docker container’s workspace.
        - Mount the folder to your local storage, ensuring that changes inside the dev container are reflected locally.
        - Link to **VcXsrv** (for Windows) or use **X11 forwarding** (for Linux) to forward display output.

### 5. Using the Development Environment

-   Once the container is up and running, you can use the pre-installed Python 3.11.9 environment with Gymnasium and Box2D libraries.
-   Any changes made to the `src` folder within the container will persist on your local filesystem.
-   Whenever the repository is reopened as a Dev Container, any Python dependencies specified in `src/requirements.txt` will be automatically installed during the Docker container build process.

---

## Troubleshooting

### Common Installation Issues

-   If Docker is not starting or encountering permission issues, refer to the official [Docker troubleshooting guide](https://docs.docker.com/docker-for-windows/troubleshoot/).
-   For Visual Studio Code extension installation issues, consult the [VSCode Dev Containers documentation](https://code.visualstudio.com/docs/remote/containers).

### Graphical Output Issues on Windows

-   Ensure **VcXsrv** is running and that the `DISPLAY` environment variable is correctly set.
    -   You can verify this by running the `xclock` command in the container to check if the clock GUI is displayed on your Windows machine.
    -   If the `xclock` command is not available, you can install it by adding the `x11-apps` package in the system dependencies section of the `Dockerfile`.
-   The `install_and_start_vcxsrv.bat` (Windows) or `x11_forwarding_linux.sh` (Linux) scripts may sometimes retrieve an incorrect local IPv4 address, which can prevent the GUI from displaying, even though the program is running. To resolve this issue:
    1. Manually find your local IPv4 address by running:
        - `ipconfig` in the Windows Command Prompt / Terminal, or
        - `ifconfig` in the Linux Terminal.
    2. Update the `DISPLAY` environment variable in the `.env` file located in the project root with your correct IPv4 address before opening the project in a Dev Container. For example:  
       `DISPLAY=your_ipv4_address:0.0`
    3. If the above method does not work, try setting the `DISPLAY` variable in the `.env` file as:  
       `DISPLAY=:0`
    4. If the display is still not functioning, refer to the [VcXsrv support page](https://sourceforge.net/projects/vcxsrv/support) for further assistance.

---

## Links

-   [Docker Desktop](https://www.docker.com/products/docker-desktop)
-   [Docker WSL2 Support Guide](https://docs.docker.com/desktop/windows/wsl/)
-   [Visual Studio Code](https://code.visualstudio.com/)
-   [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
-   [Dev Containers Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
-   [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
-   [Gymnasium Documentation](https://gymnasium.farama.org/)
-   [Box2D Documentation](https://box2d.org/documentation/)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
