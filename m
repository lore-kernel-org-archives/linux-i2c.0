From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Wed,  4 May 2016 16:14:40 +0100
Message-ID: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36033 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbcEDPPG (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 4 May 2016 11:15:06 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, javier@osg.samsung.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com, Kieran Bingham <kieran@ksquared.org.uk>

This patch set finally pops up again, after a long time stuck somewhere in the
midst of my stack.

As it stood last year, the requirements were to rename probe2 to probe_new, and
ensure that it was correctly tested. The rename was the easy bit, but the
testing took me more time to get things set up properly. And other commitments
then got in the way of things. Of course this patch set has also been rebased
as well, but there wasn't any major pain there.

Testing
-------

To try to establish testing, I have used a beagle-bone-black, and a DS1307 RTC
connected to the BBB SCL and SDA lines. The main reason for these choices is
accesibility. i.e. I have them, and the BBB readily boots a kernel for me to
test and iterate with.

I've tested the device with i2cdetect, and then worked through testing the
sysfs interface, device tree, and module autoloading, each time ensuring that
the RTC enumerates and operates

* new_device (built-in, and external module)
  echo ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
  cat /sys/class/rtc/rtc0/date

 - Both of those worked fine.

* Device Tree
  I tested that the device would still register by adding a node in the device
  tree for the board, and testing with a built-in module. 

 - This worked fine.

* Module Autoloading
  With the device tree node in the board dts file, it wouldn't automatically
  load from the external module. This was due to the rtc-ds1307 module not
  exporting an of_match table, and not yet having Javier's "report OF style
  modalias when probing using DT" [0]  patch applied

 - With the module updated, and Javiers patch applied, the module autoloads

Finally, I feel I can safely add this tag to the patch set:
Tested-by: Kieran Bingham <kieran@bingham.xyz>

Please let me know if there is any other specific use case missing here that
needs to be tested.

[0] https://patchwork.ozlabs.org/patch/502201/

Patches
-------
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

 drivers/i2c/i2c-core.c      | 75 +++++++++++++++++++++++++++++++++++++++------
 drivers/mfd/88pm860x-core.c |  5 ++-
 drivers/mfd/as3722.c        | 12 ++------
 include/linux/i2c.h         | 22 ++++++++++++-
 4 files changed, 91 insertions(+), 23 deletions(-)

-- 
2.5.0
