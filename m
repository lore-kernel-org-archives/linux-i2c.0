From: David Jander <david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
Subject: [RFC PATCH] i2c-imx.c: Add support for I2C bus fault recovery
Date: Tue,  6 Dec 2011 12:56:12 +0100
Message-ID: <1323172572-11715-1-git-send-email-david@protonic.nl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Darius Augulis <darius.augulis-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>, giometti-k2GhghHVRtY@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rick Soza <rsoza-3V3W3W9657E/CDIEhCN/twC/G2K4zDHf@public.gmane.org>, David Jander <david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In the event that a I2C bus is disturbed, for instance by a slave missing
a clock pulse, it is desirable to have a way to get the bus back working
other than by power-cycling the whole system. This patch makes it possible to
to have a special function in board support code issue an I2C reset, since
the IMX peripheral is not capable of doing this, and it needs to be done
by bit-banging the corresponding pins in GPIO mode.
The reset function needs to check if the bus is hung by checking the state
of SDA and issue a reset by pulsing SCL a few times as long as SDA is low.

Signed-off-by: David Jander <david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
---
 arch/arm/plat-mxc/include/mach/i2c.h |    2 ++
 drivers/i2c/busses/i2c-imx.c         |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/i2c.h b/arch/arm/plat-mxc/include/mach/i2c.h
index 4a5dc5c..7ed4f64 100644
--- a/arch/arm/plat-mxc/include/mach/i2c.h
+++ b/arch/arm/plat-mxc/include/mach/i2c.h
@@ -13,12 +13,14 @@
  * struct imxi2c_platform_data - structure of platform data for MXC I2C driver
  * @init:	Initialise gpio's and other board specific things
  * @exit:	Free everything initialised by @init
+ * @reset:	Issue I2C reset if needed (toggle SCL via GPIO access)
  * @bitrate:	Bus speed measured in Hz
  *
  **/
 struct imxi2c_platform_data {
 	int (*init)(struct device *dev);
 	void (*exit)(struct device *dev);
+	int (*reset)(struct device *dev);
 	int bitrate;
 };
 
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 4c2a62b..c5c5cec 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -123,6 +123,7 @@ struct imx_i2c_struct {
 	unsigned int 		disable_delay;
 	int			stopped;
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
+	int 			(*reset)(struct device *dev);
 };
 
 /** Functions for IMX I2C adapter driver ***************************************
@@ -197,6 +198,10 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	/* Wait controller to be stable */
 	udelay(50);
 
+	/* Check if bus is busy (hung if not multi-master) and issue reset */
+	if (i2c_imx->reset && i2c_imx->reset(&i2c_imx->adapter.dev))
+		return -ETIMEDOUT;
+
 	/* Start I2C transaction */
 	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
 	temp |= I2CR_MSTA;
@@ -523,6 +528,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->irq			= irq;
 	i2c_imx->base			= base;
 	i2c_imx->res			= res;
+	i2c_imx->reset			= pdata->reset;
 
 	/* Get I2C clock */
 	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
-- 
1.7.5.4
