# papermc

A container for running a papermc Minecraft server

## Files

The server location is at `/minecraft/server`, and contains the world folders, plugin folders, etc. Essentially contains
everything that the server creates to run itself.

## Configuration

Configuration is done via environment variables.

| Name   | Description                                                                                               | Required                |
| ------ | --------------------------------------------------------------------------------------------------------- | ----------------------- |
| `EULA` | Whether or not you accept the Minecraft EULA. `TRUE` if you do, `FALSE` if you don't.                     | No, defaults to `FALSE` |
| `MEM`  | Sets the total memory that can be used. Is a number ending with either `G` (gigabytes) or `M` (megabytes) | No, defaults to `4G`    |
