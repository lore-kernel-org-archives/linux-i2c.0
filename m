From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] i2c-mux: expose i2c bus topology under sysfs
Date: Wed, 13 Feb 2013 23:28:30 +0100
Message-ID: <1360794512-6338-1-git-send-email-gerlando.falauto@keymile.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: giometti-k2GhghHVRtY@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, holger.brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

I noticed that when you have multiple muxes connected to the same branch, implementation hides some information about the complete i2c topology.

So for instance if I have something like (notice there are three PCA9544's "in parallel", each with its own address, which I assume is a bit unusual):

#  CPU (i2c-0)
#  '--I2C Mux0 (PCA9547) @ 0x70
#      +--Port0 (i2c-1)
#      +--Port1 (i2c-2)
#      +--Port2 (i2c-3)
#      +--Port3 (i2c-4)
#      +--Port4 (i2c-5)
#      |   '--- I2C Mux1 (PCA9544) @ 0x74
#      |   |     +--Port0 (i2c-9)
#      |   |     +--Port1 (i2c-10)
#      |   |     +--Port2 (i2c-11)
#      |   |     '--Port3 (i2c-12)
#      |   +--- I2C Mux2 (PCA9544) @ 0x71
#      |   |     +--Port0 (i2c-13)
#      |   |     +--Port1 (i2c-14)
#      |   |     +--Port2 (i2c-15)
#      |   |     '--Port3 (i2c-16)
#      |   '--- I2C Mux3 (PCA9544) @ 0x72
#      |         +--Port0 (i2c-17)
#      |         +--Port1 (i2c-18)
#      |         +--Port2 (i2c-19)
#      |         '--Port3 (i2c-20)
#      +--Port5 (i2c-6)
#      +--Port6 (i2c-7)
#      '--Port7 (i2c-8)

under /sys/bus/i2c/devices/ I get:

0-0010 -> ../../../devices/platform/i2c-gpio/i2c-0/0-0010
0-0011 -> ../../../devices/platform/i2c-gpio/i2c-0/0-0011
0-0070 -> ../../../devices/platform/i2c-gpio/i2c-0/0-0070
5-0071 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/5-0071
5-0072 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/5-0072
5-0074 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/5-0074
|2c-0 -> ../../../devices/platform/i2c-gpio/i2c-0
i2c-1 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-1
i2c-2 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-2
i2c-3 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-3
i2c-4 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-4
i2c-5 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5
i2c-6 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-6
i2c-7 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-7
i2c-8 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-8
i2c-9 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-9
i2c-10 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-10
i2c-11 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-11
i2c-12 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-12
i2c-13 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-13
i2c-14 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-14
i2c-15 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-15
i2c-16 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-16
i2c-17 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-17
i2c-18 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-18
i2c-19 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-19
i2c-20 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-20

So I have no way of telling that:

 i2c-{9,10,11,12} are connected to mux1 at address 0x74 of i2c-5
 i2c-{13,14,15,16} are connected to mux2 at address 0x71 of i2c-5
 i2c-{17,18,19,20} are connected to mux3 at address 0x72 of i2c-5

because I get:

# cat /sys/bus/i2c/devices/i2c-9/name
i2c-5-mux (chan_id 0)
# cat /sys/bus/i2c/devices/i2c-13/name
i2c-5-mux (chan_id 0)

which only reveals i2c-9 is the bus segment connected to channel 0 of a mux behind i2c-5, but since there's two of them, I have no way to tell which one...

The first patch moves i2c-{n} devices under the mux device, so instead of:

/sys/class/i2c-dev/i2c-0/device/i2c-5/i2c-9
/sys/class/i2c-dev/i2c-0/device/i2c-5/i2c-10
/sys/class/i2c-dev/i2c-0/device/i2c-5/i2c-11
/sys/class/i2c-dev/i2c-0/device/i2c-5/i2c-12

you get:

/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-5/5-0071/i2c-9
/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-5/5-0071/i2c-10
/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-5/5-0071/i2c-11
/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-5/5-0071/i2c-12

The second one creates symlinks like:

/sys/class/i2c-dev/i2c-0/device/0-0070/channel-4 -> i2c-5
/sys/class/i2c-dev/i2c-0/device/0-0070/channel-4/5-0074/channel-0 -> i2c-9
/sys/class/i2c-dev/i2c-0/device/0-0070/channel-4/5-0074/channel-1 -> i2c-10
/sys/class/i2c-dev/i2c-0/device/0-0070/channel-4/5-0074/channel-3 -> i2c-11
/sys/class/i2c-dev/i2c-0/device/0-0070/channel-4/5-0074/channel-3 -> i2c-12

Gerlando Falauto (2):
  i2c-mux: create mux busses under a different parent device
  i2c-mux: create "channel-n" symlinks for child segments

 drivers/i2c/i2c-mux.c           |   20 +++++++++++++++++++-
 drivers/i2c/muxes/gpio-i2cmux.c |    2 +-
 drivers/i2c/muxes/pca9541.c     |    2 +-
 drivers/i2c/muxes/pca954x.c     |    2 +-
 include/linux/i2c-mux.h         |    1 +
 5 files changed, 23 insertions(+), 4 deletions(-)

-- 
1.7.10.1
