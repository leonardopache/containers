# Headless MetaTrader5 + Python + Wine (WIP)

The goal of this image is create an environment where is possible to run python application with MT5 in Linux container. 
Detail of the image:
- Docker container with Ubuntu 18.04
- Wine 7.x
- Gecko 
- Mono
- Winetricks
- Python 3.9.9

This is a WorkInProgress image definition and use as base from [nevmerzhitsky/headless-metatrader4](https://github.com/nevmerzhitsky/headless-metatrader4)

## Configure the host system

A user in the image who runs MetaTrader app has UID 1000 (you can change it by `--build-arg USER_ID=NNNN` of `docker build`), so you may need to create a user in the host OS to map with it. Let's name it "monitor" for example. The user should be in docker group to run the container.

```bash
useradd -u 1000 -s /bin/bash -mU monitor
adduser monitor docker
```

## Prepare distribution with MetaTrader 4

1. For now, this image isn't works with portable version so it's needed to install MT5 windows version and copy the content to a host folder. 
2. After build the image it'll contain (Wine, Xvfb, vnc, Python3.9)

## Run the container

Use a user with the same `$USER_ID`:

Or do it by root but add `--user 1000` parameter to command.
```bash
docker run -it --env-file=.env \
    -v <FOLDER-SCREENSHOTS>:/tmp/screenshots \
    -v <FOLDER-MT5>:/home/winer/.wine/drive_c/users/winer/AppData/Local/Programs/mt5 \
    -v <PYTHON-REPO>:/home/winer/git/algo-trade \
    -p 5901:5900 \ 
    <IMAGE>:<TAG>
```

Without `--cap-add=SYS_PTRACE` parameter you will can't attach any EA to chart and run any script. (I think this is due to checking for any debugger attached to the terminal - protection from sniffing by MetaQuotes.) If your EA/script doesn't work even with `--cap-add=SYS_PTRACE` then replace it with `--privileged` parameter and try again. But this decrease security thus do it at your own risk! Instead of this, you can investigate which `--cap-add` values will fix you EA/script.

A base image is Ubuntu, therefore if you want to debug the container then add `--entry-point bash` parameter to the `docker run` command.

## Monitor the terminal

If you need to check visually what your MetaTrader terminal doing, you have several options.

### Screenshots

The first option is a built-in script which takes a screenshot of the Xvfb screen. Add `-v /path/to/screenshots/dir:/tmp/screenshots` parameter to `docker run` command then run this command: `docker exec <CONTAINER_ID> /docker/screenshot.sh`. By default, the name of the screenshot is current time in the container, but you can override it by the first argument of screenshot.sh: `docker exec <CONTAINER_ID> /docker/screenshot.sh my-screenshot`.

### VNC server

The second option is setup VNC server in the container and connect to the container via VNC client. This gives you the ability to manipulate the terminal as a usual desktop app.

You can use `docker exec <CONTAINER_ID> /docker/run_vnc.sh`


You should publish 5100 port by adding `-p 5900:5900` parameter to `docker run`. Note that anybody can connect to 5900 port because x11vnc configured without a password. Google to understand how to protect and secure your VNC connection.

### X Window System of the host

The Xvfb is activated by default 

## Known issues

- Fix the necessity to open the MT5 before run the python app.
- Migrate to a complete background execution without any user interaction.
