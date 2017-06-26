From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/5] i2c: pca-platform: switch to struct gpio_desc
Date: Mon, 26 Jun 2017 12:44:31 +1200
Message-ID: <20170626004434.2757-3-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>
List-Id: linux-i2c@vger.kernel.org

Make use of struct gpio_desc which allows us to specify the active state
of the reset pin.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v3:
- New, replaces "i2c: pca-platform: use gpio_is_valid"
- Using struct gpio_desc is required to make the flags stick. Because those
  flags now correctly indicate that RESET_N is active low, the logic for
  resetting the chip is inverted.

 drivers/i2c/busses/i2c-pca-platform.c | 43 ++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 3bd2e7d06e4b..9f995b8ed587 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -22,6 +22,7 @@
 #include <linux/i2c-algo-pca.h>
 #include <linux/i2c-pca-platform.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -29,7 +30,7 @@
 struct i2c_pca_pf_data {
 	void __iomem			*reg_base;
 	int				irq;	/* if 0, use polling */
-	int				gpio;
+	struct gpio_desc		*gpio;
 	wait_queue_head_t		wait;
 	struct i2c_adapter		adap;
 	struct i2c_algo_pca_data	algo_data;
@@ -112,9 +113,9 @@ static void i2c_pca_pf_resetchip(void *pd)
 {
 	struct i2c_pca_pf_data *i2c = pd;
 
-	gpio_set_value(i2c->gpio, 0);
+	gpiod_set_value(i2c->gpio, 1);
 	ndelay(100);
-	gpio_set_value(i2c->gpio, 1);
+	gpiod_set_value(i2c->gpio, 0);
 }
 
 static irqreturn_t i2c_pca_pf_handler(int this_irq, void *dev_id)
@@ -181,11 +182,24 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	if (platform_data) {
 		i2c->adap.timeout = platform_data->timeout;
 		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
-		i2c->gpio = platform_data->gpio;
+		if (gpio_is_valid(platform_data->gpio)) {
+			ret = devm_gpio_request_one(&pdev->dev,
+						    platform_data->gpio,
+						    GPIOF_ACTIVE_LOW,
+						    i2c->adap.name);
+			if (ret == 0) {
+				i2c->gpio = gpio_to_desc(platform_data->gpio);
+				gpiod_direction_output(i2c->gpio, 0);
+				i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
+			} else {
+				dev_warn(&pdev->dev, "Registering gpio failed!\n");
+				i2c->gpio = NULL;
+			}
+		}
 	} else {
 		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
-		i2c->gpio = -1;
+		i2c->gpio = NULL;
 	}
 
 	i2c->algo_data.data = i2c;
@@ -208,19 +222,6 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Use gpio_is_valid() when in mainline */
-	if (i2c->gpio > -1) {
-		ret = gpio_request(i2c->gpio, i2c->adap.name);
-		if (ret == 0) {
-			gpio_direction_output(i2c->gpio, 1);
-			i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
-		} else {
-			printk(KERN_WARNING "%s: Registering gpio failed!\n",
-				i2c->adap.name);
-			i2c->gpio = ret;
-		}
-	}
-
 	if (irq) {
 		ret = request_irq(irq, i2c_pca_pf_handler,
 			IRQF_TRIGGER_FALLING, pdev->name, i2c);
@@ -243,9 +244,6 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	if (irq)
 		free_irq(irq, i2c);
 e_reqirq:
-	if (i2c->gpio > -1)
-		gpio_free(i2c->gpio);
-
 	iounmap(i2c->reg_base);
 e_remap:
 	kfree(i2c);
@@ -265,9 +263,6 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
 	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
 
-	if (i2c->gpio > -1)
-		gpio_free(i2c->gpio);
-
 	iounmap(i2c->reg_base);
 	release_mem_region(i2c->io_base, i2c->io_size);
 	kfree(i2c);
-- 
2.13.0
