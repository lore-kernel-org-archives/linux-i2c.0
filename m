From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH RFC] I2C: i2c-smbus: add device tree support
Date: Wed, 13 Apr 2016 10:36:31 +0200
Message-ID: <1460536591-12573-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jdelvare@suse.de
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>
List-Id: linux-i2c@vger.kernel.org

According to Documentation/i2c/smbus-protocol, a smbus controller driver
that wants to hook-in smbus extensions support, can call
i2c_setup_smbus_alert(). There are very few drivers that are currently
doing this.

However the i2c-smbus module can also work with any
smbus-extensions-unaware I2C controller, as long as we provide an extra
IRQ line connected to the I2C bus ALARM signal.

This patch makes it possible to go this way via DT. Note that the DT node
will indeed describe a (little) piece of HW, that is the routing of the
ALARM signal to an IRQ line (so it seems a fair DT use to me, but RFC).

Note that AFAICT, by design, i2c-smbus module pretends to be an I2C slave
with address 0x0C (that is the alarm response address), and IMHO this is
quite consistent with usage in the DT as a I2C child node.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>

diff --git a/Documentation/devicetree/bindings/i2c/i2c-smbus.txt b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
new file mode 100644
index 0000000..da83127
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
@@ -0,0 +1,20 @@
+* i2c-smbus extensions
+
+Required Properties:
+  - compatible: Must contain "smbus_alert"
+  - interrupts: The irq line for smbus ALERT signal
+  - reg: I2C slave address. Set to 0x0C (alert response address).
+
+Note: The i2c-smbus module registers itself as a slave I2C device. Whenever
+a smbus controller directly support smbus extensions (and its driver supports
+this), there is no need to add anything special to the DT. Otherwise, for using
+i2c-smbus with any smbus-extensions-unaware I2C controllers, you need to
+route the smbus ALARM signal to an extra IRQ line, thus you need to describe
+this in the DT.
+
+Example:
+	alert@0x0C {
+		reg = <0x0C>;
+		compatible = "smbus_alert";
+		interrupts = <0 36 IRQ_TYPE_LEVEL_LOW>;
+	};
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index abb55d3..7f0a566 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/of_irq.h>

 struct i2c_smbus_alert {
 	unsigned int		alert_edge_triggered:1;
@@ -137,20 +138,29 @@ static int smbalert_probe(struct i2c_client *ara,
 	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
 	struct i2c_smbus_alert *alert;
 	struct i2c_adapter *adapter = ara->adapter;
+	struct device_node *of_node = ara->dev.of_node;
 	int res;
+	int irq_type;

 	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
 			     GFP_KERNEL);
 	if (!alert)
 		return -ENOMEM;

-	alert->alert_edge_triggered = setup->alert_edge_triggered;
-	alert->irq = setup->irq;
+	if (setup) {
+		alert->alert_edge_triggered = setup->alert_edge_triggered;
+		alert->irq = setup->irq;
+	} else if (of_node) {
+		alert->irq = irq_of_parse_and_map(of_node, 0);
+		irq_type = irq_get_trigger_type(alert->irq);
+		alert->alert_edge_triggered = (irq_type & IRQ_TYPE_EDGE_BOTH);
+	}
+
 	INIT_WORK(&alert->alert, smbus_alert);
 	alert->ara = ara;

-	if (setup->irq > 0) {
-		res = devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
+	if (alert->irq > 0) {
+		res = devm_request_irq(&ara->dev, alert->irq, smbalert_irq,
 				       0, "smbus_alert", alert);
 		if (res)
 			return res;
@@ -158,7 +168,7 @@ static int smbalert_probe(struct i2c_client *ara,

 	i2c_set_clientdata(ara, alert);
 	dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
-		 setup->alert_edge_triggered ? "edge" : "level");
+		 alert->alert_edge_triggered ? "edge" : "level");

 	return 0;
 }
