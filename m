From: Raymond Tan <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] i2c: designware: Add support for Intel Quark X1000
Date: Wed,  3 Sep 2014 10:41:37 +0800
Message-ID: <1409712098-13997-1-git-send-email-raymond.tan@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Tan, Raymond" <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Hi,
This patch is for enabling support of Intel Quark X1000 i2c controller. The
Quark designware i2c controller is registered as a MFD device, and Quark
exports a single PCI device with both I2C and GPIO functions.

In Quark, there is currently no other configuration mechanism other than
board files to configure the I2C mode for the the controller.

This patch is built upon the changes made by Romain Baeriswyl, titled
[PATCH V3 2/2] i2c designware add support of I2C standard mode, at
https://lkml.org/lkml/2014/3/25/135

Tan, Raymond (1):
  i2c: designware: add support of platform data to set I2C mode

 drivers/i2c/busses/i2c-designware-platdrv.c  |    6 ++++++
 include/linux/platform_data/i2c-designware.h |   21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/linux/platform_data/i2c-designware.h

-- 
1.7.9.5
