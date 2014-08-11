From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/2] i2c/acpi: Support for multiple serial bus addresses
Date: Mon, 11 Aug 2014 14:28:53 -0700
Message-ID: <1407792535-21681-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The ACPI spec allows multiple i2c addresses for a single device. This
series addresses the implementation of this support in core i2c for ACPI
enumeration.

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

 drivers/i2c/i2c-core.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |   5 ++
 2 files changed, 211 insertions(+)

-- 
1.7.11.7
