# Gymnasium & Box2D Docker Container
A fully configured Docker-based development environment for Farama Gymnasium (the improved fork of OpenAI Gym) and Box2D (for physics-based simulation and GUI rendering). This setup includes VcXsrv for forwarding graphical outputs to Windows systems and integrates seamlessly with VSCode Dev Containers. The environment ensures smooth development, testing, and interaction with both visual and physical simulations, making it ideal for machine learning and robotics projects that require rendering and simulation.
## Features:
- Preconfigured **Docker** container for Gymnasium and Box2D environments.
- **VcXsrv** setup for GUI support on Windows, allowing seamless integration with VSCode Dev Containers.
- Works with **X11 forwarding** for Linux-based systems.
- Automatically mounts the `src` folder between the local and container environments for persistent development.

---

## Prerequisites

Before starting, ensure you have the following installed on your system:

1. [Docker Desktop](https://www.docker.com/products/docker-desktop) - for running containers.
2. [Visual Studio Code](https://code.visualstudio.com/) - for using dev containers.
3. [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) - for managing Docker containers.
4. [Dev Containers Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) - for development inside containers.

---

## Steps to Run:

### 1. Install Docker Desktop and Visual Studio Code

- Download **Docker Desktop** from [here](https://www.docker.com/products/docker-desktop).
- Download and install **Visual Studio Code** from [here](https://code.visualstudio.com/Download).

### 2. Install the Required VSCode Extensions

Install the following extensions from within Visual Studio Code:
- [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
- [Dev Containers Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 3. Set Up VcXsrv for Windows or X11 Forwarding for Linux

#### Windows Systems:
- Run the `install_and_start_vcxsrv.bat` script to install **VcXsrv**, add it to the PATH, and set up the `DISPLAY` environment variable using your local IPv4 address.
    - This batch script will also handle restarting VcXsrv if it's already running.
    - **VcXsrv** is essential for forwarding graphical interfaces from the container to your Windows environment.
  
#### Linux Systems:
- Run the `x11_forwarding_linux.sh` script to configure **X11 forwarding** on Linux-based systems.

### 4. Open the Repository in a Dev Container

1. Launch Visual Studio Code and open this repository.
2. Press `Ctrl + Shift + P` to bring up the VSCode command palette and select `Remote-Containers: Reopen in Container`.
    - This will automatically:
      - Copy the `src` folder to the Docker container’s workspace.
      - Mount the folder to your local storage, ensuring that changes inside the dev container are reflected locally.
      - Link to **VcXsrv** (for Windows) or use X11 forwarding (for Linux) to forward display output.

### 5. Using the Development Environment

- Once the container is up and running, you can use the pre-installed Gymnasium and Box2D libraries.
- Any changes made to the `src` folder within the container will persist on your local filesystem.

---

## Troubleshooting

### Common Installation Issues
- If Docker is not starting or encountering permission issues, refer to the official [Docker troubleshooting guide](https://docs.docker.com/docker-for-windows/troubleshoot/).
- For Visual Studio Code extension installation issues, consult the [VSCode Dev Containers documentation](https://code.visualstudio.com/docs/remote/containers).

### Graphical Output Issues on Windows
- Ensure **VcXsrv** is running and that the `DISPLAY` environment variable is correctly set.
  - You can verify this by running the `xclock` command in the container to check if the clock GUI is displayed on your Windows machine.
- If the display is not working, refer to the [VcXsrv setup guide](https://sourceforge.net/projects/vcxsrv/) for additional setup tips.

---

## Links

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
- [Dev Containers Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [VcXsrv Installation Guide](https://sourceforge.net/projects/vcxsrv/)
- [Gymnasium Documentation](https://gymnasium.farama.org/)
- [Box2D Documentation](https://box2d.org/documentation/)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.