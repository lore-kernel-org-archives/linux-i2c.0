From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: allow specifying separate wakeup interrupt in device
 tree
Date: Thu, 30 Jul 2015 13:14:31 -0700
Message-ID: <20150730201431.GA5255@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Instead of having each i2c driver individually parse device tree data in
case it or platform supports separate wakeup interrupt, and handle
enabling and disabling wakeup interrupts in their power management
routines, let's have i2c core do that for us.

Platforms wishing to specify separate wakeup interrupt for the device
should use named interrupt syntax in their DTSes:

	interrupt-parent = <&intc1>;
	interrupts = <5 0>, <6 0>;
	interrupt-names = "irq", "wakeup";

This patch is inspired by work done by Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> for
pixcir_i2c_ts driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e6d4935..19e7a17 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -47,6 +47,7 @@
 #include <linux/rwsem.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/acpi.h>
 #include <linux/jump_label.h>
 #include <asm/uaccess.h>
@@ -639,11 +640,13 @@ static int i2c_device_probe(struct device *dev)
 	if (!client->irq) {
 		int irq = -ENOENT;
 
-		if (dev->of_node)
-			irq = of_irq_get(dev->of_node, 0);
-		else if (ACPI_COMPANION(dev))
+		if (dev->of_node) {
+			irq = of_irq_get_byname(dev->of_node, "irq");
+			if (irq == -EINVAL || irq == -ENODATA)
+				irq = of_irq_get(dev->of_node, 0);
+		} else if (ACPI_COMPANION(dev)) {
 			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
-
+		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
 		if (irq < 0)
@@ -659,20 +662,47 @@ static int i2c_device_probe(struct device *dev)
 	if (!device_can_wakeup(&client->dev))
 		device_init_wakeup(&client->dev,
 					client->flags & I2C_CLIENT_WAKE);
+
+	if (device_can_wakeup(&client->dev)) {
+		int wakeirq = -ENOENT;
+
+		if (dev->of_node) {
+			wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
+			if (wakeirq == -EPROBE_DEFER)
+				return wakeirq;
+		}
+
+		if (wakeirq > 0 && wakeirq != client->irq)
+			status = dev_pm_set_dedicated_wake_irq(dev, wakeirq);
+		else if (client->irq > 0)
+			status = dev_pm_set_wake_irq(dev, wakeirq);
+		else
+			status = 0;
+
+		if (status)
+			dev_warn(&client->dev, "failed to set up wakeup irq");
+	}
+
 	dev_dbg(dev, "probe\n");
 
 	status = of_clk_set_defaults(dev->of_node, false);
 	if (status < 0)
-		return status;
+		goto err_clear_wakeup_irq;
 
 	status = dev_pm_domain_attach(&client->dev, true);
 	if (status != -EPROBE_DEFER) {
 		status = driver->probe(client, i2c_match_id(driver->id_table,
 					client));
 		if (status)
-			dev_pm_domain_detach(&client->dev, true);
+			goto err_detach_pm_domain;
 	}
 
+	return 0;
+
+err_detach_pm_domain:
+	dev_pm_domain_detach(&client->dev, true);
+err_clear_wakeup_irq:
+	dev_pm_clear_wake_irq(&client->dev);
 	return status;
 }
 
@@ -692,6 +722,10 @@ static int i2c_device_remove(struct device *dev)
 	}
 
 	dev_pm_domain_detach(&client->dev, true);
+
+	dev_pm_clear_wake_irq(&client->dev);
+	device_init_wakeup(&client->dev, 0);
+
 	return status;
 }
 
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
