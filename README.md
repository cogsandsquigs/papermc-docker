# papermc-docker

A container for running a PaperMC Minecraft server.

## Running

This container uses Alpine Linux, but it should work as normal regardless. If there are any issues, please don't
hesitate to reach and create an issue.

> [!NOTE]
> By default, Spark is disabled due to it crashing on Alpine.

### Ports

Ports exposed are listed below

| Port  | Description             |
| ----- | ----------------------- |
| 25565 | Minecraft protocol port |
| 25575 | RCON protocol port      |

## Configuration

Program configuration is done via environment variables and build arguments. PaperMC configuration is described below:

### PaperMC

The server location is at `/minecraft`, and contains the world folders, plugin folders, datapack folders, mod folders, etc. Essentially contains
everything that the server creates to run itself.

### Environment Variables

| Name        | Description                                                                                              | Required                |
| ----------- | -------------------------------------------------------------------------------------------------------- | ----------------------- |
| `EULA`      | Whether or not you accept the Minecraft EULA. `TRUE` if you do, `FALSE` if you don't.                    | No, defaults to `FALSE` |
| `MEM`       | Sets the total memory that can be used.Is a number ending with either `G` (gigabytes) or `M` (megabytes) | No, defaults to `4G`    |
| `RCON`      | Enable RCON protocol from within the minecraft server (required for backups)                             | No, set by default      |
| `RCON_PASS` | The password for the RCON protocol. If empty, RCON is disabled                                           | Only if `RCON` is set   |

### Build Arguments

| Name            | Description                                             | Required                 |
| --------------- | ------------------------------------------------------- | ------------------------ |
| `MINECRAFT_VER` | The version of Minecraft to play on                     | No, defaults to `1.21.1` |
| `PAPER_BUILD`   | The build of PaperMC to use for `MINECRAFT_VER`         | No, defaults to `57`     |
| `JAVA_VER`      | The version of Java OpenJDK to use with `MINECRAFt_VER` | No, defaults to `21`     |
