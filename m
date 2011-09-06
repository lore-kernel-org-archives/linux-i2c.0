From: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH RESEND] i2c: Support for Netlogic XLR/XLS on-chip I2C
 controller.
Date: Tue, 6 Sep 2011 13:22:17 +0530
Message-ID: <20110906075212.GA16606@jayachandranc.netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add support for on chip I2C bus controller on Netlogic XLR/XLS family
of MIPS64 SoCs. The changes are:

Kconfig/Makefile: add CONFIG_I2C_XLR option
busses/i2c-xlr.c : driver for Netlogic XLR/XLS on-chip I2C controller

Signed-off-by: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
[ Posting this again, on Netlogic boards the RTC is on the i2c bus, so this
  patch is required for our platform. ]

 drivers/i2c/busses/Kconfig   |   11 ++
 drivers/i2c/busses/Makefile  |    1 +
 drivers/i2c/busses/i2c-xlr.c |  303 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..4ac63f5 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -309,6 +309,17 @@ config I2C_AU1550
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
 
+config I2C_XLR
+	tristate "XLR I2C support"
+	depends on CPU_XLR
+	help
+	  This driver enables support for the on-chip I2C interface of
+	  the Netlogic XLR/XLS MIPS processors.
+
+	  Say yes to this option if you have a Netlogic XLR/XLS based
+	  board and you need to access the I2C devices (typically the
+	  RTC, sensors, EEPROM) connected to this interface.
+
 config I2C_BLACKFIN_TWI
 	tristate "Blackfin TWI I2C support"
 	depends on BLACKFIN
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e6cf294..14e7a76 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
+obj-$(CONFIG_I2C_XLR)           += i2c-xlr.o
 obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
 
 # External I2C/SMBus adapter drivers
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
new file mode 100644
index 0000000..d433b2f
--- /dev/null
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -0,0 +1,303 @@
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
+#include <asm/netlogic/xlr/iomap.h>
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
+/* Register Programming Values!! Change as required */
+#define XLR_I2C_CFG_ADDR	0xF8    /* 8-Bit dev Addr + POR Values */
+#define XLR_I2C_CFG_NOADDR	0xFA    /* 8-Bit reg Addr + POR Values */
+#define XLR_I2C_STARTXFR_ND	0x02    /* No data , only addr */
+#define XLR_I2C_STARTXFR_RD	0x01    /* Read */
+#define XLR_I2C_STARTXFR_WR	0x00    /* Write */
+#define XLR_I2C_CLKDIV_DEF	0x14A   /* 0x00000052 */
+#define XLR_I2C_HDSTATIM_DEF	0x107   /* 0x00000000 */
+
+#define XLR_I2C_IO_SIZE		0x1000
+
+struct xlr_i2c_private {
+	struct i2c_adapter adap;
+	u32 __iomem *iobase;
+};
+
+static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
+		u8 *buf, u16 addr)
+{
+	u32 i2c_status = 0x00;
+	u8 nb;
+	int pos, timeout = 0;
+	struct i2c_adapter *adap = &priv->adap;
+	u8 offset = buf[0];
+
+	netlogic_write_reg(priv->iobase, XLR_I2C_ADDR, offset);
+	netlogic_write_reg(priv->iobase, XLR_I2C_DEVADDR, addr);
+	netlogic_write_reg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
+	netlogic_write_reg(priv->iobase, XLR_I2C_BYTECNT, len-1);
+
+retry:
+	timeout = 0;
+	pos = 1;
+	if (len == 1) {
+		netlogic_write_reg(priv->iobase, XLR_I2C_STARTXFR,
+				XLR_I2C_STARTXFR_ND);
+	} else {
+		netlogic_write_reg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
+		netlogic_write_reg(priv->iobase, XLR_I2C_STARTXFR,
+				XLR_I2C_STARTXFR_WR);
+	}
+
+	while (1) {
+		if (timeout++ > 0x1000) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD Rx Timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		i2c_status = netlogic_read_reg(priv->iobase, XLR_I2C_STATUS);
+
+		if (i2c_status & XLR_I2C_SDOEMPTY) {
+			pos++;
+			nb = (pos < len) ? buf[pos] : 0;
+			netlogic_write_reg(priv->iobase, XLR_I2C_DATAOUT, nb);
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			dev_err(&priv->adap.dev, "Tx ACK ERR\n");
+			return -EIO;
+		}
+
+		if (i2c_status & XLR_I2C_BUS_BUSY) {
+			udelay(1);
+			continue;
+		}
+
+		if (pos >= len)
+			break;
+	}
+
+	return 0;
+}
+
+static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len,
+		u8 *buf, u16 addr)
+{
+	u32 i2c_status = 0x00;
+	int pos = 0;
+	int timeout = 0;
+	struct i2c_adapter *adap = &priv->adap;
+
+	netlogic_write_reg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
+	netlogic_write_reg(priv->iobase, XLR_I2C_BYTECNT, len);
+	netlogic_write_reg(priv->iobase, XLR_I2C_DEVADDR, addr);
+
+retry:
+	timeout = 0;
+	netlogic_write_reg(priv->iobase, XLR_I2C_STARTXFR,
+			XLR_I2C_STARTXFR_RD);
+
+	while (1) {
+		if (timeout++ > 0x1000) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD Rx Timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		i2c_status = netlogic_read_reg(priv->iobase,
+				XLR_I2C_STATUS);
+		if (i2c_status & XLR_I2C_RXRDY) {
+			buf[pos++] = (u8)netlogic_read_reg(priv->iobase,
+					XLR_I2C_DATAIN);
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD ACK ERR\n");
+			return -EIO;
+		}
+
+		if ((i2c_status & XLR_I2C_BUS_BUSY) == 0)
+			break;
+		udelay(1);
+	}
+	return 0;
+}
+
+static int xlr_i2c_xfer(struct i2c_adapter *adap,
+		struct i2c_msg *msgs, int num)
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
+static int xlr_i2c_add_bus(struct xlr_i2c_private *priv)
+{
+	priv->adap.owner	= THIS_MODULE;
+	priv->adap.algo_data	= priv;
+	priv->adap.nr		= 1;
+	priv->adap.algo		= &xlr_i2c_algo;
+	priv->adap.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	snprintf(priv->adap.name, sizeof(priv->adap.name),
+			"SMBus XLR I2C Adapter");
+	i2c_set_adapdata(&priv->adap, priv);
+	/* register new adapter to i2c module... */
+	if (i2c_add_numbered_adapter(&priv->adap))
+		return -1;
+
+	return 0;
+}
+
+static int __devinit xlr_i2c_probe(struct platform_device *pdev)
+{
+	struct xlr_i2c_private  *priv;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res) {
+		ret = -ENXIO;
+		goto err1;
+	}
+
+	if (!request_mem_region(res->start, XLR_I2C_IO_SIZE, pdev->name)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	priv = kzalloc(sizeof(struct xlr_i2c_private), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	priv->adap.dev.parent = &pdev->dev;
+	priv->iobase = (u32 *) ioremap(res->start, XLR_I2C_IO_SIZE);
+	if (!priv->iobase) {
+		ret = -ENOMEM;
+		goto err3;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	ret = xlr_i2c_add_bus(priv);
+
+	if (ret < 0) {
+		dev_err(&priv->adap.dev, "Failed to add i2c bus\n");
+		ret = -ENXIO;
+		goto err4;
+	} else
+		dev_info(&priv->adap.dev, "Added I2C Bus.\n");
+
+	return 0;
+err4:
+	iounmap(priv->iobase);
+	platform_set_drvdata(pdev, NULL);
+err3:
+	kfree(priv);
+err2:
+	release_mem_region(res->start, IORESOURCE_MEM);
+err1:
+	return ret;
+}
+
+static int __devexit xlr_i2c_remove(struct platform_device *pdev)
+{
+	struct xlr_i2c_private *priv = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	i2c_del_adapter(&priv->adap);
+	iounmap(priv->iobase);
+	kfree(priv);
+	release_mem_region(res->start, IORESOURCE_MEM);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver xlr_i2c_driver = {
+	.probe  = xlr_i2c_probe,
+	.remove = __devexit_p(xlr_i2c_remove),
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "xlr-i2cbus",
+	},
+};
+
+static int __init xlr_i2c_init(void)
+{
+	return platform_driver_register(&xlr_i2c_driver);
+}
+
+static void __exit xlr_i2c_exit(void)
+{
+	platform_driver_unregister(&xlr_i2c_driver);
+}
+
+MODULE_AUTHOR("Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>");
+MODULE_DESCRIPTION("XLR I2C SMBus driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:xlr-i2cbus");
+
+module_init(xlr_i2c_init);
+module_exit(xlr_i2c_exit);
-- 
1.7.4.1
