From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c: remove i2c-intel-mid driver
Date: Fri, 28 Oct 2011 12:14:30 +0300
Message-ID: <cover.1319793150.git.andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In current linux-next we have new driver i2c-designware. So, this is just
removal of old driver.

Andy Shevchenko (1):
  i2c: remove i2c-intel-mid

 drivers/i2c/busses/Kconfig         |   10 -
 drivers/i2c/busses/Makefile        |    1 -
 drivers/i2c/busses/i2c-intel-mid.c | 1135 ------------------------------------
 3 files changed, 0 insertions(+), 1146 deletions(-)
 delete mode 100644 drivers/i2c/busses/i2c-intel-mid.c

-- 
1.7.7.1
