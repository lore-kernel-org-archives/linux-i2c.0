From: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] i2c: designware-pci: extra features for PCI mode LPSS I2C
Date: Fri,  7 Mar 2014 22:12:49 +0800
Message-ID: <1394201571-11681-1-git-send-email-chiau.ee.chew@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

These two patches contains the additional changes required for BayTrail LPSS
I2C on top of the patch that Mika Westerberg has submitted previously which
is still in the pending queue:
"[PATCH v2] i2c: designware-pci: Add Baytrail PCI IDs"
http://www.spinics.net/lists/linux-i2c/msg14709.html

Basically, the changes inclusive of:
i.	enable the pci glue layer to pass in target HCNT, LCNT
	and SDA hold time values to core layer if they are known
	beforehand, eg: for BayTrail.
ii.	declare the BayTrail LPSS I2C controllers are capable of
	supporting 10-bit addressing mode functionality.

Chew, Chiau Ee (2):
  i2c: designware-pci: add 10-bit addressing mode functionality for BYT
    I2C
  i2c: designware-pci: set ideal HCNT, LCNT and SDA hold time value

 drivers/i2c/busses/i2c-designware-pcidrv.c |   51 ++++++++++++++++++++++++---
 1 files changed, 45 insertions(+), 6 deletions(-)

-- 
1.7.4.4
