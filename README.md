# papermc-docker

A container for running a PaperMC Minecraft server.

## Running

This container uses Alpine Linux, but it should work as normal regardless (especially since `gcompat` is used in
conjunction). If there are any issues, please don't hesitate to reach and create an issue.

### Ports

Ports exposed are listed below

| Port  | Description             |
| ----- | ----------------------- |
| 25565 | Minecraft protocol port |
| 25575 | RCON protocol port      |

## Configuration

Program configuration is done via environment variables and build arguments. PaperMC configuration is described below:

### PaperMC

The server location is at `/data`, and contains the world folders, plugin folders, datapack folders, mod folders, etc. Essentially contains
everything that the server creates to run itself.

### Environment Variables

| Name            | Description                                                                                              | Required                   |
| --------------- | -------------------------------------------------------------------------------------------------------- | -------------------------- |
| `EULA`          | Whether or not you accept the Minecraft EULA. `TRUE` if you do, `FALSE` if you don't.                    | No, defaults to `FALSE`    |
| `MEM`           | Sets the total memory that can be used.Is a number ending with either `G` (gigabytes) or `M` (megabytes) | No, defaults to `4G`       |
| `RCON`          | Enable RCON protocol from within the minecraft server (required for backups). Either `true` or `false`.  | No, set by default         |
| `RCON_PASS`     | The password for the RCON protocol. If empty, RCON is disabled                                           | No, defaults to `pass`     |
| `BACKUPS`       | Whether or not to enable backups                                                                         | No                         |
| `NUM_BACKUPS`   | The number of backups to keep                                                                            | No, defaults to 3          |
| `BACKUP_CRON`   | Cron schedule for backups.                                                                               | No, default is `0 0 * * *` |
| `S3_ACCESS_KEY` | The access key for S3.                                                                                   | Only if `BACKUPS` is set   |
| `S3_SECRET_KEY` | The secret key for S3.                                                                                   | Only if `BACKUPS` is set   |
| `S3_ENDPOINT`   | The S3 endpoint to access the bucket to back up to.                                                      | Only if `BACKUPS` is set   |
| `S3_BUCKET`     | The S3 bucket to use for backups.                                                                        | Only if `BACKUPS` is set   |

### Build Arguments

| Name            | Description                                             | Required                 |
| --------------- | ------------------------------------------------------- | ------------------------ |
| `MINECRAFT_VER` | The version of Minecraft to play on                     | No, defaults to `1.21.1` |
| `PAPER_BUILD`   | The build of PaperMC to use for `MINECRAFT_VER`         | No, defaults to `64`     |
| `JAVA_VER`      | The version of Java OpenJDK to use with `MINECRAFt_VER` | No, defaults to `21`     |

## Administrating

Generally, you can run commands against the Minecraft server by either:

1. Running `/mc-cmd.sh <your-command-here>`
2. Manually running the contents of `/mc-cmd.sh`: `rcon -H localhost -p 25575 -P $RCON_PASS <your-command-here>`

Its recommended that you keep `RCON` set, and simply not expose port `25575` if you don't want RCON to be accessible. If
you do expose RCON, make sure to set $RCON_PASS to something secret (not `password`)!

If you do enable RCON, just know that you will not be able to run commands against the server.

Additionally, backups can be performed by setting the `BACKUPS` environment variable, and providing the associated S3 keys.
