From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: Support for Netlogic XLP9XX/5XX I2C
 controller.
Date: Fri, 6 Mar 2015 09:48:48 +0100
Message-ID: <20150306084848.GB10717@pengutronix.de>
References: <1425452133-7489-1-git-send-email-jchandra@broadcom.com>
 <1425452133-7489-3-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425452133-7489-3-git-send-email-jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Subhendu Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Mar 04, 2015 at 12:25:33PM +0530, Jayachandran C wrote:
> From: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>=20
> Add an I2C bus driver i2c-xlp9xx.c to support the I2C block in the
> XLP9xx/XLP5xx MIPS SoC. Update Kconfig and Makefile to add the
> CONFIG_I2C_XLP9XX option.
>=20
> Also add document Documentation/devicetree/bindings/i2c/i2c-xlp9xx.tx=
t
> for DT compatible string "netlogic,xlp9xx-i2c".
>=20
> Signed-off-by: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-xlp9xx.txt         |  22 +
>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-xlp9xx.c                    | 446 +++++++++++=
++++++++++
>  4 files changed, 479 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xlp9xx.=
txt
>  create mode 100644 drivers/i2c/busses/i2c-xlp9xx.c
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt b/D=
ocumentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
> new file mode 100644
> index 00000000..f23ae87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
> @@ -0,0 +1,22 @@
> +Device tree configuration for the I2C controller on the XLP9xx/5xx S=
oC
> +
> +Required properties:
> +- compatible      : should be "netlogic,xlp9xx-i2c"
> +- reg             : bus address start and address range size of devi=
ce
> +- interrupts      : interrupt number
> +
> +Optional properties:
> +- clock-frequency : frequency of bus clock in Hz
> +                    Defaults to 100 KHz when the property is not spe=
cified
> +
> +Example:
> +
> +i2c0: i2c@113100 {
> +	compatible =3D "netlogic,xlp9xx-i2c";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	reg =3D <0 0x113100 0x100>;
> +	clock-frequency =3D <400000>;
> +	interrupts =3D <30>;
> +	interrupt-parent =3D <&pic>;
> +};
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 22da9c2..dde4648 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -898,6 +898,16 @@ config I2C_XLR
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-xlr.
> =20
> +config I2C_XLP9XX
> +	tristate "XLP9XX I2C support"
> +	depends on CPU_XLP || COMPILE_TEST
> +	help
> +	  This driver enables support for the on-chip I2C interface of
> +	  the Broadcom XLP9xx/XLP5xx MIPS processors.
> +
> +	  This driver can also be built as a module.  If so, the module wil=
l
> +	  be called i2c-xlp9xx.
> +
>  config I2C_RCAR
>  	tristate "Renesas R-Car I2C Controller"
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index 3638feb..f8e0f0e 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_I2C_WMT)		+=3D i2c-wmt.o
>  obj-$(CONFIG_I2C_OCTEON)	+=3D i2c-octeon.o
>  obj-$(CONFIG_I2C_XILINX)	+=3D i2c-xiic.o
>  obj-$(CONFIG_I2C_XLR)		+=3D i2c-xlr.o
> +obj-$(CONFIG_I2C_XLP9XX)	+=3D i2c-xlp9xx.o
>  obj-$(CONFIG_I2C_RCAR)		+=3D i2c-rcar.o
> =20
>  # External I2C/SMBus adapter drivers
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c=
-xlp9xx.c
> new file mode 100644
> index 00000000..6886add
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -0,0 +1,446 @@
> +/*
> + * Copyright (c) 2003-2015 Broadcom Corporation
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
It would be nice to point here a link to the device's documentation.

> +
> +#include <linux/completion.h>
> +#include <linux/errno.h>
> +#include <linux/hardirq.h>
Do you need hardirq.h?

> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> [...]
> +static void xlp9xx_i2c_mask_irq(struct xlp9xx_i2c_dev *priv, u32 mas=
k)
> +{
> +	mask  =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTEN) & ~mask;
s/  / /

=46or code clarity I'd spend another variable name and make this read:

	u32 inten =3D xlp9xx_read_i2c_reg(...);

	inten &=3D ~mask;

	xlp9xx_write_i2c_reg(..., inten);

(If you prefer, combine the two last commands.)

> +static void xlp9xx_i2c_set_rx_fifo_thres(struct xlp9xx_i2c_dev *priv=
,
> +					 u32 th)
> +{
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MFIFOCTRL,
> +		(th << XLP9XX_I2C_MFIFOCTRL_HITH_SHIFT));
Usually a single tab is not considered to be "placed substantially to
the right" (see Documentation/CodingStyle) for continuation lines. Usua=
l
are either two tabs or alignment to the opening (. Whichever you choose
use it consitently in the whole file.

> +static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
> +{
> +	u32 len, i;
> +	u8 *buf =3D priv->msg_buf;
> +
> +	len =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_FIFOWCNT) &
> +		XLP9XX_I2C_FIFO_WCNT_MASK;
> +	len =3D min(priv->msg_buf_remaining, len);
If priv->msg_buf_remaining < len, does this mean that you read more
bytes than requested? That would be unfortunate.

> +	for (i =3D 0; i < len; i++, buf++)
> +		*buf =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
> +
> +	priv->msg_buf_remaining -=3D len;
> +	priv->msg_buf =3D buf;
> +
> +	if (priv->msg_buf_remaining)
> +		xlp9xx_i2c_set_rx_fifo_thres(priv,
> +			min(priv->msg_buf_remaining, XLP9XX_I2C_FIFO_SIZE));
If you move the min calculation into xlp9xx_i2c_set_rx_fifo_thres you
can drop it for the callers.

> +}
> +
> +static irqreturn_t xlp9xx_i2c_isr(int irq, void *dev_id)
> +{
> +	struct xlp9xx_i2c_dev *priv =3D dev_id;
> +	u32 status;
> +
> +	status =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTST);
> +	if (status =3D=3D 0)
> +		return IRQ_NONE;
> +
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTST, status);
This is the ack?  Do you really want to ack everything or better only
the bits you handle?

> +	if (status & XLP9XX_I2C_STATUS_ERRMASK) {
> +		priv->msg_err =3D status;
> +		goto xfer_done;
> +	}
> +
> +	/* SADDR ACK for SMBUS_QUICK */
> +	if ((status & XLP9XX_I2C_INTEN_SADDR) && (priv->msg_len =3D=3D 0))
> +		goto xfer_done;
> +
> +	if (!priv->msg_read) {
> +		/* TX FIFO got empty, fill it up again */
You know that without checking if status has the respective bit set?

> +		if (status & XLP9XX_I2C_INTEN_MFIFOEMTY) {
> +			if (priv->msg_buf_remaining)
> +				xlp9xx_i2c_fill_tx_fifo(priv);
> +			else
> +				xlp9xx_i2c_mask_irq(priv,
> +					XLP9XX_I2C_INTEN_MFIFOEMTY);
> +		}
> +	} else {
> +		/* data is in FIFO, read it */
> +		if (status & (XLP9XX_I2C_INTEN_MDATARDY |
> +				XLP9XX_I2C_INTEN_DATADONE |
> +				XLP9XX_I2C_INTEN_MFIFOHI)) {
> +			if (status & XLP9XX_I2C_INTEN_MDATARDY)
> +				xlp9xx_i2c_mask_irq(priv,
> +					XLP9XX_I2C_INTEN_MDATARDY);
I don't understant this. What does MDATARDY signal?

> +			if (priv->msg_buf_remaining)
> +				xlp9xx_i2c_drain_rx_fifo(priv);
> +		}
> +	}
> +
> +	/* Transfer complete */
> +	if (status & XLP9XX_I2C_INTEN_DATADONE)
> +		goto xfer_done;
> +
> +	return IRQ_HANDLED;
> +
> +xfer_done:
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, 0);
> +	complete(&priv->msg_complete);
> +	return IRQ_HANDLED;
> +}
> +
> +static int xlp9xx_i2c_init(struct xlp9xx_i2c_dev *priv)
> +{
> +	u32 prescale;
> +
> +	/*
> +	 * The controller uses 5 * SCL clock internally.
> +	 * So prescale value should be divided by 5.
> +	 */
> +	prescale =3D (((XLP9XX_I2C_IP_CLK_FREQ / priv->clk_hz) - 8) / 5) - =
1;
XLP9XX_I2C_IP_CLK_FREQ is the clk input right? It would be nice to get
this via the clk API. Do you need to enable the parent clk?

Is it right to use / here? Maybe DIV_ROUND_UP should be used?

Can you provide the documentation to the prescale value?

> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_RST);
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_EN |
> +		XLP9XX_I2C_CTRL_MASTER);
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_DIV, prescale);
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, 0);
Assuming XLP9XX_I2C_CTRL_RST resets the hardware, is INTEN !=3D 0 after
that? If not, you can drop this call.

> +	/* Build control word for transfer */
> +	val =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_CTRL);
> +	if (!priv->msg_read)
> +		val &=3D ~XLP9XX_I2C_CTRL_FIFORD;
> +	else
> +		val |=3D XLP9XX_I2C_CTRL_FIFORD;	/* read */
You could spend more empty lines to group commands. Here for example.

> +	if (msg->flags & I2C_M_TEN)
> +		val |=3D XLP9XX_I2C_CTRL_ADDMODE;	/* 10-bit address mode*/
> +
> +	/* set data length to be transferred */
> +	val =3D (val & XLP9XX_I2C_FIFO_CTRL_MASK) |
It looks strange to me to do the masking here. Above you read the
address from the hardware. Which bits do you want to retain? Is it only
the timing stuff? Then maybe put the base value into your driver privat=
e
struct and construct val without reading from hardware?

> +		(msg->len << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, val);
> +
> +	/* fill fifo during tx */
> +	if (!priv->msg_read)
> +		xlp9xx_i2c_fill_tx_fifo(priv);
> +
> +	/* set interrupt mask */
> +	intr_mask =3D (XLP9XX_I2C_INTEN_ARLOST | XLP9XX_I2C_INTEN_BUSERR |
> +		XLP9XX_I2C_INTEN_NACKADDR | XLP9XX_I2C_INTEN_DATADONE);
> +
> +	if (priv->msg_read) {
> +		intr_mask |=3D (XLP9XX_I2C_INTEN_MDATARDY |
> +			XLP9XX_I2C_INTEN_MFIFOHI);
> +		if (msg->len =3D=3D 0)
> +			intr_mask |=3D XLP9XX_I2C_INTEN_SADDR;
> +	} else {
> +		if (msg->len =3D=3D 0)
> +			intr_mask |=3D XLP9XX_I2C_INTEN_SADDR;
> +		else
> +			intr_mask |=3D XLP9XX_I2C_INTEN_MFIFOEMTY;
> +	}
> +	xlp9xx_i2c_unmask_irq(priv, intr_mask);
> +
> +	/* set cmd reg */
> +	cmd =3D XLP9XX_I2C_CMD_START | XLP9XX_I2C_CMD_STOP;
Does this result in sending a stop at the end of the message? This
should only be done for the last msg in the array passed to the xfer
callback. And what happens if your message is longer than the fifo size=
?

> +	cmd |=3D (priv->msg_read ? XLP9XX_I2C_CMD_READ : XLP9XX_I2C_CMD_WRI=
TE);
> +
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CMD, cmd);
> [...]
> +static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
> +				    struct xlp9xx_i2c_dev *priv)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	u32 freq;
> +	int err;
> +
> +	err =3D of_property_read_u32(np, "clock-frequency", &freq);
> +	if (err) {
> +		dev_dbg(&pdev->dev, "using default frequency %u\n", freq);
freq is used uninitialized here, isn't it?

> +		freq =3D XLP9XX_I2C_DEFAULT_FREQ;
> +	} else if (freq =3D=3D 0 || freq > XLP9XX_I2C_HIGH_FREQ) {
> +		dev_warn(&pdev->dev, "invalid frequency %u, using default\n",
> +			freq);
> +		freq =3D XLP9XX_I2C_DEFAULT_FREQ;
> +	}
> +	priv->clk_hz =3D freq;
> +
> +	return 0;
> +}
> +
> +static int xlp9xx_i2c_probe(struct platform_device *pdev)
> +{
> +	struct xlp9xx_i2c_dev *priv;
> +	struct resource *res;
> +	int err =3D 0;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->irq =3D platform_get_irq(pdev, 0);
> +	if (priv->irq <=3D 0) {
> +		dev_err(&pdev->dev, "invalid irq!\n");
> +		return  priv->irq;
s/  / /

> +	}
> +
> +	xlp9xx_i2c_get_frequency(pdev, priv);
> +	xlp9xx_i2c_init(priv);
> +
> +	err =3D devm_request_irq(&pdev->dev, priv->irq, xlp9xx_i2c_isr, 0,
> +		pdev->name, priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "IRQ request failed!\n");
> +		return err;
> +	}
> +
> +	init_completion(&priv->msg_complete);
> +	priv->adapter.dev.parent =3D &pdev->dev;
> +	priv->adapter.algo =3D &xlp9xx_i2c_algo;
> +	priv->adapter.dev.of_node =3D pdev->dev.of_node;
> +	priv->dev =3D &pdev->dev;
> +
> +	snprintf(priv->adapter.name, sizeof(priv->adapter.name), "xlp9xx-i2=
c");
> +	i2c_set_adapdata(&priv->adapter, priv);
> +
> +	err =3D i2c_add_adapter(&priv->adapter);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to add I2C:%d adapter!\n",
> +			pdev->id);
pdev->id doesn't necessarily match the adapter number, doesn't it?

> +		return err;
> +	}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
