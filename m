From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc3] tps65010 driver converts to gpiolib
Date: Thu, 28 Feb 2008 14:07:28 -0800
Message-ID: <20080228220729.9B01C28E0DB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Make the tps65010 driver use gpiolib to expose its GPIOs.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
NOTE:  this depends on the patch to convert OMAP over to gpiolib.
Also, commit e27a93a944a5ba6a0112750c8243abba86d56e94 broke both
H2 and H3 support ... that seems to be a 2.6.25-rc regression.

 drivers/i2c/chips/Kconfig    |    1 
 drivers/i2c/chips/tps65010.c |  101 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/tps65010.h |   30 ++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

--- osk.orig/drivers/i2c/chips/Kconfig	2008-02-28 01:29:35.000000000 -0800
+++ osk/drivers/i2c/chips/Kconfig	2008-02-28 12:56:17.000000000 -0800
@@ -119,6 +119,7 @@ config ISP1301_OMAP
 
 config TPS65010
 	tristate "TPS6501x Power Management chips"
+	depends on HAVE_GPIO_LIB
 	default y if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes here you get support for the TPS6501x series of
--- osk.orig/drivers/i2c/chips/tps65010.c	2008-02-28 04:04:46.000000000 -0800
+++ osk/drivers/i2c/chips/tps65010.c	2008-02-28 12:58:39.000000000 -0800
@@ -30,9 +30,13 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 
 #include <linux/i2c/tps65010.h>
 
+#include <asm/gpio.h>
+
+
 /*-------------------------------------------------------------------------*/
 
 #define	DRIVER_VERSION	"2 May 2005"
@@ -84,7 +88,9 @@ struct tps65010 {
 	u8			chgstatus, regstatus, chgconf;
 	u8			nmask1, nmask2;
 
-	/* not currently tracking GPIO state */
+	u8			outmask;
+	struct gpio_chip	chip;
+	struct platform_device	*leds;
 };
 
 #define	POWER_POLL_DELAY	msecs_to_jiffies(5000)
@@ -449,12 +455,72 @@ static irqreturn_t tps65010_irq(int irq,
 
 /*-------------------------------------------------------------------------*/
 
+/* offsets 0..3 == GPIO1..GPIO4
+ * offsets 4..5 == LED1/nPG, LED2 (we set one of the non-BLINK modes)
+ */
+static void
+tps65010_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	if (offset < 4)
+		tps65010_set_gpio_out_value(offset + 1, value);
+	else
+		tps65010_set_led(offset - 3, value ? ON : OFF);
+}
+
+static int
+tps65010_output(struct gpio_chip *chip, unsigned offset, int value)
+{
+	/* GPIOs may be input-only */
+	if (offset < 4) {
+		struct tps65010		*tps;
+
+		tps = container_of(chip, struct tps65010, chip);
+		if (!(tps->outmask & (1 << offset)))
+			return -EINVAL;
+		tps65010_set_gpio_out_value(offset + 1, value);
+	} else
+		tps65010_set_led(offset - 3, value ? ON : OFF);
+
+	return 0;
+}
+
+static int tps65010_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	int			value;
+	struct tps65010		*tps;
+
+	tps = container_of(chip, struct tps65010, chip);
+
+	if (offset < 4) {
+		value = i2c_smbus_read_byte_data(tps->client, TPS_DEFGPIO);
+		if (value < 0)
+			return 0;
+		if (value & (1 << (offset + 4)))	/* output */
+			return !(value & (1 << offset));
+		else					/* input */
+			return (value & (1 << offset));
+	}
+
+	/* REVISIT we *could* report LED1/nPG and LED2 state ... */
+	return 0;
+}
+
+
+/*-------------------------------------------------------------------------*/
+
 static struct tps65010 *the_tps;
 
 static int __exit tps65010_remove(struct i2c_client *client)
 {
 	struct tps65010		*tps = i2c_get_clientdata(client);
+	struct tps65010_board	*board = client->dev.platform_data;
 
+	if (board && board->teardown) {
+		int status = board->teardown(client, board->context);
+		if (status < 0)
+			dev_dbg(&client->dev, "board %s %s err %d\n",
+				"teardown", client->name, status);
+	}
 	if (client->irq > 0)
 		free_irq(client->irq, tps);
 	cancel_delayed_work(&tps->work);
@@ -469,6 +535,7 @@ static int tps65010_probe(struct i2c_cli
 {
 	struct tps65010		*tps;
 	int			status;
+	struct tps65010_board	*board = client->dev.platform_data;
 
 	if (the_tps) {
 		dev_dbg(&client->dev, "only one tps6501x chip allowed\n");
@@ -577,6 +644,38 @@ static int tps65010_probe(struct i2c_cli
 
 	tps->file = debugfs_create_file(DRIVER_NAME, S_IRUGO, NULL,
 				tps, DEBUG_FOPS);
+
+	/* optionally register GPIOs */
+	if (board && board->base > 0) {
+		tps->outmask = board->outmask;
+
+		tps->chip.label = client->name;
+
+		tps->chip.set = tps65010_gpio_set;
+		tps->chip.direction_output = tps65010_output;
+
+		/* NOTE:  only partial support for inputs; nyet IRQs */
+		tps->chip.get = tps65010_gpio_get;
+
+		tps->chip.base = board->base;
+		tps->chip.ngpio = 6;
+		tps->chip.can_sleep = 1;
+
+		status = gpiochip_add(&tps->chip);
+		if (status < 0)
+			dev_err(&client->dev, "can't add gpiochip, err %d\n",
+					status);
+		else if (board->setup) {
+			status = board->setup(client, board->context);
+			if (status < 0) {
+				dev_dbg(&client->dev,
+					"board %s %s err %d\n",
+					"setup", client->name, status);
+				status = 0;
+			}
+		}
+	}
+
 	return 0;
 fail1:
 	kfree(tps);
--- osk.orig/include/linux/i2c/tps65010.h	2008-02-28 04:04:46.000000000 -0800
+++ osk/include/linux/i2c/tps65010.h	2008-02-28 12:57:44.000000000 -0800
@@ -152,5 +152,35 @@ extern int tps65010_config_vregs1(unsign
  */
 extern int tps65013_set_low_pwr(unsigned mode);
 
+
+struct i2c_client;
+
+/**
+ * struct tps65010_board - packages GPIO and LED lines
+ * @base: the GPIO number to assign to GPIO-1
+ * @outmask: bit (N-1) is set to allow GPIO-N to be used as an
+ *	(open drain) output
+ * @setup: optional callback issued once the GPIOs are valid
+ * @teardown: optional callback issued before the GPIOs are invalidated
+ * @context: optional parameter passed to setup() and teardown()
+ *
+ * Board data may be used to package the GPIO (and LED) lines for use
+ * in by the generic GPIO and LED frameworks.  The first four GPIOs
+ * starting at gpio_base are GPIO1..GPIO4.  The next two are LED1/nPG
+ * and LED2 (with hardware blinking capability, not currently exposed).
+ *
+ * The @setup callback may be used with the kind of board-specific glue
+ * which hands the (now-valid) GPIOs to other drivers, or which puts
+ * devices in their initial states using these GPIOs.
+ */
+struct tps65010_board {
+	int				base;
+	unsigned			outmask;
+
+	int		(*setup)(struct i2c_client *client, void *context);
+	int		(*teardown)(struct i2c_client *client, void *context);
+	void		*context;
+};
+
 #endif /*  __LINUX_I2C_TPS65010_H */
 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
