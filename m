From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 6/9] mfd: wm8994: convert to use I2C core runtime PM
Date: Wed, 11 Sep 2013 18:32:37 +0300
Message-ID: <1378913560-2752-7-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

The I2C core now prepares runtime PM on behalf of the I2C client device, so
only thing the driver needs to do is to call pm_runtime_put() at the end of
its ->probe().

This patch converts wm8994 driver to use this model.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mfd/wm8994-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 3fdee90..9928bb1 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -706,8 +706,7 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 		goto err_irq;
 	}
 
-	pm_runtime_enable(wm8994->dev);
-	pm_runtime_idle(wm8994->dev);
+	pm_runtime_put(wm8994->dev);
 
 	return 0;
 
@@ -723,7 +722,7 @@ err:
 
 static void wm8994_device_exit(struct wm8994 *wm8994)
 {
-	pm_runtime_disable(wm8994->dev);
+	pm_runtime_get(wm8994->dev);
 	mfd_remove_devices(wm8994->dev);
 	wm8994_irq_exit(wm8994);
 	regulator_bulk_disable(wm8994->num_supplies,
-- 
1.8.4.rc3
