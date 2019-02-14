From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
Date: Thu, 14 Feb 2019 09:57:24 -0800
Message-ID: <20190214175725.60462-8-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC I2C support to the iProc I2C driver. Access to the NIC I2C base
registers requires going through the IDM wrapper to map into the NIC's
address space

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 79 ++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 5b9cbd7a3776..9598e1d0048e 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -17,9 +17,11 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define IDM_CTRL_DIRECT_OFFSET       0x00
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
@@ -174,11 +176,26 @@ enum bus_speed_index {
 	I2C_SPD_400K,
 };
 
+enum bcm_iproc_i2c_type {
+	IPROC_I2C,
+	IPROC_I2C_NIC
+};
+
 struct bcm_iproc_i2c_dev {
 	struct device *device;
+	enum bcm_iproc_i2c_type type;
 	int irq;
 
 	void __iomem *base;
+	void __iomem *idm_base;
+
+	u32 ape_addr_mask;
+
+	/* lock for indirect access through IDM */
+	spinlock_t idm_lock;
+
+	/* indicates no slave mode support */
+	bool no_slave;
 
 	struct i2c_adapter adapter;
 	unsigned int bus_speed;
@@ -215,13 +232,33 @@ static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
 static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				   u32 offset)
 {
-	return readl(iproc_i2c->base + offset);
+	u32 val;
+
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		val = readl(iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		val = readl(iproc_i2c->base + offset);
+	}
+
+	return val;
 }
 
 static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 offset, u32 val)
 {
-	writel(val, iproc_i2c->base + offset);
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		writel(val, iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		writel(val, iproc_i2c->base + offset);
+	}
 }
 
 static void bcm_iproc_i2c_slave_init(
@@ -766,7 +803,13 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
+	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
+	u32 val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+
+	if (!iproc_i2c->no_slave)
+		val |= I2C_FUNC_SLAVE;
+
+	return val;
 }
 
 static const struct i2c_algorithm bcm_iproc_algo = {
@@ -829,6 +872,8 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iproc_i2c);
 	iproc_i2c->device = &pdev->dev;
+	iproc_i2c->type =
+		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);
 	init_completion(&iproc_i2c->done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -836,6 +881,26 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(iproc_i2c->base))
 		return PTR_ERR(iproc_i2c->base);
 
+	if (iproc_i2c->type == IPROC_I2C_NIC) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		iproc_i2c->idm_base = devm_ioremap_resource(iproc_i2c->device,
+							    res);
+		if (IS_ERR(iproc_i2c->idm_base))
+			return PTR_ERR(iproc_i2c->idm_base);
+
+		ret = of_property_read_u32(iproc_i2c->device->of_node,
+					   "brcm,ape-hsls-addr-mask",
+					   &iproc_i2c->ape_addr_mask);
+		if (ret < 0) {
+			dev_err(iproc_i2c->device,
+				"'brcm,ape-hsls-addr-mask' missing\n");
+			return -EINVAL;
+		}
+
+		spin_lock_init(&iproc_i2c->idm_lock);
+		iproc_i2c->no_slave = true;
+	}
+
 	ret = bcm_iproc_i2c_init(iproc_i2c);
 	if (ret)
 		return ret;
@@ -992,7 +1057,13 @@ static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave)
 }
 
 static const struct of_device_id bcm_iproc_i2c_of_match[] = {
-	{ .compatible = "brcm,iproc-i2c" },
+	{
+		.compatible = "brcm,iproc-i2c",
+		.data = (int *)IPROC_I2C,
+	}, {
+		.compatible = "brcm,iproc-nic-i2c",
+		.data = (int *)IPROC_I2C_NIC,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcm_iproc_i2c_of_match);
-- 
2.17.1
