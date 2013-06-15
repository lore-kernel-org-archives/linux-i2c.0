From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] i2c: nomadik: allocate adapter number dynamically
Date: Sat, 15 Jun 2013 22:38:14 +0200
Message-ID: <1371328694-2073-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Nomadik I2C was using a local atomic counter to number
the I2C adapters. This does not work on configurations where
you also add, say a GPIO bit-banged adapter to the system.
They will start to conflict about being adapter 0.

There is no reason to use the numbered adapter function, and
the semantic effect on systems with only Nomadik I2C blocks
will be none - instead of increasing the number atomically
in the driver itself, it is done in the I2C core.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Drop the default assignment if -1 to adap->nt as we're now
  using i2c_add_adapter().
---
 drivers/i2c/busses/i2c-nomadik.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 9f1423a..063e726 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/amba/bus.h>
-#include <linux/atomic.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
@@ -981,8 +980,6 @@ static void nmk_i2c_of_probe(struct device_node *np,
 		pdata->sm = I2C_FREQ_MODE_FAST;
 }
 
-static atomic_t adapter_id = ATOMIC_INIT(0);
-
 static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret = 0;
@@ -1095,10 +1092,8 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo	= &nmk_i2c_algo;
 	adap->timeout	= msecs_to_jiffies(pdata->timeout);
-	adap->nr = atomic_read(&adapter_id);
 	snprintf(adap->name, sizeof(adap->name),
-		 "Nomadik I2C%d at %pR", adap->nr, &adev->res);
-	atomic_inc(&adapter_id);
+		 "Nomadik I2C at %pR", &adev->res);
 
 	/* fetch the controller configuration from machine */
 	dev->cfg.clk_freq = pdata->clk_freq;
@@ -1113,7 +1108,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		 "initialize %s on virtual base %p\n",
 		 adap->name, dev->virtbase);
 
-	ret = i2c_add_numbered_adapter(adap);
+	ret = i2c_add_adapter(adap);
 	if (ret) {
 		dev_err(&adev->dev, "failed to add adapter\n");
 		goto err_add_adap;
-- 
1.8.1.4
