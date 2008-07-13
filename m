From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
	MAX7320-7327 I2C Port Expanders
Date: Sun, 13 Jul 2008 12:18:29 -0700
Message-ID: <200807131218.29575.david-b@pacbell.net>
References: <4875A893.3090402@gmail.com>
	<20080713111306.791bbc41@hyperion.delvare>
	<f17812d70807130645i755c1c62la30d5c515c2d2080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807130645i755c1c62la30d5c515c2d2080-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 13 July 2008, eric miao wrote:
> And David, apart from my misunderstanding of the I2C address, which
> I don't think have impact to the patch itself, can I have you Acked-by so
> I'll mail Andrew Morton to see his willingness to include this into -mm
> tree?

I'll forward it with my signed-off-by, if the appended updates are OK.

Notice the memory leak fix, removing the pr_warning(), and other minor
tweaks.  The Kconfig text now matches other similar drivers; and also
doesn't explain twice about some ports being single-direction.

This doesn't apply quite as-is to with the current pending GPIO patches
(found in the MM tree) FWIW; the Makefile conflict doesn't show up in
the diffs below.

- Dave


--- g26.orig/drivers/gpio/max732x.c	2008-07-13 11:56:29.000000000 -0700
+++ g26/drivers/gpio/max732x.c	2008-07-13 11:56:22.000000000 -0700
@@ -21,7 +21,9 @@
 #include <linux/i2c.h>
 #include <linux/i2c/max732x.h>
 
-/* Each port of MAX732x (including MAX7319) falls into one of the
+
+/*
+ * Each port of MAX732x (including MAX7319) falls into one of the
  * following three types:
  *
  *   - Push Pull Output
@@ -37,7 +39,8 @@
  *   - Group A : by I2C address 0b'110xxxx
  *   - Group B : by I2C address 0b'101xxxx
  *
- * where 'xxxx' is decided by the connections of pin AD2/AD0.
+ * where 'xxxx' is decided by the connections of pin AD2/AD0.  The
+ * address used also affects the initial state of output signals.
  *
  * Within each group of ports, there are five known combinations of
  * I/O ports: 4I4O, 4P4O, 8I, 8P, 8O, see the definitions below for
@@ -47,7 +50,7 @@
  * and GPIOs from GROUP_A are numbered before those from GROUP_B
  * (if there are two groups).
  *
- * NOTE: MAX7328/MAX7329, however, resembles much closer to PCF8574,
+ * NOTE: MAX7328/MAX7329 are drop-in replacements for PCF8574/a, so
  * they are not supported by this driver.
  */
 
@@ -82,6 +85,7 @@ MODULE_DEVICE_TABLE(i2c, max732x_id);
 struct max732x_chip {
 	struct gpio_chip gpio_chip;
 
+	struct i2c_client *client;	/* "main" client */
 	struct i2c_client *client_dummy;
 	struct i2c_client *client_group_a;
 	struct i2c_client *client_group_b;
@@ -185,7 +189,8 @@ static int max732x_gpio_direction_input(
 	chip = container_of(gc, struct max732x_chip, gpio_chip);
 
 	if ((mask & chip->dir_input) == 0) {
-		pr_warning("%s: port %d is output only\n", __func__, off);
+		dev_dbg(&chip->client->dev, "%s port %d is output only\n",
+			chip->client->name, off);
 		return -EACCES;
 	}
 
@@ -201,7 +206,8 @@ static int max732x_gpio_direction_output
 	chip = container_of(gc, struct max732x_chip, gpio_chip);
 
 	if ((mask & chip->dir_output) == 0) {
-		pr_warning("%s: port %d is input only\n", __func__, off);
+		dev_dbg(&chip->client->dev, "%s port %d is input only\n",
+			chip->client->name, off);
 		return -EACCES;
 	}
 
@@ -240,15 +246,18 @@ static int __devinit max732x_setup_gpio(
 		port++;
 	}
 
-	gc->direction_input  = max732x_gpio_direction_input;
-	gc->direction_output = max732x_gpio_direction_output;
+	if (chip->dir_input)
+		gc->direction_input = max732x_gpio_direction_input;
+	if (chip->dir_output) {
+		gc->direction_output = max732x_gpio_direction_output;
+		gc->set = max732x_gpio_set_value;
+	}
 	gc->get = max732x_gpio_get_value;
-	gc->set = max732x_gpio_set_value;
 	gc->can_sleep = 1;
 
 	gc->base = gpio_start;
 	gc->ngpio = port;
-	gc->label = "max732x";
+	gc->label = chip->client->name;
 	gc->owner = THIS_MODULE;
 
 	return port;
@@ -270,6 +279,7 @@ static int __devinit max732x_probe(struc
 	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
+	chip->client = client;
 
 	nr_port = max732x_setup_gpio(chip, id, pdata->gpio_base);
 
@@ -294,7 +304,8 @@ static int __devinit max732x_probe(struc
 	default:
 		dev_err(&client->dev, "invalid I2C address specified %02x\n",
 				client->addr);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_failed;
 	}
 
 	mutex_init(&chip->lock);
@@ -345,7 +356,7 @@ static int __devexit max732x_remove(stru
 		return ret;
 	}
 
-	/* unregister the dummy i2c_client */
+	/* unregister any dummy i2c_client */
 	if (chip->client_dummy)
 		i2c_unregister_device(chip->client_dummy);
 
--- g26.orig/drivers/gpio/Kconfig	2008-07-13 11:56:29.000000000 -0700
+++ g26/drivers/gpio/Kconfig	2008-07-13 10:10:35.000000000 -0700
@@ -43,7 +43,7 @@ config GPIO_SYSFS
 comment "I2C GPIO expanders:"
 
 config GPIO_MAX732X
-	tristate "MAX7319, MAX7320-7327 8/16-bit I2C Port Expanders"
+	tristate "MAX7319, MAX7320-7327 I2C Port Expanders"
 	depends on I2C
 	help
 	  Say yes here to support the MAX7319, MAX7320-7327 series of I2C
@@ -52,17 +52,14 @@ config GPIO_MAX732X
 	  Input and Output (designed by 'P'). The combinations are listed
 	  below:
 
-	    MAX7319 (8I), MAX7320 (8O), MAX7321 (8P), MAX7322 (4I4O),
-	    MAX7323 (4P4O), MAX7324 (8I8O), MAX7325 (8P8O)
-	    MAX7326 (4I12O), MAX7327 (4P12O)
+	  8 bits:	MAX7319 (8I), MAX7320 (8O), MAX7321 (8P),
+		  	MAX7322 (4I4O), MAX7323 (4P4O)
 
-	  The board code has to specify the model to use, and the start
-	  number for these GPIOs. Model specific information is calculated
-	  automatically. Due to the fixed role of each port, configuration
-	  of the port direction will be ignored and a warning be issued if
-	  the corresponding port isn't applicable. And gpio_get_value() to
-	  those output only ports will return the configured output status
-	  instead of a real input.
+	  16 bits:	MAX7324 (8I8O), MAX7325 (8P8O),
+		  	MAX7326 (4I12O), MAX7327 (4P12O)
+
+	  Board setup code must specify the model to use, and the start
+	  number for these GPIOs.
 
 config GPIO_PCA953X
 	tristate "PCA953x, PCA955x, and MAX7310 I/O ports"

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
