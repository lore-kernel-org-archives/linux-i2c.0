From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/4] i2c-designware: add Intel Lynxpoint support
Date: Thu, 17 Jan 2013 12:31:03 +0200
Message-ID: <1358418667-4533-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

This series adds support for the Intel Lynxpoint Low Power Subsystem I2C
controllers. They are compatible with the DesignWare I2C controller.

Patches [1/4] and [2/4] are fixes that are necessary to get the driver
working on Lynxpoint.

Patch [3/4] brings minimal runtime PM support for the designware platform
driver. This is useful if the PM subsystem/domain implements runtime PM,
like in case of ACPI.

Patch [4/4] finally implements ACPI enumeration support for the designware
platform driver and adds Lynxpoint ACPI IDs.

Please review.

Mika Westerberg (4):
  i2c-designware: add missing MODULE_LICENSE
  i2c-designware: always set the STOP bit after last byte
  i2c-designware: add minimal support for runtime PM
  i2c-designware: add support for Intel Lynxpoint

 drivers/i2c/busses/i2c-designware-core.c    |   20 ++++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c |   59 +++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 5 deletions(-)

-- 
1.7.10.4
