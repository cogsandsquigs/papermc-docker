# papermc
# papermc-docker

A container for running a PaperMC Minecraft server

## Files

The server location is at `/minecraft/server`, and contains the world folders, plugin folders, etc. Essentially contains
everything that the server creates to run itself.

## Configuration

Configuration is done via environment variables and build arguments.

### Environment Variables

| Name   | Description                                                                                              | Required                |
| ------ | -------------------------------------------------------------------------------------------------------- | ----------------------- |
| `EULA` | Whether or not you accept the Minecraft EULA. `TRUE` if you do, `FALSE` if you don't.                    | No, defaults to `FALSE` |
| `MEM`  | Sets the total memory that can be used.Is a number ending with either `G` (gigabytes) or `M` (megabytes) | No, defaults to `4G`    |

### Build Arguments

| Name            | Description                                             | Required                 |
| --------------- | ------------------------------------------------------- | ------------------------ |
| `MINECRAFT_VER` | The version of Minecraft to play on                     | No, defaults to `1.21.1` |
| `PAPER_BUILD`   | The build of PaperMC to use for `MINECRAFT_VER`         | No, defaults to `57`     |
| `JAVA_VER`      | The version of Java OpenJDK to use with `MINECRAFt_VER` | No, defaults to `21`     |
