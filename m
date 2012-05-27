From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
Date: Sun, 27 May 2012 04:10:56 +0200
Message-ID: <1338084656-11961-2-git-send-email-marex@denx.de>
References: <1338084656-11961-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338084656-11961-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch implements DMA support into mxs-i2c. DMA transfers are now e=
nabled
via DT. The DMA operation is enabled by default.

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
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    3 +
 arch/arm/boot/dts/imx28.dtsi                      |    2 +
 drivers/i2c/busses/i2c-mxs.c                      |  268 +++++++++++++=
++++++--
 3 files changed, 251 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Docume=
ntation/devicetree/bindings/i2c/i2c-mxs.txt
index 790b5c6..f4b6244 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
@@ -6,6 +6,9 @@ Required properties:
 - interrupts: Should contain ERROR and DMA interrupts
 - speed: Speed of the bus in kHz (400 or 100 are supported)
=20
+Optional properties:
+- use-pio: Use PIO transfers instead of DMA, useful for debug
+
 Examples:
=20
 i2c0: i2c@80058000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dts=
i
index d927155..d470276 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -381,6 +381,7 @@
 				compatible =3D "fsl,imx28-i2c";
 				reg =3D <0x80058000 2000>;
 				interrupts =3D <111 68>;
+				fsl,i2c-dma-channel =3D <6>;
 				fsl,speed =3D <400>;
 				status =3D "disabled";
 			};
@@ -391,6 +392,7 @@
 				compatible =3D "fsl,imx28-i2c";
 				reg =3D <0x8005a000 2000>;
 				interrupts =3D <110 69>;
+				fsl,i2c-dma-channel =3D <7>;
 				fsl,speed =3D <400>;
 				status =3D "disabled";
 			};
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.=
c
index fff0a09..6259ede 100644
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
@@ -31,6 +29,9 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_i2c.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/fsl/mxs-dma.h>
=20
 #define DRIVER_NAME "mxs-i2c"
=20
@@ -135,6 +136,16 @@ struct mxs_i2c_dev {
 	u32 cmd_err;
 	struct i2c_adapter adapter;
 	const struct mxs_i2c_speed_config *speed;
+
+	/* DMA support components */
+	bool				dma_mode;
+	int				dma_channel;
+	struct dma_chan         	*dmach;
+	struct mxs_dma_data		dma_data;
+	uint32_t			pio_data[2];
+	uint32_t			addr_data;
+	struct scatterlist		sg_io[2];
+	bool				dma_read;
 };
=20
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
@@ -146,7 +157,11 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
=20
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
-	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+	if (i2c->dma_mode)
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
+	else
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
 }
=20
@@ -237,6 +252,151 @@ static int mxs_i2c_finish_read(struct mxs_i2c_dev=
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
@@ -247,6 +407,8 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *ada=
p, struct i2c_msg *msg,
 	int ret;
 	int flags;
=20
+	flags =3D stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
+
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
=20
@@ -256,23 +418,29 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *a=
dap, struct i2c_msg *msg,
 	init_completion(&i2c->cmd_complete);
 	i2c->cmd_err =3D 0;
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
 	if (ret =3D=3D 0)
 		goto timeout;
=20
-	if ((!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
+	if (!i2c->dma_mode && !i2c->cmd_err && (msg->flags & I2C_M_RD)) {
 		ret =3D mxs_i2c_finish_read(i2c, msg->buf, msg->len);
 		if (ret)
 			goto timeout;
@@ -290,6 +458,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *ada=
p, struct i2c_msg *msg,
=20
 timeout:
 	dev_dbg(i2c->dev, "Timeout!\n");
+	mxs_i2c_dma_finish(i2c);
 	mxs_i2c_reset(i2c);
 	return -ETIMEDOUT;
 }
@@ -331,11 +500,13 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void=
 *dev_id)
 		/* MXS_I2C_CTRL1_OVERSIZE_XFER_TERM_IRQ is only for slaves */
 		i2c->cmd_err =3D -EIO;
=20
-	is_last_cmd =3D (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
-		MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) =3D=3D 0;
+	if (!i2c->dma_mode) {
+		is_last_cmd =3D (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
+			MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) =3D=3D 0;
=20
-	if (is_last_cmd || i2c->cmd_err)
-		complete(&i2c->cmd_complete);
+		if (is_last_cmd || i2c->cmd_err)
+			complete(&i2c->cmd_complete);
+	}
=20
 	writel(stat, i2c->regs + MXS_I2C_CTRL1_CLR);
=20
@@ -347,6 +518,21 @@ static const struct i2c_algorithm mxs_i2c_algo =3D=
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
+	if (chan->chan_id !=3D i2c->dma_channel)
+		return false;
+
+	chan->private =3D &i2c->dma_data;
+
+	return true;
+}
+
 #ifdef CONFIG_OF
 static int mxs_i2c_get_ofdata(struct platform_device *pdev,
 				struct mxs_i2c_dev *i2c)
@@ -354,10 +540,33 @@ static int mxs_i2c_get_ofdata(struct platform_dev=
ice *pdev,
 	const __be32 *speed;
 	uint32_t speed_khz;
 	struct device_node *node =3D pdev->dev.of_node;
+	int ret;
=20
 	if (!node)
 		return -EINVAL;
=20
+	/*
+	 * The MXS I2C DMA mode is prefered and enabled by default.
+	 * The PIO mode is still supported, but should be used only
+	 * for debuging purposes etc.
+	 */
+	i2c->dma_mode =3D 1;
+	if (of_find_property(node, "fsl,use-pio", NULL)) {
+		i2c->dma_mode =3D 0;
+		dev_info(&pdev->dev, "Using PIO mode for I2C transfers!\n");
+	}
+
+	/*
+	 * TODO: This is a temporary solution and should be changed
+	 * to use generic DMA binding later when the helpers get in.
+	 */
+	ret =3D of_property_read_u32(node, "fsl,i2c-dma-channel",
+				   &i2c->dma_channel);
+	if (ret) {
+		dev_warn(&pdev->dev, "Failed to get DMA channel!\n");
+		i2c->dma_mode =3D 0;
+	}
+
 	i2c->speed =3D &mxs_i2c_95kHz_config;
 	speed =3D of_get_property(node, "fsl,speed", NULL);
 	if (!speed)
@@ -387,7 +596,8 @@ static int __devinit mxs_i2c_probe(struct platform_=
device *pdev)
 	struct pinctrl *pinctrl;
 	struct resource *res;
 	resource_size_t res_size;
-	int err, irq;
+	int err, irq, dmairq;
+	dma_cap_mask_t mask;
=20
 	pinctrl =3D devm_pinctrl_get_select_default(dev);
 	if (IS_ERR(pinctrl))
@@ -398,7 +608,10 @@ static int __devinit mxs_i2c_probe(struct platform=
_device *pdev)
 		return -ENOMEM;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	irq =3D platform_get_irq(pdev, 0);
+	dmairq =3D platform_get_irq(pdev, 1);
+
+	if (!res || irq < 0 || dmairq < 0)
 		return -ENOENT;
=20
 	res_size =3D resource_size(res);
@@ -409,10 +622,6 @@ static int __devinit mxs_i2c_probe(struct platform=
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
@@ -421,6 +630,18 @@ static int __devinit mxs_i2c_probe(struct platform=
_device *pdev)
 	if (err)
 		return err;
=20
+	/* Setup the DMA */
+	if (i2c->dma_mode) {
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
 	i2c->dev =3D dev;
 	platform_set_drvdata(pdev, i2c);
=20
@@ -457,6 +678,9 @@ static int __devexit mxs_i2c_remove(struct platform=
_device *pdev)
 	if (ret)
 		return -EBUSY;
=20
+	if (i2c->dmach)
+		dma_release_channel(i2c->dmach);
+
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
=20
 	platform_set_drvdata(pdev, NULL);
--=20
1.7.10
