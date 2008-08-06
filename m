From: Carlos Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
Subject: [PATCH 1/6] I2C: MENELAUS: Sync with linux-omap tree.
Date: Wed, 06 Aug 2008 14:00:48 -0400
Message-ID: <4899E6D0.6030203@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>

This patch synchronizes menelaus code with linux-omap tree.

Basically, this sync includes the following modifications on
menelaus code:

- i2c subsystem print error messages.
- Adds menelaus_enable_slot() function to enables/disables the mmc
  slots.
- Fix MMC slot 2 misconfiguration.
- Use dev_err() macro instead of pr_err() macro.
- Few clean-ups.

Also makes a modification at include/asm-arm/arch-omap/menelaus.h,
prototyping menelaus_enable_slot() function.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
---
 drivers/i2c/chips/menelaus.c         |   54 +++++++++++++++++++++++----------
 include/asm-arm/arch-omap/menelaus.h |    1 +
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index b36db17..18471b6 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -153,7 +153,7 @@ static int menelaus_write_reg(int reg, u8 value)
 	int val = i2c_smbus_write_byte_data(the_menelaus->client, reg, value);
 
 	if (val < 0) {
-		pr_err(DRIVER_NAME ": write error");
+		dev_err(&the_menelaus->client->dev, "write error");
 		return val;
 	}
 
@@ -165,7 +165,7 @@ static int menelaus_read_reg(int reg)
 	int val = i2c_smbus_read_byte_data(the_menelaus->client, reg);
 
 	if (val < 0)
-		pr_err(DRIVER_NAME ": read error");
+		dev_err(&the_menelaus->client->dev, "read error");
 
 	return val;
 }
@@ -313,6 +313,34 @@ out:
 }
 EXPORT_SYMBOL(menelaus_set_slot_sel);
 
+int menelaus_enable_slot(int slot, int enable)
+{
+	int ret, val;
+
+	mutex_lock(&the_menelaus->lock);
+	ret = menelaus_read_reg(MENELAUS_MCT_CTRL3);
+	if (ret < 0)
+		goto out;
+	val = ret;
+	if (slot == 1) {
+		if (enable)
+			val |= 1 << 0;
+		else
+			val &= ~(1 << 0);
+	} else {
+		if (enable)
+			val |= 1 << 1;
+		else
+			val &= ~(1 << 1);
+	}
+	ret = menelaus_write_reg(MENELAUS_MCT_CTRL3, val);
+
+out:
+	mutex_unlock(&the_menelaus->lock);
+	return ret;
+}
+EXPORT_SYMBOL(menelaus_enable_slot);
+
 int menelaus_set_mmc_slot(int slot, int enable, int power, int cd_en)
 {
 	int ret, val;
@@ -356,9 +384,9 @@ int menelaus_set_mmc_slot(int slot, int enable, int power, int cd_en)
 		int b;
 
 		if (enable)
-			ret |= 1 << 1;
+			val |= 1 << 1;
 		else
-			ret &= ~(1 << 1);
+			val &= ~(1 << 1);
 		b = menelaus_read_reg(MENELAUS_MCT_CTRL2);
 		b &= ~0x03;
 		b |= power;
@@ -930,7 +958,7 @@ static int menelaus_set_time(struct device *dev, struct rtc_time *t)
 		return status;
 	status = menelaus_write_reg(MENELAUS_RTC_WKDAY, BIN2BCD(t->tm_wday));
 	if (status < 0) {
-		dev_err(&the_menelaus->client->dev, "rtc write reg %02x "
+		dev_err(&the_menelaus->client->dev, "rtc write reg %02x"
 				"err %d\n", MENELAUS_RTC_WKDAY, status);
 		return status;
 	}
@@ -1176,7 +1204,7 @@ static int menelaus_probe(struct i2c_client *client,
 	/* If a true probe check the device */
 	rev = menelaus_read_reg(MENELAUS_REV);
 	if (rev < 0) {
-		pr_err(DRIVER_NAME ": device not found");
+		dev_err(&client->dev, "device not found");
 		err = -ENODEV;
 		goto fail1;
 	}
@@ -1196,7 +1224,7 @@ static int menelaus_probe(struct i2c_client *client,
 		err = request_irq(client->irq, menelaus_irq, IRQF_DISABLED,
 				  DRIVER_NAME, menelaus);
 		if (err) {
-			dev_dbg(&client->dev,  "can't get IRQ %d, err %d\n",
+			dev_dbg(&client->dev,  "can't get IRQ %d, err %d",
 					client->irq, err);
 			goto fail1;
 		}
@@ -1205,7 +1233,7 @@ static int menelaus_probe(struct i2c_client *client,
 	mutex_init(&menelaus->lock);
 	INIT_WORK(&menelaus->work, menelaus_work);
 
-	pr_info("Menelaus rev %d.%d\n", rev >> 4, rev & 0x0f);
+	dev_info(&client->dev, "Menelaus rev %d.%d\n", rev >> 4, rev & 0x0f);
 
 	val = menelaus_read_reg(MENELAUS_VCORE_CTRL1);
 	if (val < 0)
@@ -1260,15 +1288,7 @@ static struct i2c_driver menelaus_i2c_driver = {
 
 static int __init menelaus_init(void)
 {
-	int res;
-
-	res = i2c_add_driver(&menelaus_i2c_driver);
-	if (res < 0) {
-		pr_err(DRIVER_NAME ": driver registration failed\n");
-		return res;
-	}
-
-	return 0;
+	return i2c_add_driver(&menelaus_i2c_driver);
 }
 
 static void __exit menelaus_exit(void)
diff --git a/include/asm-arm/arch-omap/menelaus.h b/include/asm-arm/arch-omap/menelaus.h
index 69ed7ee..e1012c1 100644
--- a/include/asm-arm/arch-omap/menelaus.h
+++ b/include/asm-arm/arch-omap/menelaus.h
@@ -18,6 +18,7 @@ extern int menelaus_register_mmc_callback(void (*callback)(void *data, u8 card_m
 extern void menelaus_unregister_mmc_callback(void);
 extern int menelaus_set_mmc_opendrain(int slot, int enable);
 extern int menelaus_set_mmc_slot(int slot, int enable, int power, int cd_on);
+extern int menelaus_enable_slot(int slot, int enable);
 
 extern int menelaus_set_vmem(unsigned int mV);
 extern int menelaus_set_vio(unsigned int mV);
-- 1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
