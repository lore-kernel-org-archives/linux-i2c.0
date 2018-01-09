From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue,  9 Jan 2018 14:58:56 +0100
Message-ID: <20180109135859.20771-4-wsa@the-dreams.de>
References: <20180109135859.20771-1-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180109135859.20771-1-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This will be needed when we want to create STOP conditions, too, later.
Create the needed fields and populate them for the GPIO case if the GPIO
is set to output.

Tested-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since V1:

* don't use GPIOF_* flags but hardocded '0'

 drivers/i2c/i2c-core-base.c | 11 ++++++++++-
 include/linux/i2c.h         |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index bb34a5d4113331..a8b3fbe16fa08c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -147,6 +147,11 @@ static int get_sda_gpio_value(struct i2c_adapter *adap)
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
@@ -225,8 +230,12 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 	if (bri->scl_gpiod && bri->recover_bus == i2c_generic_scl_recovery) {
 		bri->get_scl = get_scl_gpio_value;
 		bri->set_scl = set_scl_gpio_value;
-		if (bri->sda_gpiod)
+		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
+			/* FIXME: add proper flag instead of '0' once available */
+			if (gpiod_get_direction(bri->sda_gpiod) == 0)
+				bri->set_sda = set_sda_gpio_value;
+		}
 		return;
 	}
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fd87b806b5f165..419a38e7c315f1 100644
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
 
 	void (*prepare_recovery)(struct i2c_adapter *adap);
 	void (*unprepare_recovery)(struct i2c_adapter *adap);
-- 
2.11.0
