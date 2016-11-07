From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 00/11] i2c: Relax mandatory I2C ID table passing
Date: Mon,  7 Nov 2016 12:47:35 +0000
Message-ID: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Version 7 of this patchset performs a rebase to linux-4.9-rc4 and adjust
the usage of strncasecmps to sysfs_streq. I have also renamed the
function i2c_of_match_device_strip_vendor to i2c_of_match_device_sysfs
which feels more appropriate now.

Retested with successful usage of full compatible strings, and shortened
device id's based on the vendor prefix being stripped.

Wolfram, for your convenience this series is available as a tagged commit
at: https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/linux.git 
i2c-dt/v4.9-rc4-probe-conversion-v7, though this includes the TESTPATCH so
it is not by itself suitable for a merge.

Verifying the sysfs_streq usage can be seen below:

root@arm:~# ./new_i2c_device ds1307 0x68
ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
[  216.289958] rtc-ds1307 2-0068: rtc core: registered ds1307 as rtc0
[  216.296740] rtc-ds1307 2-0068: 56 bytes nvram
[  216.301534] i2c i2c-2: new_device: Instantiated device ds1307 at 0x68
root@arm:~# 
root@arm:~# cat /sys/class/rtc/rtc0/date 
2016-11-07
root@arm:~# cat /sys/class/rtc/rtc0/name 
ds1307
root@arm:~# ./delete_i2c_device 0x68
[  237.018514] i2c i2c-2: delete_device: Deleting device ds1307 at 0x68
root@arm:~# ./new_i2c_device maxim,ds1307 0x68
maxim,ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
[  243.346216] rtc-ds1307 2-0068: I'm a Maxim ... 
[  243.370115] rtc-ds1307 2-0068: rtc core: registered maxim,ds1307 as rtc0
[  243.377517] rtc-ds1307 2-0068: 56 bytes nvram
[  243.382343] i2c i2c-2: new_device: Instantiated device maxim,ds1307 at 0x68
root@arm:~# ./delete_i2c_device 0x68
[  263.897905] i2c i2c-2: delete_device: Deleting device maxim,ds1307 at 0x68
root@arm:~# ./new_i2c_device maxim,ds13072 0x68
maxim,ds13072 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
[  266.357120] i2c i2c-2: new_device: Instantiated device maxim,ds13072 at 0x68
root@arm:~# ./delete_i2c_device 0x68
[  268.966851] i2c i2c-2: delete_device: Deleting device maxim,ds13072 at 0x68
root@arm:~# ./new_i2c_device maxim,ds130 0x68
maxim,ds130 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
[  272.005528] i2c i2c-2: new_device: Instantiated device maxim,ds130 at 0x68
root@arm:~# ./delete_i2c_device 0x68
[  274.182360] i2c i2c-2: delete_device: Deleting device maxim,ds130 at 0x68
root@arm:~# ./new_i2c_device ds1307 0x68
ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
[  281.313329] rtc-ds1307 2-0068: rtc core: registered ds1307 as rtc0
[  281.320218] rtc-ds1307 2-0068: 56 bytes nvram
[  281.325043] i2c i2c-2: new_device: Instantiated device ds1307 at 0x68



Kieran Bingham (3):
  i2c: match dt-style device names from sysfs interface
  i2c: match vendorless strings on the internal string length
  [TESTPATCH] rtc: convert ds1307 to interim probe_new

Lee Jones (8):
  i2c: Add pointer dereference protection to i2c_match_id()
  i2c: Add the ability to match device to compatible string without an
    of_node
  i2c: Match using traditional OF methods, then by vendor-less
    compatible strings
  i2c: Make I2C ID tables non-mandatory for DT'ed devices
  i2c: Export i2c_match_id() for direct use by device drivers
  i2c: Provide a temporary .probe_new() call-back type
  mfd: 88pm860x: Move over to new I2C device .probe() call
  mfd: as3722: Rid driver of superfluous I2C device ID structure

 drivers/i2c/i2c-core.c      | 84 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/mfd/88pm860x-core.c |  5 ++-
 drivers/mfd/as3722.c        | 12 ++-----
 drivers/rtc/rtc-ds1307.c    | 54 ++++++++++++++++-------------
 include/linux/i2c.h         | 22 +++++++++++-
 5 files changed, 131 insertions(+), 46 deletions(-)

-- 
2.7.4
