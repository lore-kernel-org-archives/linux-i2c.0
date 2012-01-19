From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date: Thu, 19 Jan 2012 20:12:51 +0530
Message-ID: <1326984171-21209-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <20120118212702.GA21576@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120118212702.GA21576-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

Add support for the intergrated I2C controller on Netlogic
XLR/XLS MIPS SoC.

The changes are to add a new file i2c/buses/i2c-xlr.c, containing the
i2c bus implementation, and to update i2c/buses/{Kconfig,Makefile} to
add the CONFIG_I2C_XLR option.

Signed-off-by: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
 drivers/i2c/busses/Kconfig   |   10 ++
 drivers/i2c/busses/Makefile  |    1 +
 drivers/i2c/busses/i2c-xlr.c |  279 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index cbe7a2f..40b7c18 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -681,6 +681,16 @@ config I2C_XILINX
 	  This driver can also be built as a module.  If so, the module
 	  will be called xilinx_i2c.
 
+config I2C_XLR
+	tristate "XLR I2C support"
+	depends on CPU_XLR
+	help
+	  This driver enables support for the on-chip I2C interface of
+	  the Netlogic XLR/XLS MIPS processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-xlr.
+
 config I2C_EG20T
 	tristate "Intel EG20T PCH / OKI SEMICONDUCTOR IOH(ML7213/ML7223)"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index fba6da6..a0c644d 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
+obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
 obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
 
 # External I2C/SMBus adapter drivers
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
new file mode 100644
index 0000000..ecf3e9e
--- /dev/null
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -0,0 +1,279 @@
+/*
+ * Copyright 2011, Netlogic Microsystems Inc.
+ * Copyright 2004, Matt Porter <mporter-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+/* XLR I2C REGISTERS */
+#define XLR_I2C_CFG		0x00
+#define XLR_I2C_CLKDIV		0x01
+#define XLR_I2C_DEVADDR		0x02
+#define XLR_I2C_ADDR		0x03
+#define XLR_I2C_DATAOUT		0x04
+#define XLR_I2C_DATAIN		0x05
+#define XLR_I2C_STATUS		0x06
+#define XLR_I2C_STARTXFR	0x07
+#define XLR_I2C_BYTECNT		0x08
+#define XLR_I2C_HDSTATIM	0x09
+
+/* XLR I2C REGISTERS FLAGS */
+#define XLR_I2C_BUS_BUSY	0x01
+#define XLR_I2C_SDOEMPTY	0x02
+#define XLR_I2C_RXRDY		0x04
+#define XLR_I2C_ACK_ERR		0x08
+#define XLR_I2C_ARB_STARTERR	0x30
+
+/* Register Values */
+#define XLR_I2C_CFG_ADDR	0xF8
+#define XLR_I2C_CFG_NOADDR	0xFA
+#define XLR_I2C_STARTXFR_ND	0x02    /* No Data */
+#define XLR_I2C_STARTXFR_RD	0x01    /* Read */
+#define XLR_I2C_STARTXFR_WR	0x00    /* Write */
+
+#define XLR_I2C_TIMEOUT		5000	/* timeout per byte in usec*/
+
+/*
+ * On XLR/XLS, we need to use __raw_ IO to read the I2C registers
+ * because they are in the big-endian MMIO area on the SoC.
+ *
+ * The readl/writel implementation on XLR/XLS byteswaps, because
+ * those are for its little-endian PCI space (see arch/mips/Kconfig).
+ */
+static inline void xlr_i2c_wreg(u32 __iomem *base, unsigned int reg, u32 val)
+{
+	__raw_writel(val, base + reg);
+}
+
+static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
+{
+	return __raw_readl(base + reg);
+}
+
+struct xlr_i2c_private {
+	struct i2c_adapter adap;
+	u32 __iomem *iobase;
+};
+
+static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
+	u8 *buf, u16 addr)
+{
+	struct i2c_adapter *adap = &priv->adap;
+	u32 i2c_status;
+	unsigned long timeout, stoptime;
+	int pos;
+	u8 offset, byte;
+
+	offset = buf[0];
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
+
+	timeout = usecs_to_jiffies(XLR_I2C_TIMEOUT);
+	stoptime = jiffies + timeout;
+	pos = 1;
+retry:
+	if (len == 1) {
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
+				XLR_I2C_STARTXFR_ND);
+	} else {
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
+				XLR_I2C_STARTXFR_WR);
+	}
+
+	while (1) {
+		if (time_after(jiffies, stoptime)) {
+			dev_err(&adap->dev, "I2C transmit timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
+
+		if (i2c_status & XLR_I2C_SDOEMPTY) {
+			pos++;
+			/* need to do a empty dataout after the last byte */
+			byte = (pos < len) ? buf[pos] : 0;
+			xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, byte);
+
+			/* reset timeout on successful xmit */
+			stoptime = jiffies + timeout;
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR)
+			return -EIO;
+
+		if (i2c_status & XLR_I2C_BUS_BUSY)
+			continue;
+
+		if (pos >= len)
+			break;
+	}
+
+	return 0;
+}
+
+static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
+{
+	struct i2c_adapter *adap = &priv->adap;
+	u32 i2c_status;
+	unsigned long timeout, stoptime;
+	int nbytes;
+	u8 byte;
+
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
+
+	timeout = usecs_to_jiffies(XLR_I2C_TIMEOUT);
+	stoptime = jiffies + timeout;
+	nbytes = 0;
+retry:
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR, XLR_I2C_STARTXFR_RD);
+
+	while (1) {
+		if (time_after(jiffies, stoptime)) {
+			dev_err(&adap->dev, "I2C receive timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
+		if (i2c_status & XLR_I2C_RXRDY) {
+			if (nbytes > len)
+				return -EIO;	/* should not happen */
+
+			/* we need to do a dummy datain when nbytes == len */
+			byte = xlr_i2c_rdreg(priv->iobase, XLR_I2C_DATAIN);
+			if (nbytes < len)
+				buf[nbytes] = byte;
+			nbytes++;
+
+			/* reset timeout on successful read */
+			stoptime = jiffies + timeout;
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			dev_err(&adap->dev, "I2C receive ACK error\n");
+			return -EIO;
+		}
+
+		if ((i2c_status & XLR_I2C_BUS_BUSY) == 0)
+			break;
+	}
+	return 0;
+}
+
+static int xlr_i2c_xfer(struct i2c_adapter *adap,
+	struct i2c_msg *msgs, int num)
+{
+	struct i2c_msg *msg;
+	int i;
+	int ret = 0;
+	struct xlr_i2c_private *priv = i2c_get_adapdata(adap);
+
+	for (i = 0; ret == 0 && i < num; i++) {
+		msg = &msgs[i];
+		if (msg->flags & I2C_M_RD)
+			ret = xlr_i2c_rx(priv, msg->len, &msg->buf[0],
+					msg->addr);
+		else
+			ret = xlr_i2c_tx(priv, msg->len, &msg->buf[0],
+					msg->addr);
+	}
+
+	return (ret != 0) ? ret : num;
+}
+
+static u32 xlr_func(struct i2c_adapter *adap)
+{
+	/* Emulate SMBUS over I2C */
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm xlr_i2c_algo = {
+	.master_xfer	= xlr_i2c_xfer,
+	.functionality	= xlr_func,
+};
+
+static int __devinit xlr_i2c_probe(struct platform_device *pdev)
+{
+	struct xlr_i2c_private  *priv;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->iobase = devm_request_and_ioremap(&pdev->dev, res);
+	if (!priv->iobase) {
+		dev_err(&pdev->dev, "devm_request_and_ioremap failed\n");
+		return -EBUSY;
+	}
+
+	priv->adap.dev.parent = &pdev->dev;
+	priv->adap.owner	= THIS_MODULE;
+	priv->adap.algo_data	= priv;
+	priv->adap.algo		= &xlr_i2c_algo;
+	priv->adap.nr		= pdev->id;
+	priv->adap.class	= I2C_CLASS_HWMON;
+	snprintf(priv->adap.name, sizeof(priv->adap.name), "xlr-i2c");
+
+	i2c_set_adapdata(&priv->adap, priv);
+	ret = i2c_add_numbered_adapter(&priv->adap);
+	if (ret < 0) {
+		dev_err(&priv->adap.dev, "Failed to add i2c bus.\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	dev_info(&priv->adap.dev, "Added I2C Bus.\n");
+	return 0;
+}
+
+static int __devexit xlr_i2c_remove(struct platform_device *pdev)
+{
+	struct xlr_i2c_private *priv;
+
+	priv = platform_get_drvdata(pdev);
+	i2c_del_adapter(&priv->adap);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver xlr_i2c_driver = {
+	.probe  = xlr_i2c_probe,
+	.remove = __devexit_p(xlr_i2c_remove),
+	.driver = {
+		.name   = "xlr-i2cbus",
+		.owner  = THIS_MODULE,
+	},
+};
+
+module_platform_driver(xlr_i2c_driver);
+
+MODULE_AUTHOR("Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>");
+MODULE_DESCRIPTION("XLR/XLS SoC I2C Controller driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:xlr-i2cbus");
-- 
1.7.5.4
