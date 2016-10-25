From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv6 00/11] i2c: Relax mandatory I2C ID table passing
Date: Tue, 25 Oct 2016 17:41:44 +0100
Message-ID: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Version 6 of this patchset adds two new patches on top of the existing
submission to resolve the (final?) pending question from the previous
discussions during v5 [0]. Javier's tags are also collected here.

In particular, the remaining issue was that a user could provide a full
vendor prefixed string to the sysfs interface to instantiate an i2c
device. In version 5 of this submission this would not have matched
against a device driver as highlighted by the test patch provided by
Wolfram.

As such, in this series I have extended i2c_of_match_device_strip_vendor
so that it will also perform a search against a full compatible string
for the matching process. This was not done by the core OF framework as
the sysfs interface does not create an of_node to match against. If so
desired, this function could now be renamed to i2c_of_match_device_sysfs

Patch 11/11 of this series brings back Wolframs test case (correctly this
time) and also serves as a demonstration as to how to map the ID's when
matched against an of-style node. Note that this patch is *not* signed
off and not suitable for integration.

[0] [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
    https://lkml.org/lkml/2016/5/4/534

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

 drivers/i2c/i2c-core.c      | 85 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/mfd/88pm860x-core.c |  5 ++-
 drivers/mfd/as3722.c        | 12 ++-----
 drivers/rtc/rtc-ds1307.c    | 53 ++++++++++++++++------------
 include/linux/i2c.h         | 22 +++++++++++-
 5 files changed, 132 insertions(+), 45 deletions(-)

-- 
2.7.4
