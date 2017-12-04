From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Mon,  4 Dec 2017 13:36:37 +0100
Message-ID: <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44202 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752837AbdLDMhe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 07:37:34 -0500
In-Reply-To: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>

This will be needed when we want to create STOP conditions, too, later.
Create the needed fields and populate them for the GPIO case if the GPIO
is set to output.

Cc: Phil Reid <preid@electromag.com.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 11 ++++++++++-
 include/linux/i2c.h         |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index bb34a5d4113331..f4313801a0aaba 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
@@ -147,6 +148,11 @@ static int get_sda_gpio_value(struct i2c_adapter *adap)
 	return gpiod_get_value_cansleep(adap->bus_recovery_info->sda_gpiod);
 }
 
+static void set_sda_gpio_value(struct i2c_adapter *adap, int val)
+{
+	gpiod_set_value_cansleep(adap->bus_recovery_info->sda_gpiod, val);
+}
+
 /*
  * We are generating clock pulses. ndelay() determines durating of clk pulses.
  * We will generate clock with rate 100 KHz and so duration of both clock levels
@@ -225,8 +231,11 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 	if (bri->scl_gpiod && bri->recover_bus == i2c_generic_scl_recovery) {
 		bri->get_scl = get_scl_gpio_value;
 		bri->set_scl = set_scl_gpio_value;
-		if (bri->sda_gpiod)
+		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
+			if (gpiod_get_direction(bri->sda_gpiod) == GPIOF_DIR_OUT)
+				bri->set_sda = set_sda_gpio_value;
+		}
 		return;
 	}
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 8a020617b4e780..c3e402e647791c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -551,6 +551,9 @@ struct i2c_timings {
  * @get_sda: This gets current value of SDA line. Optional for generic SCL
  *      recovery. Populated internally, if sda_gpio is a valid GPIO, for generic
  *      GPIO recovery.
+ * @set_sda: This sets/clears the SDA line. Optional for generic SCL recovery.
+ *	Populated internally, if sda_gpio is a valid GPIO, for generic GPIO
+ *	recovery.
  * @prepare_recovery: This will be called before starting recovery. Platform may
  *	configure padmux here for SDA/SCL line or something else they want.
  * @unprepare_recovery: This will be called after completing recovery. Platform
@@ -564,6 +567,7 @@ struct i2c_bus_recovery_info {
 	int (*get_scl)(struct i2c_adapter *adap);
 	void (*set_scl)(struct i2c_adapter *adap, int val);
 	int (*get_sda)(struct i2c_adapter *adap);
+	void (*set_sda)(struct i2c_adapter *adap, int val);
 
 	void (*prepare_recovery)(struct i2c_adapter *);
 	void (*unprepare_recovery)(struct i2c_adapter *);
-- 
2.11.0
