From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 5/9] i2c-designware: move i2c functionality bit field to be adapter specific
Date: Fri, 14 Jan 2011 11:27:32 -0800
Message-ID: <1295033256-30077-6-git-send-email-dirk.brandewie@gmail.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The functionality of the adapter depends on the configuration of the
IP block at silicon compile time and is adapter specific.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |    8 ++------
 drivers/i2c/busses/i2c-designware-core.h |    1 +
 drivers/i2c/busses/i2c-designware-pci.c  |    6 ++++++
 drivers/i2c/busses/i2c-designware-plat.c |    7 +++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index b7102df..c6a2b50 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -444,12 +444,8 @@ EXPORT_SYMBOL(i2c_dw_xfer);
 
 u32 i2c_dw_func(struct i2c_adapter *adap)
 {
-	return	I2C_FUNC_I2C |
-		I2C_FUNC_10BIT_ADDR |
-		I2C_FUNC_SMBUS_BYTE |
-		I2C_FUNC_SMBUS_BYTE_DATA |
-		I2C_FUNC_SMBUS_WORD_DATA |
-		I2C_FUNC_SMBUS_I2C_BLOCK;
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+	return dev->functionality;
 }
 EXPORT_SYMBOL(i2c_dw_func);
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index f2182a9..e39a412 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -193,6 +193,7 @@ struct dw_i2c_dev {
 	u32			abort_source;
 	int			irq;
 	struct i2c_adapter	adapter;
+	u32			functionality;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 };
diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
index 00717df..5d131ce 100644
--- a/drivers/i2c/busses/i2c-designware-pci.c
+++ b/drivers/i2c/busses/i2c-designware-pci.c
@@ -199,6 +199,12 @@ const struct pci_device_id *id)
 	dev->clk_khz = controller->clk_khz;
 	dev->base = base;
 	dev->dev = get_device(&pdev->dev);
+	dev->functionality = I2C_FUNC_I2C |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK;
+
 	pci_set_drvdata(pdev, dev);
 
 	dev->tx_fifo_depth = controller->tx_fifo_depth;
diff --git a/drivers/i2c/busses/i2c-designware-plat.c b/drivers/i2c/busses/i2c-designware-plat.c
index b8e5aa4..cf157a4 100644
--- a/drivers/i2c/busses/i2c-designware-plat.c
+++ b/drivers/i2c/busses/i2c-designware-plat.c
@@ -91,6 +91,13 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	}
 	clk_enable(dev->clk);
 
+	dev->functionality = I2C_FUNC_I2C |
+		I2C_FUNC_10BIT_ADDR |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK;
+
 	dev->base = ioremap(mem->start, resource_size(mem));
 	if (dev->base == NULL) {
 		dev_err(&pdev->dev, "failure mapping io resources\n");
-- 
1.7.3.4
