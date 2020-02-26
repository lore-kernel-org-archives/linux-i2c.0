From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/3] i2c: i801: Fix iTCO_wdt resource creation if PMC is not present
Date: Wed, 26 Feb 2020 16:21:19 +0300
Message-ID: <20200226132122.62805-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

This series aims to fix the issue reported by Martin Volf [1] that prevents
the nct6775 driver from loading.

I added Fixes tag to the last patch but not stable tag because the other
two patches it depends are not really stable material IMO. Please let me
know if there is a better way to organize these :)

I tested this on Intel Whiskey Lake based system (CNL derived) and on Comet
Lake-V based system (SPT derived and the iTCO_wdt still works and I can see
the expected resources in /proc/ioports and /proc/iomem.

The previous version of the patch series can be found here:

  https://lore.kernel.org/linux-hwmon/20200225123802.88984-1-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org/

Changes from the previous version:

  * Call request_region() also for iTCO_vendorsupport
  * Drop the core populating ICH_RES_IO_SMI completely from i2c-i801.c

[1] https://lore.kernel.org/linux-hwmon/CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/

Mika Westerberg (3):
  watchdog: iTCO_wdt: Export vendorsupport
  watchdog: iTCO_wdt: Make ICH_RES_IO_SMI optional
  i2c: i801: Do not add ICH_RES_IO_SMI for the iTCO_wdt device

 drivers/i2c/busses/i2c-i801.c          | 45 +++++++-------------------
 drivers/watchdog/iTCO_vendor.h         |  2 ++
 drivers/watchdog/iTCO_vendor_support.c | 16 +++++----
 drivers/watchdog/iTCO_wdt.c            | 28 +++++++++-------
 4 files changed, 39 insertions(+), 52 deletions(-)

-- 
2.25.0
