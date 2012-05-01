From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=203/4=5D=20MXS=3A=20Implement=20DMA=20support=20into=20mxs-i2c?=
Date: Tue,  1 May 2012 04:00:20 +0200
Message-ID: <1335837621-14816-4-git-send-email-marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335837621-14816-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch implements DMA support into mxs-i2c. DMA transfers are now e=
nabled
via platform data. The behaviour of this driver should not change for a=
ny of
the current platforms. Though it is recommended to enable DMA operation=
=2E

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
CC: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |    5 +
 arch/arm/mach-mxs/include/mach/devices-common.h |    1 +
 drivers/i2c/busses/i2c-mxs.c                    |  260 +++++++++++++++=
++++++--
 include/linux/i2c/mxs-i2c.h                     |    1 +
 4 files changed, 244 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c b/arch/arm/ma=
ch-mxs/devices/platform-mxs-i2c.c
index bb325b9..341aec9 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
@@ -15,6 +15,7 @@
 	{								\
 		.id =3D _id,						\
 		.iobase =3D soc ## _I2C ## _id ## _BASE_ADDR,		\
+		.dma	=3D soc ## _DMA_I2C ## _id,			\
 		.errirq =3D soc ## _INT_I2C ## _id ## _ERROR,		\
 		.dmairq =3D soc ## _INT_I2C ## _id ## _DMA,		\
 	}
@@ -39,6 +40,10 @@ struct platform_device *__init mxs_add_mxs_i2c(
 			.end =3D data->iobase + SZ_8K - 1,
 			.flags =3D IORESOURCE_MEM,
 		}, {
+			.start	=3D data->dma,
+			.end	=3D data->dma,
+			.flags	=3D IORESOURCE_DMA,
+		}, {
 			.start =3D data->errirq,
 			.end =3D data->errirq,
 			.flags =3D IORESOURCE_IRQ,
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm=
/mach-mxs/include/mach/devices-common.h
index 7bf2894..f5d3bf6 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -81,6 +81,7 @@ mxs_add_gpmi_nand(const struct gpmi_nand_platform_dat=
a *pdata,
 struct mxs_mxs_i2c_data {
 	int id;
 	resource_size_t iobase;
+	resource_size_t dma;
 	resource_size_t errirq;
 	resource_size_t dmairq;
 };
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.=
c
index 717b7f9..7491194 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -7,8 +7,6 @@
  *
  * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Re=
served.
  *
- * TODO: add dma-support if platform-support for it is available
- *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License as published b=
y
  * the Free Software Foundation; either version 2 of the License, or
@@ -27,6 +25,9 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/fsl/mxs-dma.h>
=20
 #include <mach/common.h>
=20
@@ -134,6 +135,16 @@ struct mxs_i2c_dev {
 	u32 cmd_err;
 	struct i2c_adapter adapter;
 	const struct mxs_i2c_speed_config *speed;
+
+	/* DMA support components */
+	bool				dma_mode;
+	struct resource			*dmares;
+	struct dma_chan         	*dmach;
+	struct mxs_dma_data		dma_data;
+	uint32_t			pio_data[2];
+	uint32_t			addr_data;
+	struct scatterlist		sg_io[2];
+	bool				dma_read;
 };
=20
 /*
@@ -149,7 +160,12 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
=20
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
-	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+
+	if (i2c->dma_mode)
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
+	else
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
 }
=20
@@ -240,9 +256,155 @@ static int mxs_i2c_finish_read(struct mxs_i2c_dev=
 *i2c, u8 *buf, int len)
 	return 0;
 }
=20
+static void mxs_i2c_dma_finish(struct mxs_i2c_dev *i2c)
+{
+	if (i2c->dma_read) {
+		dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+		dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+	} else {
+		dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+	}
+}
+
+static void mxs_i2c_dma_irq_callback(void *param)
+{
+	struct mxs_i2c_dev *i2c =3D param;
+
+	complete(&i2c->cmd_complete);
+	mxs_i2c_dma_finish(i2c);
+}
+
+static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
+			struct i2c_msg *msg, uint32_t flags)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct mxs_i2c_dev *i2c =3D i2c_get_adapdata(adap);
+
+	if (msg->flags & I2C_M_RD) {
+		i2c->dma_read =3D 1;
+		i2c->addr_data =3D (msg->addr << 1) | I2C_SMBUS_READ;
+
+		/*
+		 * SELECT command.
+		 */
+
+		/* Queue the PIO register write transfer. */
+		i2c->pio_data[0] =3D MXS_CMD_I2C_SELECT;
+		desc =3D dmaengine_prep_slave_sg(i2c->dmach,
+					(struct scatterlist *)&i2c->pio_data[0],
+					1, DMA_TRANS_NONE, 0);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto select_init_pio_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_one(&i2c->sg_io[0], &i2c->addr_data, 1);
+		dma_map_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+		desc =3D dmaengine_prep_slave_sg(i2c->dmach, &i2c->sg_io[0], 1,
+					DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto select_init_dma_fail;
+		}
+
+		/*
+		 * READ command.
+		 */
+
+		/* Queue the PIO register write transfer. */
+		i2c->pio_data[1] =3D flags | MXS_CMD_I2C_READ |
+				MXS_I2C_CTRL0_XFER_COUNT(msg->len);
+		desc =3D dmaengine_prep_slave_sg(i2c->dmach,
+					(struct scatterlist *)&i2c->pio_data[1],
+					1, DMA_TRANS_NONE, DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto select_init_dma_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_one(&i2c->sg_io[1], msg->buf, msg->len);
+		dma_map_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+		desc =3D dmaengine_prep_slave_sg(i2c->dmach, &i2c->sg_io[1], 1,
+					DMA_DEV_TO_MEM,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto read_init_dma_fail;
+		}
+	} else {
+		i2c->dma_read =3D 0;
+		i2c->addr_data =3D (msg->addr << 1) | I2C_SMBUS_WRITE;
+
+		/*
+		 * WRITE command.
+		 */
+
+		/* Queue the PIO register write transfer. */
+		i2c->pio_data[0] =3D flags | MXS_CMD_I2C_WRITE |
+				MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1);
+		desc =3D dmaengine_prep_slave_sg(i2c->dmach,
+					(struct scatterlist *)&i2c->pio_data[0],
+					1, DMA_TRANS_NONE, 0);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto write_init_pio_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_table(i2c->sg_io, 2);
+		sg_set_buf(&i2c->sg_io[0], &i2c->addr_data, 1);
+		sg_set_buf(&i2c->sg_io[1], msg->buf, msg->len);
+		dma_map_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+		desc =3D dmaengine_prep_slave_sg(i2c->dmach, i2c->sg_io, 2,
+					DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto write_init_dma_fail;
+		}
+	}
+
+	/*
+	 * The last descriptor must have this callback,
+	 * to finish the DMA transaction.
+	 */
+	desc->callback =3D mxs_i2c_dma_irq_callback;
+	desc->callback_param =3D i2c;
+
+	/* Start the transfer. */
+	dmaengine_submit(desc);
+	dma_async_issue_pending(i2c->dmach);
+	return 0;
+
+/* Read failpath. */
+read_init_dma_fail:
+	dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+select_init_dma_fail:
+	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+select_init_pio_fail:
+	return 1;
+
+
+/* Write failpath. */
+write_init_dma_fail:
+	dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+write_init_pio_fail:
+	return 1;
+}
+
 /*
  * Low level master read/write transaction.
  */
+
 static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *=
msg,
 				int stop)
 {
@@ -250,6 +412,8 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *ada=
p, struct i2c_msg *msg,
 	int ret;
 	int flags;
=20
+	flags =3D stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
+
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
=20
@@ -258,23 +422,30 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *a=
dap, struct i2c_msg *msg,
=20
 	init_completion(&i2c->cmd_complete);
=20
-	flags =3D stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
-
-	if (msg->flags & I2C_M_RD)
-		mxs_i2c_pioq_setup_read(i2c, msg->addr, msg->len, flags);
-	else
-		mxs_i2c_pioq_setup_write(i2c, msg->addr, msg->buf, msg->len,
-					flags);
+	if (i2c->dma_mode) {
+		ret =3D mxs_i2c_dma_setup_xfer(adap, msg, flags);
+		if (ret)
+			return -EINVAL;
+	} else {
+		if (msg->flags & I2C_M_RD) {
+			mxs_i2c_pioq_setup_read(i2c, msg->addr,
+						msg->len, flags);
+		} else {
+			mxs_i2c_pioq_setup_write(i2c, msg->addr, msg->buf,
+						msg->len, flags);
+		}
=20
-	writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
+		writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
+	}
=20
 	ret =3D wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
+
 	if (ret =3D=3D 0)
 		goto timeout;
=20
-	if ((!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
+	if (!i2c->dma_mode && (!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
 		ret =3D mxs_i2c_finish_read(i2c, msg->buf, msg->len);
 		if (ret)
 			goto timeout;
@@ -289,7 +460,9 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *ada=
p, struct i2c_msg *msg,
=20
 timeout:
 	dev_dbg(i2c->dev, "Timeout!\n");
+	mxs_i2c_dma_finish(i2c);
 	mxs_i2c_reset(i2c);
+
 	return -ETIMEDOUT;
 }
=20
@@ -332,11 +505,13 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void=
 *dev_id)
 	else
 		i2c->cmd_err =3D 0;
=20
-	is_last_cmd =3D (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
-		MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) =3D=3D 0;
+	if (!i2c->dma_mode) {
+		is_last_cmd =3D (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
+			MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) =3D=3D 0;
=20
-	if (is_last_cmd || i2c->cmd_err)
-		complete(&i2c->cmd_complete);
+		if (!i2c->dma_mode && (is_last_cmd || i2c->cmd_err))
+			complete(&i2c->cmd_complete);
+	}
=20
 	writel(stat, i2c->regs + MXS_I2C_CTRL1_CLR);
=20
@@ -348,15 +523,31 @@ static const struct i2c_algorithm mxs_i2c_algo =3D=
 {
 	.functionality =3D mxs_i2c_func,
 };
=20
+static bool mxs_i2c_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct mxs_i2c_dev *i2c =3D param;
+
+	if (!mxs_dma_is_apbx(chan))
+		return false;
+
+	if (chan->chan_id !=3D i2c->dmares->start)
+		return false;
+
+	chan->private =3D &i2c->dma_data;
+
+	return true;
+}
+
 static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct mxs_i2c_platform_data *pdata =3D pdev->dev.platform_data;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
-	struct resource *res;
+	struct resource *res, *dmares;
 	resource_size_t res_size;
-	int err, irq;
+	int err, irq, dmairq;
+	dma_cap_mask_t mask;
=20
 	if (!pdata)
 		return -ENODEV;
@@ -366,7 +557,11 @@ static int __devinit mxs_i2c_probe(struct platform=
_device *pdev)
 		return -ENOMEM;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	dmares =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	irq =3D platform_get_irq(pdev, 0);
+	dmairq =3D platform_get_irq(pdev, 1);
+
+	if (!res || !dmares || irq < 0 || dmairq < 0)
 		return -ENOENT;
=20
 	res_size =3D resource_size(res);
@@ -377,10 +572,6 @@ static int __devinit mxs_i2c_probe(struct platform=
_device *pdev)
 	if (!i2c->regs)
 		return -EBUSY;
=20
-	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	err =3D devm_request_irq(dev, irq, mxs_i2c_isr, 0, dev_name(dev), i2c=
);
 	if (err)
 		return err;
@@ -394,6 +585,26 @@ static int __devinit mxs_i2c_probe(struct platform=
_device *pdev)
 	else if (pdata->speed_khz !=3D 100)
 		dev_err(dev, "Invalid I2C speed selected, using 100kHz\n");
=20
+	/*
+	 * The MXS I2C DMA mode is prefered and enabled by default.
+	 * The PIO mode is still supported, but should be used only
+	 * for debuging purposes etc.
+	 */
+	i2c->dma_mode =3D !pdata->use_pioqueue;
+
+	/* Setup the DMA */
+	if (i2c->dma_mode) {
+		i2c->dmares =3D dmares;
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		i2c->dma_data.chan_irq =3D dmairq;
+		i2c->dmach =3D dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
+		if (!i2c->dmach) {
+			dev_err(dev, "Failed to request dma\n");
+			return -ENODEV;
+		}
+	}
+
 	platform_set_drvdata(pdev, i2c);
=20
 	/* Do reset to enforce correct startup after pinmuxing */
@@ -426,6 +637,9 @@ static int __devexit mxs_i2c_remove(struct platform=
_device *pdev)
 	if (ret)
 		return -EBUSY;
=20
+	if (i2c->dmach)
+		dma_release_channel(i2c->dmach);
+
 	writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
 			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
diff --git a/include/linux/i2c/mxs-i2c.h b/include/linux/i2c/mxs-i2c.h
index 781b080..16f23dc 100644
--- a/include/linux/i2c/mxs-i2c.h
+++ b/include/linux/i2c/mxs-i2c.h
@@ -16,6 +16,7 @@
=20
 struct mxs_i2c_platform_data {
 	uint16_t	speed_khz;
+	bool		use_pioqueue;
 };
=20
 #endif	/* __INCLUDE_LINUX_I2C_MXS_I2C_H__ */
--=20
1.7.10
