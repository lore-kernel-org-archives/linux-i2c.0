From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] i2c: axxia: Add bus recovery functionality
Date: Wed, 13 May 2015 11:03:42 +0200
Message-ID: <5553136E.2000408@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, "ext Berg, Anders O" <anders.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Lawnick Michael <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use recovery framework and implement bus recovery using "Bus Monitor" register.
Tests show that shortening SDA to GND results in "completion" timeout with
"BUSY" bit still set, so initiate recovery in this case.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
Tested with jumpers and oscilloscope on the custom Axxia AXM5508-based board.

Changes in v2:
- initiate recovery only in case of timeout, not in arbitration lost condition;

 drivers/i2c/busses/i2c-axxia.c |   41 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 32d8834..c335cc7 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -42,6 +42,10 @@
 #define IBML_LOW_SEXT		0x18
 #define TIMER_CLOCK_DIV		0x1c
 #define I2C_BUS_MONITOR		0x20
+#define   BM_SDAC		BIT(3)
+#define   BM_SCLC		BIT(2)
+#define   BM_SDAS		BIT(1)
+#define   BM_SCLS		BIT(0)
 #define SOFT_RESET		0x24
 #define MST_COMMAND		0x28
 #define   CMD_BUSY		(1<<3)
@@ -394,6 +398,9 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 	if (time_left == 0)
 		idev->msg_err = -ETIMEDOUT;

+	if (idev->msg_err == -ETIMEDOUT)
+		i2c_recover_bus(&idev->adapter);
+
 	if (unlikely(idev->msg_err) && idev->msg_err != -ENXIO)
 		axxia_i2c_init(idev);

@@ -437,6 +444,39 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	return ret ? : i;
 }

+static int axxia_i2c_get_scl(struct i2c_adapter *adap)
+{
+	struct axxia_i2c_dev *idev = i2c_get_adapdata(adap);
+
+	return !!(readl(idev->base + I2C_BUS_MONITOR) & BM_SCLS);
+}
+
+static void axxia_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct axxia_i2c_dev *idev = i2c_get_adapdata(adap);
+	u32 tmp;
+
+	/* Preserve SDA Control */
+	tmp = readl(idev->base + I2C_BUS_MONITOR) & BM_SDAC;
+	if (!val)
+		tmp |= BM_SCLC;
+	writel(tmp, idev->base + I2C_BUS_MONITOR);
+}
+
+static int axxia_i2c_get_sda(struct i2c_adapter *adap)
+{
+	struct axxia_i2c_dev *idev = i2c_get_adapdata(adap);
+
+	return !!(readl(idev->base + I2C_BUS_MONITOR) & BM_SDAS);
+}
+
+static struct i2c_bus_recovery_info axxia_i2c_recovery_info = {
+	.recover_bus = i2c_generic_scl_recovery,
+	.get_scl = axxia_i2c_get_scl,
+	.set_scl = axxia_i2c_set_scl,
+	.get_sda = axxia_i2c_get_sda,
+};
+
 static u32 axxia_i2c_func(struct i2c_adapter *adap)
 {
 	u32 caps = (I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR |
@@ -511,6 +551,7 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 	strlcpy(idev->adapter.name, pdev->name, sizeof(idev->adapter.name));
 	idev->adapter.owner = THIS_MODULE;
 	idev->adapter.algo = &axxia_i2c_algo;
+	idev->adapter.bus_recovery_info = &axxia_i2c_recovery_info;
 	idev->adapter.quirks = &axxia_i2c_quirks;
 	idev->adapter.dev.parent = &pdev->dev;
 	idev->adapter.dev.of_node = pdev->dev.of_node;
