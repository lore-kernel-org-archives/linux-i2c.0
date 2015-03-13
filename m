From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: Support for Netlogic XLP9XX/5XX I2C
 controller.
Date: Fri, 13 Mar 2015 11:24:06 +0100
Message-ID: <20150313102406.GP952@pengutronix.de>
References: <1426228198-3314-1-git-send-email-jchandra@broadcom.com>
 <1426228198-3314-3-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426228198-3314-3-git-send-email-jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

hello,

On Fri, Mar 13, 2015 at 11:59:58AM +0530, Jayachandran C wrote:
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c=
-xlp9xx.c
> new file mode 100644
> index 00000000..2f303ad
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -0,0 +1,446 @@
> +/*
> + * Copyright (c) 2003-2015 Broadcom Corporation
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/*
> + * see Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt for devi=
ce
> + * tree bindings documentation
> + */
When I asked for documentation here, I didn't meant the device tree
binding, but the hardware reference manual.

> [...]
> +static void xlp9xx_i2c_mask_irq(struct xlp9xx_i2c_dev *priv, u32 mas=
k)
> +{
> +	mask =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTEN) & ~mask;
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, mask);
You didn't comment on my suggestion to add a variable here for improved
readability:

	u32 inten =3D xlp9xx_read_i2c_reg(...);
	inten &=3D ~mask;
	xlp9xx_write_i2c_reg(...);

> +}
> +
> +static void xlp9xx_i2c_unmask_irq(struct xlp9xx_i2c_dev *priv, u32 m=
ask)
> +{
> +	mask =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTEN) | mask;
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, mask);
> +}
> +
> +static void xlp9xx_i2c_set_rx_fifo_thres(struct xlp9xx_i2c_dev *priv=
,
> +					 u32 th)
> +{
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MFIFOCTRL,
> +			     (th << XLP9XX_I2C_MFIFOCTRL_HITH_SHIFT));
parenthesis are not needed here.

I suggested to move the min calculation that you have to do before each
call to this function into it. You replied:

	The xlp9xx_i2c_... functions were written to do the
	hardware/register operations, so it is better to have this logic
	here.

=2E..

> +}
> +
> +static void xlp9xx_i2c_fill_tx_fifo(struct xlp9xx_i2c_dev *priv)
> +{
> +	u32 len, i;
> +	u8 *buf =3D priv->msg_buf;
> +
> +	len =3D min(priv->msg_buf_remaining, XLP9XX_I2C_FIFO_SIZE);
=2E.. this didn't stop you here though :-) So I'm still convinced that
having the min function in xlp9xx_i2c_set_rx_fifo_thres is a good idea.

> +	for (i =3D 0; i < len; i++)
> +		xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MTXFIFO, buf[i]);
> +	priv->msg_buf_remaining -=3D len;
> +	priv->msg_buf +=3D len;
> +}
> [...]
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
I still wonder if you should round differently here.

> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_RST);
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_EN |
> +			     XLP9XX_I2C_CTRL_MASTER);
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_DIV, prescale);
> +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, 0);
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
