From: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH, RFC] Freescale STMP: i2c driver, updated with correct
 signed-off lines
Date: Mon, 22 Jun 2009 17:42:03 +0400
Message-ID: <1245678123.4813.20.camel@hp.diimka.lan>
References: <1244059155.4074.19.camel@hp.diimka.lan>
	 <20090615081938.GA19878@fluff.org.uk>
	 <1245169913.32549.19.camel@hp.diimka.lan>
	 <20090622004741.GB9006@fluff.org.uk>
Reply-To: dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090622004741.GB9006-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2009-06-22 at 01:47 +0100, Ben Dooks wrote:
> On Tue, Jun 16, 2009 at 08:31:53PM +0400, dmitry pervushin wrote:
> > On Mon, 2009-06-15 at 09:19 +0100, Ben Dooks wrote:
> > > any chance of an reply or update driver for inclusion?
> > Here it is:

Add I2C driver for Freescale STMP boards

From: Dmitrij Frasenyak <d.frasenyak-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org> 
Signed-off-by: Dmitrij Frasenyak <d.frasenyak-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Signed-off-by: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>

---
 drivers/i2c/busses/Kconfig        |    7 
 drivers/i2c/busses/Makefile       |    1 
 drivers/i2c/busses/i2c-stmp378x.c |  450 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 458 insertions(+)

Index: linux-2.6-arm/drivers/i2c/busses/Kconfig
===================================================================
--- linux-2.6-arm.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6-arm/drivers/i2c/busses/Kconfig
@@ -513,6 +513,13 @@ config I2C_SIMTEC
 	  This driver can also be built as a module. If so, the module
 	  will be called i2c-simtec.
 
+config I2C_STMP378X
+	tristate "STMP378x I2C adapter"
+	depends on ARCH_STMP378X
+	help
+	  Include support of I2C adapter on Freescale STMP378x board; to build
+	  the driver as a module, say M here - module will be called i2c-stmp378x.
+
 config I2C_VERSATILE
 	tristate "ARM Versatile/Realview I2C bus support"
 	depends on ARCH_VERSATILE || ARCH_REALVIEW
Index: linux-2.6-arm/drivers/i2c/busses/Makefile
===================================================================
--- linux-2.6-arm.orig/drivers/i2c/busses/Makefile
+++ linux-2.6-arm/drivers/i2c/busses/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_I2C_S6000)		+= i2c-s6000.o
 obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
 obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
 obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
+obj-$(CONFIG_I2C_STMP378X)	+= i2c-stmp378x.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 
 # External I2C/SMBus adapter drivers
Index: linux-2.6-arm/drivers/i2c/busses/i2c-stmp378x.c
===================================================================
--- /dev/null
+++ linux-2.6-arm/drivers/i2c/busses/i2c-stmp378x.c
@@ -0,0 +1,450 @@
+/*
+ * Freescale STMP378X I2C bus driver
+ *
+ * Author: Dmitrij Frasenyak <sed-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
+ *
+ * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/platform.h>
+#include <mach/stmp3xxx.h>
+#include <mach/dma.h>
+#include <mach/regs-i2c.h>
+#include <mach/regs-apbx.h>
+
+static const struct stmp3xxx_dma_command cmd_i2c_select = {
+	.cmd =	(1 << BP_APBX_CHn_CMD_XFER_COUNT)	|
+		(1 << BP_APBX_CHn_CMD_CMDWORDS)	|
+		BM_APBX_CHn_CMD_WAIT4ENDCMD	|
+		BM_APBX_CHn_CMD_CHAIN		|
+		(BV_APBX_CHn_CMD_COMMAND__DMA_READ << BP_APBX_CHn_CMD_COMMAND),
+	.pio_words = {
+		[0] = 	BM_I2C_CTRL0_RETAIN_CLOCK   |
+			BM_I2C_CTRL0_PRE_SEND_START |
+			BM_I2C_CTRL0_MASTER_MODE    |
+			BM_I2C_CTRL0_DIRECTION      |
+			(1 << BP_I2C_CTRL0_XFER_COUNT),
+	},
+};
+
+static const struct stmp3xxx_dma_command cmd_i2c_write = {
+	.cmd =	BM_APBX_CHn_CMD_SEMAPHORE	|
+		(1 << BP_APBX_CHn_CMD_CMDWORDS)	|
+		BM_APBX_CHn_CMD_WAIT4ENDCMD	|
+		BM_APBX_CHn_CMD_IRQONCMPLT	|
+		(BV_APBX_CHn_CMD_COMMAND__DMA_READ << BP_APBX_CHn_CMD_COMMAND),
+	.pio_words = {
+		[0] =	BM_I2C_CTRL0_PRE_SEND_START |
+			BM_I2C_CTRL0_MASTER_MODE    |
+			BM_I2C_CTRL0_DIRECTION,
+	},
+};
+
+static const struct stmp3xxx_dma_command cmd_i2c_read = {
+	.cmd =	BM_APBX_CHn_CMD_SEMAPHORE	|
+		(1 << BP_APBX_CHn_CMD_CMDWORDS)	|
+		BM_APBX_CHn_CMD_WAIT4ENDCMD	|
+		BM_APBX_CHn_CMD_IRQONCMPLT	|
+		(BV_APBX_CHn_CMD_COMMAND__DMA_WRITE << BP_APBX_CHn_CMD_COMMAND),
+	.pio_words = {
+		[0] =	BM_I2C_CTRL0_SEND_NAK_ON_LAST	|
+			BM_I2C_CTRL0_MASTER_MODE,
+	},
+};
+
+/**
+ * struct stmp378x_i2c_dev - STMP3xxx I2C adapter data
+ * @dev: the associated platform_device
+ * @cmd_complete: the completion structure indicating that message has been
+ * 	transferred
+ * @cmd_err: current error code
+ * @adapter: the adapter we implement
+ * @io: io address
+ * @irq: irq number
+ * @dma: dma channel
+ * @bufv: pointer to the dma buffer
+ * @bufp: physical address of the dma buffer
+ * @i2c_dma_read: "read" dma chain (read request and then write)
+ * @i2c_dma_write: "write" dma chain (the single combined write request)
+ */
+struct stmp378x_i2c_dev {
+	struct device		*dev;
+	int			irq;
+	struct completion	cmd_complete;
+	u32			cmd_err;
+	struct i2c_adapter	adapter;
+	void __iomem 		*io;
+	unsigned		dma;
+
+	dma_addr_t		bufp;
+	unsigned char		*bufv;
+
+	struct stmp3xxx_dma_descriptor i2c_dma_read[2],
+				       i2c_dma_write;
+};
+
+static int stmp378x_i2c_init(struct stmp378x_i2c_dev *dev)
+{
+	int err;
+
+	err = stmp3xxx_dma_request(dev->dma, dev->dev, dev_name(dev->dev));
+	if (err)
+		goto out;
+	stmp3xxx_reset_block(dev->io, true);
+
+	dev->bufv = dma_alloc_coherent(dev->dev, PAGE_SIZE,
+				       &dev->bufp, GFP_KERNEL);
+	if (!dev->bufv)
+		goto out_dma;
+
+	err = stmp3xxx_request_pin_group(dev->dev->platform_data,
+			dev_name(dev->dev));
+	if (err)
+		goto out_free;
+
+	err = stmp3xxx_dma_allocate_command(dev->dma, &dev->i2c_dma_read[0]);
+	if (err)
+		goto out_rd0;
+	err = stmp3xxx_dma_allocate_command(dev->dma, &dev->i2c_dma_read[1]);
+	if (err)
+		goto out_rd1;
+	err = stmp3xxx_dma_allocate_command(dev->dma, &dev->i2c_dma_write);
+	if (err)
+		goto out_wr;
+
+	stmp3xxx_dma_reset_channel(dev->dma);
+	stmp3xxx_dma_clear_interrupt(dev->dma);
+	stmp3xxx_dma_enable_interrupt(dev->dma);
+
+	return 0;
+/*
+	stmp3xxx_dma_free_command(dev->dma, &dev->i2c_dma_write);
+*/
+out_wr:
+	stmp3xxx_dma_free_command(dev->dma, &dev->i2c_dma_read[1]);
+out_rd1:
+	stmp3xxx_dma_free_command(dev->dma, &dev->i2c_dma_read[0]);
+out_rd0:
+	stmp3xxx_release_pin_group(dev->dev->platform_data, dev_name(dev->dev));
+out_free:
+	dma_free_coherent(dev->dev, PAGE_SIZE, dev->bufv, dev->bufp);
+out_dma:
+	stmp3xxx_dma_release(dev->dma);
+out:
+	return err;
+}
+
+static void stmp378x_i2c_release(struct stmp378x_i2c_dev *dev)
+{
+	stmp3xxx_dma_free_command(dev->dma, &dev->i2c_dma_write);
+	stmp3xxx_dma_free_command(dev->dma, &dev->i2c_dma_read[1]);
+	stmp3xxx_dma_free_command(dev->dma, &dev->i2c_dma_read[0]);
+	dma_free_coherent(dev->dev, PAGE_SIZE, dev->bufv, dev->bufp);
+	stmp3xxx_release_pin_group(dev->dev->platform_data, dev_name(dev->dev));
+	stmp3xxx_dma_release(dev->dma);
+}
+/*
+ * Low level master read/write transaction.
+ */
+static int stmp378x_i2c_xfer_msg(struct i2c_adapter *adap,
+				 struct i2c_msg *msg, int stop)
+{
+	struct stmp378x_i2c_dev *dev = i2c_get_adapdata(adap);
+	int err;
+	struct stmp3xxx_dma_descriptor *c, *r;
+
+	init_completion(&dev->cmd_complete);
+	dev->cmd_err = 0;
+
+	if ((msg->len == 0) || (msg->len > (PAGE_SIZE - 1)))
+		return -EINVAL;
+
+	if (msg->flags & I2C_M_RD) {
+
+		c = &dev->i2c_dma_read[0];
+		r = &dev->i2c_dma_read[1];
+
+		/* first, setup the SELECT command */
+		memcpy(c->command, &cmd_i2c_select, sizeof(cmd_i2c_select));
+		c->command->buf_ptr = dev->bufp;
+		dev->bufv[0] = msg->addr | I2C_SMBUS_READ;
+
+		/* then, setup the READ command */
+		memcpy(r->command, &cmd_i2c_read, sizeof(cmd_i2c_read));
+		r->command->cmd |= (msg->len << BP_APBX_CHn_CMD_XFER_COUNT);
+		r->command->pio_words[0] |=
+				(msg->len << BP_I2C_CTRL0_XFER_COUNT);
+		if (stop)
+			r->command->pio_words[0] |= BM_I2C_CTRL0_POST_SEND_STOP;
+		/*
+		 * yes, STMP controller can DMA transfer the data from any
+		 * byte boundary
+		 */
+		r->command->buf_ptr = dev->bufp + 1;
+
+		/* and chain them together */
+		c->command->next = r->handle;
+
+	} else {
+
+		c = &dev->i2c_dma_write;
+		memcpy(c->command, &cmd_i2c_write, sizeof(cmd_i2c_write));
+		c->command->cmd |=
+				((msg->len + 1) << BP_APBX_CHn_CMD_XFER_COUNT);
+		c->command->pio_words[0] |=
+				((msg->len + 1) << BP_I2C_CTRL0_XFER_COUNT);
+		if (stop)
+			c->command->pio_words[0] |=
+				   BM_I2C_CTRL0_POST_SEND_STOP;
+		dev->bufv[0] = msg->addr | I2C_SMBUS_WRITE;
+		memcpy(dev->bufv + 1, msg->buf, msg->len);
+	}
+
+	stmp3xxx_dma_go(dev->dma, c, 1);
+
+	err = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
+							msecs_to_jiffies(1000));
+
+	if (err < 0) {
+		dev_dbg(dev->dev, "controler is timed out\n");
+		return -ETIMEDOUT;
+	}
+	if (!dev->cmd_err && (msg->flags & I2C_M_RD))
+		memcpy(msg->buf, dev->bufv + 1, msg->len);
+
+	dev_dbg(dev->dev, "done with err=%d\n", dev->cmd_err);
+
+	return dev->cmd_err;
+}
+
+
+static int
+stmp378x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	int i;
+	int err;
+
+	if (!msgs->len)
+		return -EINVAL;
+
+	for (i = 0; i < num; i++) {
+		err = stmp378x_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
+		if (err)
+			return err;
+	}
+	return num;
+}
+
+static u32
+stmp378x_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+}
+
+#define I2C_IRQ_MASK 0x000000FF
+static irqreturn_t
+stmp378x_i2c_isr(int this_irq, void *dev_id)
+{
+	struct stmp378x_i2c_dev *dev = dev_id;
+	u32 stat;
+	u32 done_mask = BM_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ |
+			BM_I2C_CTRL1_BUS_FREE_IRQ ;
+
+	stat = readl(HW_I2C_CTRL1 + dev->io) & I2C_IRQ_MASK;
+	if (!stat)
+		return IRQ_NONE;
+
+	if (stat & BM_I2C_CTRL1_NO_SLAVE_ACK_IRQ) {
+		dev->cmd_err = -EREMOTEIO;
+
+		/*
+		 * Stop DMA
+		 * Clear NAK
+		 */
+		stmp3xxx_setl(BM_I2C_CTRL1_CLR_GOT_A_NAK,
+			      HW_I2C_CTRL1 + dev->io);
+		stmp3xxx_dma_reset_channel(dev->dma);
+		stmp3xxx_dma_clear_interrupt(dev->dma);
+
+		complete(&dev->cmd_complete);
+
+		goto done;
+	}
+
+	/* Don't care about  BM_I2C_CTRL1_OVERSIZE_XFER_TERM_IRQ */
+	if (stat & (BM_I2C_CTRL1_EARLY_TERM_IRQ |
+		    BM_I2C_CTRL1_MASTER_LOSS_IRQ |
+		    BM_I2C_CTRL1_SLAVE_STOP_IRQ |
+		    BM_I2C_CTRL1_SLAVE_IRQ)) {
+		dev->cmd_err = -EIO;
+		complete(&dev->cmd_complete);
+		goto done;
+	}
+
+	if ((stat & done_mask) == done_mask)
+		complete(&dev->cmd_complete);
+
+done:
+	stmp3xxx_clearl(stat, dev->io + HW_I2C_CTRL1);
+	return IRQ_HANDLED;
+}
+
+static const struct i2c_algorithm stmp378x_i2c_algo = {
+	.master_xfer	= stmp378x_i2c_xfer,
+	.functionality	= stmp378x_i2c_func,
+};
+
+
+static int __devinit
+stmp378x_i2c_probe(struct platform_device *pdev)
+{
+	struct stmp378x_i2c_dev	*dev;
+	struct i2c_adapter	*adap;
+	struct resource		*mem, *dma;
+	int err = 0;
+
+	dev = kzalloc(sizeof(struct stmp378x_i2c_dev), GFP_KERNEL);
+	if (!dev) {
+		dev_err(&pdev->dev, "no mem \n");
+		return -ENOMEM;
+	}
+
+	dev->irq = platform_get_irq(pdev, 0); /* Error */
+	if (dev->irq < 0) {
+		dev_err(&pdev->dev, "no err_irq resource\n");
+		err = dev->irq;
+		goto nores;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "no memory window\n");
+		err = -ENODEV;
+		goto nores;
+	}
+
+	dma = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!dma) {
+		dev_err(&pdev->dev, "no dma channel\n");
+		err = -ENODEV;
+		goto nores;
+	}
+	dev->dma = dma->start;
+
+	dev->dev = &pdev->dev;
+	dev->io = ioremap(mem->start, resource_size(mem));
+	if (!dev->io) {
+		dev_err(&pdev->dev, "cannot ioremap\n");
+		err = -ENXIO;
+		goto nores;
+	}
+
+	err = request_irq(dev->irq, stmp378x_i2c_isr, 0, pdev->name, dev);
+	if (err) {
+		dev_err(&pdev->dev, "Can't get IRQ\n");
+		goto no_err_irq;
+	}
+
+	err = stmp378x_i2c_init(dev);
+	if (err) {
+		dev_err(&pdev->dev, "HW Init failed\n");
+		goto init_failed;
+	}
+
+	stmp3xxx_setl(0xFF00, dev->io + HW_I2C_CTRL1);
+
+	adap = &dev->adapter;
+	i2c_set_adapdata(adap, dev);
+	adap->owner = THIS_MODULE;
+	adap->class = I2C_CLASS_TV_DIGITAL;
+	strncpy(adap->name, "378x I2C adapter", sizeof(adap->name));
+	adap->algo = &stmp378x_i2c_algo;
+	adap->dev.parent = &pdev->dev;
+
+	adap->nr = pdev->id;
+	err = i2c_add_numbered_adapter(adap);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add adapter\n");
+		goto no_i2c_adapter;
+
+	}
+
+	return 0;
+
+no_i2c_adapter:
+	stmp378x_i2c_release(dev);
+init_failed:
+	free_irq(dev->irq, dev);
+no_err_irq:
+	iounmap(dev->io);
+nores:
+	kfree(dev);
+	return err;
+}
+
+static int __devexit
+stmp378x_i2c_remove(struct platform_device *pdev)
+{
+	struct stmp378x_i2c_dev	*dev = platform_get_drvdata(pdev);
+	int res;
+
+	res = i2c_del_adapter(&dev->adapter);
+	if (res)
+		return -EBUSY;
+
+	stmp378x_i2c_release(dev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	free_irq(dev->irq, dev);
+	iounmap(dev->io);
+
+	kfree(dev);
+	return 0;
+}
+
+static struct platform_driver stmp378x_i2c_driver = {
+	.probe		= stmp378x_i2c_probe,
+	.remove		= __devexit_p(stmp378x_i2c_remove),
+	.driver		= {
+		.name	= "i2c_stmp3xxx",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init stmp378x_i2c_init_driver(void)
+{
+	return platform_driver_register(&stmp378x_i2c_driver);
+}
+module_init(stmp378x_i2c_init_driver);
+
+static void __exit stmp378x_i2c_exit_driver(void)
+{
+	platform_driver_unregister(&stmp378x_i2c_driver);
+}
+module_exit(stmp378x_i2c_exit_driver);
+
+MODULE_AUTHOR("d.frasenyak-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org");
+MODULE_DESCRIPTION("I2C for Freescale STMP378x");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:i2c_stmp3xxx");
