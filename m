From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3] runtime PM support for I2C adapter devices
Date: Mon, 30 Sep 2013 17:43:47 +0300
Message-ID: <1380552228-23329-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

This is third revision of the patch. The previous version can be found
here: 
	http://lwn.net/Articles/566234/

It was pointed out that the previous solution was not good for the existing
devices for several reasons:
 - The I2C adapter is powered on before client ->probe() is called. This
   causes problems with some devices.
 - The I2C adapter is kept powered on if any of its children are active.

However, for ACPI enumerated devices we need to have parent child
relationship so that the runtime PM core can power on the adapter device if
any of its children become active.

In this version we still enable runtime PM for the I2C adapter device but
only for devices that are enumerated from ACPI. The existing drivers should
continue to work as they do today.

I combined patches [1/9] and [2/9] from the previous version and added
checks for ACPI_HANDLE(). I hope Aaron and Lv are OK with this.

I didn't include changes to the SPI bus (the $subject is changed again to
reflect that) because we don't need to change the existing drivers anymore.
If this approach is accepted we can do the same for the SPI bus as well.

Mika Westerberg (1):
  i2c: enable runtime PM for I2C adapter devices enumerated from ACPI

 drivers/i2c/i2c-core.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

-- 
1.8.4.rc3
