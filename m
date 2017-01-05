From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] i2c: do not enable fall back to Host Notify by default
Date: Wed, 4 Jan 2017 20:57:22 -0800
Message-ID: <20170105045722.GA17958@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32825 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdAEE50 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2017 23:57:26 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Falling back unconditionally to HostNotify as primary client's interrupt
breaks some drivers which alter their functionality depending on whether
interrupt is present or not, so let's introduce a board flag telling I2C
core explicitly if we want wired interrupt or HostNotify-based one:
I2C_CLIENT_HOST_NOTIFY.

For DT-based systems we introduce "host-notify" property that we convert
to I2C_CLIENT_HOST_NOTIFY board flag.

Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v1->v2:

- of_read_property_bool -> of_property_read_bool
- did not change binding wording to avoit mentioning I2C core because we
  use the same wording (mentioning I2C core) for wired interrupts

 Documentation/devicetree/bindings/i2c/i2c.txt |  8 ++++++++
 drivers/i2c/i2c-core.c                        | 17 ++++++++---------
 include/linux/i2c.h                           |  1 +
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index 5fa691e6f638..cee9d5055fa2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -62,6 +62,9 @@ wants to support one of the below features, it should adapt the bindings below.
 	"irq" and "wakeup" names are recognized by I2C core, other names are
 	left to individual drivers.
 
+- host-notify
+	device uses SMBus host notify protocol instead of interrupt line.
+
 - multi-master
 	states that there is another master active on this bus. The OS can use
 	this information to adapt power management to keep the arbitration awake
@@ -81,6 +84,11 @@ Binding may contain optional "interrupts" property, describing interrupts
 used by the device. I2C core will assign "irq" interrupt (or the very first
 interrupt if not using interrupt names) as primary interrupt for the slave.
 
+Alternatively, devices supporting SMbus Host Notify, and connected to
+adapters that support this feature, may use "host-notify" property. I2C
+core will create a virtual interrupt for Host Notify and assign it as
+primary interrupt for the slave.
+
 Also, if device is marked as a wakeup source, I2C core will set up "wakeup"
 interrupt for the device. If "wakeup" interrupt name is not present in the
 binding, then primary interrupt will be used as wakeup interrupt.
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index cf9e396d7702..7b117240f1ea 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -931,7 +931,10 @@ static int i2c_device_probe(struct device *dev)
 	if (!client->irq) {
 		int irq = -ENOENT;
 
-		if (dev->of_node) {
+		if (client->flags & I2C_CLIENT_HOST_NOTIFY) {
+			dev_dbg(dev, "Using Host Notify IRQ\n");
+			irq = i2c_smbus_host_notify_to_irq(client);
+		} else if (dev->of_node) {
 			irq = of_irq_get_byname(dev->of_node, "irq");
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
@@ -940,14 +943,7 @@ static int i2c_device_probe(struct device *dev)
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
-		/*
-		 * ACPI and OF did not find any useful IRQ, try to see
-		 * if Host Notify can be used.
-		 */
-		if (irq < 0) {
-			dev_dbg(dev, "Using Host Notify IRQ\n");
-			irq = i2c_smbus_host_notify_to_irq(client);
-		}
+
 		if (irq < 0)
 			irq = 0;
 
@@ -1716,6 +1712,9 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	info.of_node = of_node_get(node);
 	info.archdata = &dev_ad;
 
+	if (of_property_read_bool(node, "host-notify"))
+		info.flags |= I2C_CLIENT_HOST_NOTIFY;
+
 	if (of_get_property(node, "wakeup-source", NULL))
 		info.flags |= I2C_CLIENT_WAKE;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b2109c522dec..4b45ec46161f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -665,6 +665,7 @@ i2c_unlock_adapter(struct i2c_adapter *adapter)
 #define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
 					/* Must equal I2C_M_TEN below */
 #define I2C_CLIENT_SLAVE	0x20	/* we are the slave */
+#define I2C_CLIENT_HOST_NOTIFY	0x40	/* We want to use I2C host notify */
 #define I2C_CLIENT_WAKE		0x80	/* for board_info; true iff can wake */
 #define I2C_CLIENT_SCCB		0x9000	/* Use Omnivision SCCB protocol */
 					/* Must match I2C_M_STOP|IGNORE_NAK */
-- 
2.11.0.390.gc69c2f50cf-goog


-- 
Dmitry
