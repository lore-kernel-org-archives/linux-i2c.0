From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/2] i2c/acpi: Support for multiple serial bus addresses
Date: Fri,  5 Sep 2014 08:21:04 -0700
Message-ID: <1409930466-31746-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The ACPI spec allows multiple i2c addresses for a single device. This
series addresses the implementation of this support in core i2c for ACPI
enumeration.

v2
Restructured based on 3.17.rc3 as acpi i2c part has been moved out of i2c-core.

v1
Create an i2c device for the first valid i2c address which is not a
SMBus reserved address and let the first enumerated driver use the other
defined addresses by providing helper function to retrieve them.

v0
Sent on Mar 6, 2014
This patchset create an i2c device at every specified i2c serial bus
address.
[PATCH 1/2] i2c/ACPI: Support for multiple serial bus addresses



Mika Westerberg (1):
  i2c / ACPI: Add support for extracting multiple I2C addresses

Srinivas Pandruvada (1):
  i2c / ACPI: Create device on a valid first address

 drivers/i2c/i2c-acpi.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c |  61 +++++++++++++++++++++
 include/linux/i2c.h    |   8 +++
 3 files changed, 212 insertions(+)

-- 
1.9.3
