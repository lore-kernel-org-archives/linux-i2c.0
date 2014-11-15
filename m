From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] i2c: i2c-imx-hdmi: add documentation file of the bus
Date: Sat, 15 Nov 2014 19:49:19 +0200
Message-ID: <1416073759-19939-4-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1416073759-19939-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416073759-19939-1-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add simple description of iMX6 HDMI DDC controller used as a I2C
master.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 Documentation/i2c/busses/i2c-imx-hdmi |   62 +++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/i2c/busses/i2c-imx-hdmi

diff --git a/Documentation/i2c/busses/i2c-imx-hdmi b/Documentation/i2c/busses/i2c-imx-hdmi
new file mode 100644
index 0000000..20c7101
--- /dev/null
+++ b/Documentation/i2c/busses/i2c-imx-hdmi
@@ -0,0 +1,62 @@
+Kernel driver i2c-imx-hdmi
+
+Supported adapters:
+  * Freescale iMX6Quad HDMI controller
+  * Freescale iMX6DualLite HDMI controller
+  * Freescale iMX6Solo HDMI controller
+
+Datasheets:
+	Publicly available at the Freescale website
+
+Authors:
+	Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
+
+
+Description
+-----------
+
+According to the iMX6 Reference Manual only two types of transactions
+are supported by HDMI I2C Master Interface in Normal Mode:
+
+A) one byte data write transaction (I2C spec write/write transmission):
+
+   master   S|slave addr[6:0]|0|     |slave reg[7:0]|     |data[7:0]|     |P
+   slave                       | ack |              | ack |         | ack |
+
+B) one byte data read transaction (I2C spec write/read combined format):
+
+   master   S|slave addr[6:0]|0|     |slave reg[7:0]|     | ...
+   slave                       | ack |              | ack | ...
+
+   master   ... Sr|slave addr[6:0]|1|     |         | ack |P
+   slave    ...                     | Ack |data[7:0]|
+
+HDMI I2C Master Interface Extended Read Mode allows to execute one
+more transaction pattern so called segment pointer-based read:
+
+C) segment pointer-based read (I2C spec write/write/read combined format):
+
+   master   S|seg addr[6:0]|0|     |seg pointer[7:0]|     | ...
+   slave                     | xxx |                | xxx | ...
+
+   master   ... Sr|slave addr[6:0]|0|     |slave reg[7:0]|     | ...
+   slave    ...                     | ack |              | ack | ...
+
+   master   ... Sr|slave addr[6:0]|1|     |         | ack |P
+   slave    ...                     | ack |data[7:0]|
+
+At the moment Extended Read Mode is not supported by the driver.
+
+The technical limitations of the iMX6 HDMI E-DDC bus does not allow
+to call it an I2C compatible bus, however relativery large subset of
+I2C transactions can be decomposed into aforementioned data read/write
+operations and many I2C devices correctly support those operations,
+but the primary goad of the device is to read EDID blob of a connected
+HDMI monitor.
+
+
+Notes
+-----
+
+The bus driver may be used independently on HDMI controller, but due
+to device limitations it can not support arbitrary slave devices.
-- 
1.7.10.4
