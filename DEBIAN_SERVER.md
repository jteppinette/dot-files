Raid Monitoring
===============

#### HP Smart Array

**Verified Devices**
- HP ProLiant DL360 G6

**Install**
```
$ sudo apt install cciss-vol-status lsscsi
```

**Docs**
```
$ man cciss_vol_status
```

**Execution**

First, you must determine which device is mapped to the RAID controller.

Here is an example where the controller ID `0:3:0:0` is mapped to the device `/dev/sg1`.
For additional details, refer to the man page listed above.
```
# Find the ID of the controller
$ sudo lssci
...
... /sys/class/scsi_generic/sg1 -> .../target/0:3:0/0:3:0:0/scsi_generic/sg1
...

# Match the ID with the listed device
$ ls -l /sys/class/scsi_generic/*
...
[0:3:0:0] storage HP p410i 3.0.0 -
...
```

With the device name, **/dev/sg1**, you can now pull the status of the controller:
```
$ sudo cciss_vol_status /dev/sg1
...
```

The `-V` (verbose) flag can be used to print status information on each drive.

**Notes**
* My system is currently returning a non-zero (1) exit code.
I believe this is due to the write cache being disabled, because all drives are reporting
a status of (OK). I will attempt to enable the write cache and re-run.

**Automatic Monitoring**

Additional information on adding an appropriate cron job to monitor the drives
should be added here.
