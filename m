From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 1/2] i2c: Switch to using gpiod interface for gpio bus recovery
Date: Fri, 16 Jun 2017 15:42:56 +0800
Message-ID: <1497598977-37622-2-git-send-email-preid@electromag.com.au>
References: <1497598977-37622-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:42183 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752375AbdFPHnL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Jun 2017 03:43:11 -0400
In-Reply-To: <1497598977-37622-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

Currently the i2c gpio recovery code uses gpio integer interface
instead of the gpiod. This change switch the core code to use
the gpiod while still retaining compatibility with the gpio integer
interface. This will allow individual driver to be updated and tested
individual to switch to using the gpiod interface.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core-base.c | 22 ++++++++++++++++++----
 include/linux/i2c.h         |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 426e2e0..47a1b75 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -134,17 +134,17 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 /* i2c bus recovery routines */
 static int get_scl_gpio_value(struct i2c_adapter *adap)
 {
-	return gpio_get_value(adap->bus_recovery_info->scl_gpio);
+	return gpiod_get_value_cansleep(adap->bus_recovery_info->scl_gpiod);
 }
 
 static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
 {
-	gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
+	gpiod_set_value_cansleep(adap->bus_recovery_info->scl_gpiod, val);
 }
 
 static int get_sda_gpio_value(struct i2c_adapter *adap)
 {
-	return gpio_get_value(adap->bus_recovery_info->sda_gpio);
+	return gpiod_get_value_cansleep(adap->bus_recovery_info->sda_gpiod);
 }
 
 static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
@@ -159,6 +159,7 @@ static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
 		dev_warn(dev, "Can't get SCL gpio: %d\n", bri->scl_gpio);
 		return ret;
 	}
+	bri->scl_gpiod = gpio_to_desc(bri->scl_gpio);
 
 	if (bri->get_sda) {
 		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
@@ -168,6 +169,7 @@ static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
 			bri->get_sda = NULL;
 		}
 	}
+	bri->sda_gpiod = gpio_to_desc(bri->sda_gpio);
 
 	return ret;
 }
@@ -176,10 +178,13 @@ static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
 {
 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 
-	if (bri->get_sda)
+	if (bri->get_sda) {
 		gpio_free(bri->sda_gpio);
+		bri->sda_gpiod = NULL;
+	}
 
 	gpio_free(bri->scl_gpio);
+	bri->scl_gpiod = NULL;
 }
 
 /*
@@ -273,6 +278,15 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 		goto err;
 	}
 
+	if ((bri->scl_gpiod) &&
+	    (bri->recover_bus == i2c_generic_scl_recovery)) {
+		bri->get_scl = get_scl_gpio_value;
+		bri->set_scl = set_scl_gpio_value;
+		if (bri->sda_gpiod)
+			bri->get_sda = get_sda_gpio_value;
+		return;
+	}
+
 	/* Generic GPIO recovery */
 	if (bri->recover_bus == i2c_generic_gpio_recovery) {
 		if (!gpio_is_valid(bri->scl_gpio)) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 72d0ece..84802a2 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -509,6 +509,8 @@ struct i2c_bus_recovery_info {
 	/* gpio recovery */
 	int scl_gpio;
 	int sda_gpio;
+	struct gpio_desc *scl_gpiod;
+	struct gpio_desc *sda_gpiod;
 };
 
 int i2c_recover_bus(struct i2c_adapter *adap);
-- 
1.8.3.1
