From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/3] ACPI power management support for I2C and SPI devices
Date: Wed,  9 Oct 2013 17:04:18 +0300
Message-ID: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

We originally tried to add runtime PM support for I2C adapter devices in
order to have runtime PM core to power on the I2C host controller device
automatically whenever any of its children I2C device is powered on (See
[1] for the last patch series).

The rationale was that it is what the ACPI 5.0 specification requires: the
parent device cannot be lower power states than its children.

However, it looks like Windows can put the I2C controller device to low
power states independently of its children power states, just like Linux
does.

This patch series only adds I2C and SPI devices to the ACPI power domain
and make sure that the parent device power state is ignored when
transitioning child device to a different power states.

Since patches [2-3/3] depend on patch [1/3] it would be good if these all
could be merged together.

[1] http://lwn.net/Articles/568961/

Lv Zheng (1):
  i2c: attach/detach I2C client device to the ACPI power domain

Mika Westerberg (2):
  ACPI / PM: allow child devices to ignore parent power state
  spi: attach/detach SPI device to the ACPI power domain

 drivers/acpi/device_pm.c |  8 +++++---
 drivers/i2c/i2c-core.c   | 10 ++++++++++
 drivers/spi/spi.c        | 20 ++++++++++++++++++--
 include/acpi/acpi_bus.h  |  3 ++-
 4 files changed, 35 insertions(+), 6 deletions(-)

-- 
1.8.4.rc3
