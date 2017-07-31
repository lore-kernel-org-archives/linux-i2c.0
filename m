From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv5 3/3] i2c: altera: Add Altera I2C Controller driver
Date: Mon, 31 Jul 2017 15:31:24 +0200
Message-ID: <20170731133124.smwztpkul2qjy26p@ninjato>
References: <1500309314-18464-1-git-send-email-thor.thayer@linux.intel.com>
 <1500309314-18464-4-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="75tqzgfvrtlyo56b"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1500309314-18464-4-git-send-email-thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--75tqzgfvrtlyo56b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thor,

thanks for the patches! A few comments and questions from me.

On Mon, Jul 17, 2017 at 11:35:14AM -0500, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org wrote:
> From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> Add driver support for the Altera I2C Controller. The I2C
> controller is soft IP for use in FPGAs.
>=20
> Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> v2  Remove altr, from fifo-size to agree with bindings.
>     Change compatible string to "altr,softip-i2c"
> v3  Add version to compatible string "altr,softip-i2c-v1.0"
> v4  Add default 100kHz message. Cleanup IRQ error message.
> v5  Cleanup header usage - remove init.h.
>     Fix 1 byte RX bug and add convenience function for transfer shared by=
 RX and TX.
>     Use readl_poll_timeout_atomic() function.
>     Cache the I2C Interrupt Status Enable Register.
>     Cleanup of irq_mask by combining into 1 function.
>     Use i2c_8bit_addr_from_msg() for cleaner xfer_msg implementation.
>     Restructure altr_i2c_xfer() without arrays and indexes.
>     Remove redundant assignments.
>     Remove function calls from inside if() statements.
>     Convert of_property_read_u32() to device_property_read_u32().
>     Call i2c_m_read() once in irq.
> ---
>  drivers/i2c/busses/Kconfig      |  10 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-altera.c | 510 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 521 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-altera.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 1006b23..668147bf 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -328,6 +328,16 @@ config I2C_POWERMAC
> =20
>  comment "I2C system bus drivers (mostly embedded / system-on-chip)"
> =20
> +config I2C_ALTERA
> +	tristate "Altera Soft IP I2C"
> +	depends on (ARCH_SOCFPGA || NIOS2) && OF
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Altera Soft IP I2C interfaces on SoCFPGA and Nios2 architectures.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-altera.
> +
>  config I2C_ASPEED
>  	tristate "Aspeed I2C Controller"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 1b2fc81..1395dcb 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_I2C_HYDRA)		+=3D i2c-hydra.o
>  obj-$(CONFIG_I2C_POWERMAC)	+=3D i2c-powermac.o
> =20
>  # Embedded system I2C/SMBus host controller drivers
> +obj-$(CONFIG_I2C_ALTERA)	+=3D i2c-altera.o
>  obj-$(CONFIG_I2C_ASPEED)	+=3D i2c-aspeed.o
>  obj-$(CONFIG_I2C_AT91)		+=3D i2c-at91.o
>  obj-$(CONFIG_I2C_AU1550)	+=3D i2c-au1550.o
> diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-alt=
era.c
> new file mode 100644
> index 0000000..e818901
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-altera.c
> @@ -0,0 +1,510 @@
> +/*
> + *  Copyright Intel Corporation (C) 2017.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Based on the i2c-axxia.c driver.
> + */
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +
> +#define ALTR_I2C_TFR_CMD	0x00	/* Transfer Command register */
> +#define     ALTR_I2C_TFR_CMD_STA	BIT(9)	/* send START before byte */
> +#define     ALTR_I2C_TFR_CMD_STO	BIT(8)	/* send STOP after byte */
> +#define     ALTR_I2C_TFR_CMD_RW_D	BIT(0)	/* Direction of transfer */
> +#define ALTR_I2C_RX_DATA	0x04	/* RX data FIFO register */
> +#define ALTR_I2C_CTRL		0x08	/* Control register */
> +#define     ALTR_I2C_CTRL_RXT_SHFT	4	/* RX FIFO Threshold */
> +#define     ALTR_I2C_CTRL_TCT_SHFT	2	/* TFER CMD FIFO Threshold */
> +#define     ALTR_I2C_CTRL_BSPEED	BIT(1)	/* Bus Speed (1=3DFast) */
> +#define     ALTR_I2C_CTRL_EN	BIT(0)	/* Enable Core (1=3DEnable) */
> +#define ALTR_I2C_ISER		0x0C	/* Interrupt Status Enable register */
> +#define     ALTR_I2C_ISER_RXOF_EN	BIT(4)	/* Enable RX OVERFLOW IRQ */
> +#define     ALTR_I2C_ISER_ARB_EN	BIT(3)	/* Enable ARB LOST IRQ */
> +#define     ALTR_I2C_ISER_NACK_EN	BIT(2)	/* Enable NACK DET IRQ */
> +#define     ALTR_I2C_ISER_RXRDY_EN	BIT(1)	/* Enable RX Ready IRQ */
> +#define     ALTR_I2C_ISER_TXRDY_EN	BIT(0)	/* Enable TX Ready IRQ */
> +#define ALTR_I2C_ISR		0x10	/* Interrupt Status register */
> +#define     ALTR_I2C_ISR_RXOF		BIT(4)	/* RX OVERFLOW IRQ */
> +#define     ALTR_I2C_ISR_ARB		BIT(3)	/* ARB LOST IRQ */
> +#define     ALTR_I2C_ISR_NACK		BIT(2)	/* NACK DET IRQ */
> +#define     ALTR_I2C_ISR_RXRDY		BIT(1)	/* RX Ready IRQ */
> +#define     ALTR_I2C_ISR_TXRDY		BIT(0)	/* TX Ready IRQ */
> +#define ALTR_I2C_STATUS		0x14	/* Status register */
> +#define     ALTR_I2C_STAT_CORE		BIT(0)	/* Core Status (0=3Didle) */
> +#define ALTR_I2C_TC_FIFO_LVL	0x18	/* Transfer FIFO LVL register */
> +#define ALTR_I2C_RX_FIFO_LVL	0x1C	/* Receive FIFO LVL register */
> +#define ALTR_I2C_SCL_LOW	0x20	/* SCL low count register */
> +#define ALTR_I2C_SCL_HIGH	0x24	/* SCL high count register */
> +#define ALTR_I2C_SDA_HOLD	0x28	/* SDA hold count register */
> +
> +#define ALTR_I2C_ALL_IRQ	(ALTR_I2C_ISR_RXOF | ALTR_I2C_ISR_ARB | \
> +				 ALTR_I2C_ISR_NACK | ALTR_I2C_ISR_RXRDY | \
> +				 ALTR_I2C_ISR_TXRDY)
> +
> +#define ALTR_I2C_THRESHOLD	0	/* IRQ Threshold at 1 element */
> +#define ALTR_I2C_DFLT_FIFO_SZ	4
> +#define ALTR_I2C_TIMEOUT	100000	/* 100ms */
> +#define ALTR_I2C_XFER_TIMEOUT	(msecs_to_jiffies(250))
> +
> +/**
> + * altr_i2c_dev - I2C device context
> + * @base: pointer to register struct
> + * @msg: pointer to current message
> + * @msg_len: number of bytes transferred in msg
> + * @msg_err: error code for completed message
> + * @msg_complete: xfer completion object
> + * @dev: device reference
> + * @adapter: core i2c abstraction
> + * @i2c_clk: clock reference for i2c input clock
> + * @bus_clk_rate: current i2c bus clock rate
> + * @buf: ptr to msg buffer for easier use.
> + * @fifo_size: size of the FIFO passed in.
> + */
> +struct altr_i2c_dev {
> +	void __iomem *base;
> +	struct i2c_msg *msg;
> +	size_t msg_len;
> +	int msg_err;
> +	struct completion msg_complete;
> +	struct device *dev;
> +	struct i2c_adapter adapter;
> +	struct clk *i2c_clk;
> +	u32 bus_clk_rate;
> +	u8 *buf;
> +	u32 fifo_size;
> +	u32 isr_mask;

The last one is not described in the kernel docs.

> +};
> +
> +static void i2c_int_enable(struct altr_i2c_dev *idev, u32 mask, bool ena=
ble)
> +{
> +	u32 int_en =3D readl(idev->base + ALTR_I2C_ISER);
> +
> +	if (enable)
> +		idev->isr_mask =3D int_en | mask;
> +	else
> +		idev->isr_mask =3D int_en & ~mask;
> +
> +	writel(idev->isr_mask, idev->base + ALTR_I2C_ISER);
> +}
> +
> +static void i2c_int_clear(struct altr_i2c_dev *idev, u32 mask)
> +{
> +	u32 int_en =3D readl(idev->base + ALTR_I2C_ISR);
> +
> +	writel(int_en | mask, idev->base + ALTR_I2C_ISR);
> +}

Those two functions would also suit an altr_ prefix.

> +
> +static void altr_i2c_core_disable(struct altr_i2c_dev *idev)
> +{
> +	u32 tmp =3D readl(idev->base + ALTR_I2C_CTRL);
> +
> +	writel(tmp & ~ALTR_I2C_CTRL_EN, idev->base + ALTR_I2C_CTRL);
> +}
> +
> +static void altr_i2c_core_enable(struct altr_i2c_dev *idev)
> +{
> +	u32 tmp =3D readl(idev->base + ALTR_I2C_CTRL);
> +
> +	writel(tmp | ALTR_I2C_CTRL_EN, idev->base + ALTR_I2C_CTRL);
> +}
> +
> +static void altr_i2c_reset(struct altr_i2c_dev *idev)
> +{
> +	altr_i2c_core_disable(idev);
> +	altr_i2c_core_enable(idev);
> +}
> +
> +static void altr_i2c_recover(struct altr_i2c_dev *idev)
> +{
> +	altr_i2c_reset(idev);
> +	/* Clock start bit + 8 bits + stop bit out */

Really 8? It should be 9 (ACK bit).

> +	writel(ALTR_I2C_TFR_CMD_STA | ALTR_I2C_TFR_CMD_STO,
> +	       idev->base + ALTR_I2C_TFR_CMD);
> +	altr_i2c_reset(idev);

Why the second reset?

> +
> +	i2c_recover_bus(&idev->adapter);

This will return an error since you don't have a struct
i2c_bus_recovery_info defined. This whole recovery looks fishy, maybe it
should be dropped now and added incrementally?

> +}
> +
> +static inline void altr_i2c_stop(struct altr_i2c_dev *idev)
> +{
> +	writel(ALTR_I2C_TFR_CMD_STO, idev->base + ALTR_I2C_TFR_CMD);
> +}
> +
> +static void altr_i2c_init(struct altr_i2c_dev *idev)
> +{
> +	u32 divisor =3D clk_get_rate(idev->i2c_clk) / idev->bus_clk_rate;
> +	u32 clk_mhz =3D clk_get_rate(idev->i2c_clk) / 1000000;
> +	u32 tmp =3D (ALTR_I2C_THRESHOLD << ALTR_I2C_CTRL_RXT_SHFT) |
> +		  (ALTR_I2C_THRESHOLD << ALTR_I2C_CTRL_TCT_SHFT);
> +	u32 t_high, t_low;
> +
> +	if (idev->bus_clk_rate <=3D 100000) {
> +		tmp &=3D ~ALTR_I2C_CTRL_BSPEED;
> +		/* Standard mode SCL 50/50 */
> +		t_high =3D divisor * 1 / 2;
> +		t_low =3D divisor * 1 / 2;
> +	} else {
> +		tmp |=3D ALTR_I2C_CTRL_BSPEED;
> +		/* Fast mode SCL 33/66 */
> +		t_high =3D divisor * 1 / 3;
> +		t_low =3D divisor * 2 / 3;
> +	}
> +	writel(tmp, idev->base + ALTR_I2C_CTRL);
> +
> +	dev_dbg(idev->dev, "rate=3D%uHz per_clk=3D%uMHz -> ratio=3D1:%u\n",
> +		idev->bus_clk_rate, clk_mhz, divisor);
> +
> +	/* Reset controller */
> +	altr_i2c_reset(idev);
> +
> +	/* SCL High Time */
> +	writel(t_high, idev->base + ALTR_I2C_SCL_HIGH);
> +	/* SCL Low Time */
> +	writel(t_low, idev->base + ALTR_I2C_SCL_LOW);
> +	/* SDA Hold Time, 300ns */
> +	writel(div_u64(300 * clk_mhz, 1000), idev->base + ALTR_I2C_SDA_HOLD);
> +
> +	/* Mask all master interrupt bits */
> +	i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
> +}
> +
> +static int i2c_m_rd(const struct i2c_msg *msg)
> +{
> +	return (msg->flags & I2C_M_RD) !=3D 0;
> +}

I'll leave it to you, but I'd think an extra function doesn't really
improve readability here.

> +
> +/**
> + * altr_i2c_transfer - On the last byte to be transmitted, send
> + * a Stop bit on the last byte.
> + */
> +static void altr_i2c_transfer(struct altr_i2c_dev *idev, u32 data)
> +{
> +	/* On the last byte to be transmitted, send STOP */
> +	if (idev->msg_len =3D=3D 1)
> +		data |=3D ALTR_I2C_TFR_CMD_STO;
> +	if (idev->msg_len > 0)
> +		writel(data, idev->base + ALTR_I2C_TFR_CMD);
> +}
> +
> +/**
> + * altr_i2c_empty_rx_fifo - Fetch data from RX FIFO until end of
> + * transfer. Send a Stop bit on the last byte.
> + */
> +static void altr_i2c_empty_rx_fifo(struct altr_i2c_dev *idev)
> +{
> +	size_t rx_fifo_avail =3D readl(idev->base + ALTR_I2C_RX_FIFO_LVL);
> +	int bytes_to_transfer =3D min(rx_fifo_avail, idev->msg_len);
> +
> +	while (bytes_to_transfer-- > 0) {
> +		*idev->buf++ =3D readl(idev->base + ALTR_I2C_RX_DATA);
> +		idev->msg_len--;
> +		altr_i2c_transfer(idev, 0);
> +	}
> +}
> +
> +/**
> + * altr_i2c_fill_tx_fifo - Fill TX FIFO from current message buffer.
> + * @return: Number of bytes left to transfer.
> + */
> +static int altr_i2c_fill_tx_fifo(struct altr_i2c_dev *idev)
> +{
> +	size_t tx_fifo_avail =3D idev->fifo_size - readl(idev->base +
> +						       ALTR_I2C_TC_FIFO_LVL);
> +	int bytes_to_transfer =3D min(tx_fifo_avail, idev->msg_len);
> +	int ret =3D idev->msg_len - bytes_to_transfer;
> +
> +	while (bytes_to_transfer-- > 0) {
> +		altr_i2c_transfer(idev, *idev->buf++);
> +		idev->msg_len--;
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t altr_i2c_isr(int irq, void *_dev)
> +{
> +	int ret, read;
> +	struct altr_i2c_dev *idev =3D _dev;
> +	/* Read IRQ status but only interested in Enabled IRQs. */
> +	u32 status =3D readl(idev->base + ALTR_I2C_ISR) & idev->isr_mask;
> +
> +	if (!idev->msg) {
> +		dev_warn(idev->dev, "unexpected interrupt\n");
> +		goto out;

Won't you get an interrupt storm if you don't use any i2c_int_clear()?

> +	}
> +	read =3D i2c_m_rd(idev->msg);
> +
> +	/* handle Lost Arbitration */
> +	if (unlikely(status & ALTR_I2C_ISR_ARB)) {
> +		dev_err(idev->dev, "%s: arbitration lost\n", __func__);

Drop the message, it is not an error, but a to be expected bus condition
in multi-master setups.

> +		i2c_int_clear(idev, ALTR_I2C_ISR_ARB);
> +		idev->msg_err =3D -EAGAIN;
> +		goto complete;
> +	}
> +
> +	if (unlikely(status & ALTR_I2C_ISR_NACK)) {
> +		dev_dbg(idev->dev, "%s: could not get ACK\n", __func__);
> +		idev->msg_err =3D -ENXIO;
> +		i2c_int_clear(idev, ALTR_I2C_ISR_NACK);
> +		altr_i2c_stop(idev);
> +		goto complete;
> +	}
> +
> +	/* handle RX FIFO Overflow */
> +	if (read && unlikely(status & ALTR_I2C_ISR_RXOF)) {
> +		altr_i2c_empty_rx_fifo(idev);
> +		i2c_int_clear(idev, ALTR_I2C_ISR_RXRDY);
> +		altr_i2c_stop(idev);
> +		dev_err(idev->dev, "%s: RX FIFO Overflow\n", __func__);
> +		goto complete;
> +	}
> +
> +	/* RX FIFO needs service? */
> +	if (read && (status & ALTR_I2C_ISR_RXRDY)) {
> +		altr_i2c_empty_rx_fifo(idev);
> +		i2c_int_clear(idev, ALTR_I2C_ISR_RXRDY);
> +		if (!idev->msg_len)
> +			goto complete;
> +
> +		goto out;
> +	}
> +
> +	/* TX FIFO needs service? */
> +	if (!read && (status & ALTR_I2C_ISR_TXRDY)) {
> +		i2c_int_clear(idev, ALTR_I2C_ISR_TXRDY);
> +		if (!altr_i2c_fill_tx_fifo(idev))
> +			goto complete;
> +
> +		goto out;

A bit too much goto in here for my taste. What about using a boolean
'complete' variable which gets set or cleared and have an 'if
(complete)' at the end of this routine?

> +	}
> +
> +complete:
> +	/* Wait for the Core to finish */
> +	ret =3D readl_poll_timeout_atomic(idev->base + ALTR_I2C_STATUS, status,
> +					((status & ALTR_I2C_STAT_CORE) =3D=3D 0),
> +					1, ALTR_I2C_TIMEOUT);

Why do you need this polling in an interrupt?


> +	if (ret)
> +		dev_err(idev->dev, "%s: message timeout\n", __func__);
> +	i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
> +	i2c_int_clear(idev, ALTR_I2C_ALL_IRQ);
> +	complete(&idev->msg_complete);
> +	dev_dbg(idev->dev, "%s: Message Complete\n", __func__);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static int altr_i2c_xfer_msg(struct altr_i2c_dev *idev, struct i2c_msg *=
msg)
> +{
> +	u32 imask =3D ALTR_I2C_ISR_RXOF | ALTR_I2C_ISR_ARB | ALTR_I2C_ISR_NACK;
> +	unsigned long time_left;
> +	u32 value;
> +	u8 addr =3D i2c_8bit_addr_from_msg(msg);
> +
> +	idev->msg =3D msg;
> +	idev->msg_len =3D msg->len;
> +	idev->buf =3D msg->buf;
> +	idev->msg_err =3D 0;
> +	reinit_completion(&idev->msg_complete);
> +	altr_i2c_core_enable(idev);
> +
> +	/* Make sure RX FIFO is empty */
> +	do {
> +		readl(idev->base + ALTR_I2C_RX_DATA);
> +	} while (readl(idev->base + ALTR_I2C_RX_FIFO_LVL));
> +
> +	writel(ALTR_I2C_TFR_CMD_STA | addr, idev->base + ALTR_I2C_TFR_CMD);
> +
> +	if (i2c_m_rd(msg)) {
> +		imask |=3D ALTR_I2C_ISER_RXOF_EN | ALTR_I2C_ISER_RXRDY_EN;
> +		i2c_int_enable(idev, imask, true);
> +		/* write the first byte to start the RX */
> +		altr_i2c_transfer(idev, 0);
> +	} else {
> +		imask |=3D ALTR_I2C_ISR_TXRDY;
> +		i2c_int_enable(idev, imask, true);
> +		altr_i2c_fill_tx_fifo(idev);
> +	}
> +
> +	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
> +						ALTR_I2C_XFER_TIMEOUT);
> +	i2c_int_enable(idev, imask, false);
> +
> +	value =3D readl(idev->base + ALTR_I2C_STATUS) & ALTR_I2C_STAT_CORE;
> +	if (value)
> +		dev_err(idev->dev, "%s: Core Status not IDLE...\n", __func__);

__func__ with dev_* is 99,9% superfluous.

> +
> +	if (time_left =3D=3D 0) {
> +		idev->msg_err =3D -ETIMEDOUT;
> +		dev_err(idev->dev, "%s: Transaction timed out.\n", __func__);

No error message here. This can happen when an EEPROM is currently
erasing.

> +		altr_i2c_recover(idev);

And no need to reset the bus! Only if SDA is stuck low.

> +	}
> +
> +	if (unlikely(idev->msg_err) && idev->msg_err !=3D -ENXIO)
> +		altr_i2c_init(idev);

Why do you need to reinit on NACK?

> +
> +	altr_i2c_core_disable(idev);
> +
> +	return idev->msg_err;
> +}
> +
> +static int
> +altr_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct altr_i2c_dev *idev =3D i2c_get_adapdata(adap);
> +	int i, ret;
> +
> +	for (i =3D 0; i < num; i++) {
> +		ret =3D altr_i2c_xfer_msg(idev, msgs++);
> +		if (ret)
> +			return ret;
> +	}
> +	return num;
> +}
> +
> +static u32 altr_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C;
> +}

No emulated SMBUS?

> +
> +static const struct i2c_algorithm altr_i2c_algo =3D {
> +	.master_xfer =3D altr_i2c_xfer,
> +	.functionality =3D altr_i2c_func,
> +};
> +
> +static int altr_i2c_probe(struct platform_device *pdev)
> +{
> +	struct altr_i2c_dev *idev =3D NULL;
> +	struct resource *res;
> +	int irq, ret;
> +	u32 val;
> +
> +	idev =3D devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	idev->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(idev->base))
> +		return PTR_ERR(idev->base);
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "missing interrupt resource\n");
> +		return irq;
> +	}
> +
> +	idev->i2c_clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(idev->i2c_clk)) {
> +		dev_err(&pdev->dev, "missing clock\n");
> +		return PTR_ERR(idev->i2c_clk);
> +	}
> +
> +	idev->dev =3D &pdev->dev;
> +	init_completion(&idev->msg_complete);
> +
> +	val =3D device_property_read_u32(idev->dev, "fifo-size",
> +				       &idev->fifo_size);
> +	if (val) {
> +		dev_err(&pdev->dev, "FIFO size set to default of %d\n",
> +			ALTR_I2C_DFLT_FIFO_SZ);
> +		idev->fifo_size =3D ALTR_I2C_DFLT_FIFO_SZ;
> +	}
> +
> +	val =3D device_property_read_u32(idev->dev, "clock-frequency",
> +				       &idev->bus_clk_rate);
> +	if (val) {
> +		dev_err(&pdev->dev, "Default to 100kHz\n");
> +		idev->bus_clk_rate =3D 100000;	/* default clock rate */
> +	}
> +
> +	if (idev->bus_clk_rate > 400000) {
> +		dev_err(&pdev->dev, "invalid clock-frequency %d\n",
> +			idev->bus_clk_rate);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D devm_request_irq(&pdev->dev, irq, altr_i2c_isr, 0,
> +			       pdev->name, idev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to claim IRQ %d\n", irq);
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(idev->i2c_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	altr_i2c_init(idev);
> +
> +	i2c_set_adapdata(&idev->adapter, idev);
> +	strlcpy(idev->adapter.name, pdev->name, sizeof(idev->adapter.name));
> +	idev->adapter.owner =3D THIS_MODULE;
> +	idev->adapter.algo =3D &altr_i2c_algo;
> +	idev->adapter.dev.parent =3D &pdev->dev;
> +	idev->adapter.dev.of_node =3D pdev->dev.of_node;
> +
> +	platform_set_drvdata(pdev, idev);
> +
> +	ret =3D i2c_add_adapter(&idev->adapter);
> +	if (ret) {
> +		clk_disable_unprepare(idev->i2c_clk);
> +		return ret;
> +	}
> +	dev_info(&pdev->dev, "Altera SoftIP I2C Probe Complete\n");
> +
> +	return 0;
> +}
> +
> +static int altr_i2c_remove(struct platform_device *pdev)
> +{
> +	struct altr_i2c_dev *idev =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(idev->i2c_clk);
> +	i2c_del_adapter(&idev->adapter);
> +
> +	return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id altr_i2c_of_match[] =3D {
> +	{ .compatible =3D "altr,softip-i2c-v1.0" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, altr_i2c_of_match);
> +
> +static struct platform_driver altr_i2c_driver =3D {
> +	.probe =3D altr_i2c_probe,
> +	.remove =3D altr_i2c_remove,
> +	.driver =3D {
> +		.name =3D "altera-i2c",
> +		.of_match_table =3D altr_i2c_of_match,
> +	},
> +};
> +
> +module_platform_driver(altr_i2c_driver);
> +
> +MODULE_DESCRIPTION("Altera Soft IP I2C bus driver");
> +MODULE_AUTHOR("Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.7.4
>=20

--75tqzgfvrtlyo56b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/MSkACgkQFA3kzBSg
KbZlWw/9EPGwWNgm0bZkW6bXdK2dXUxbpzfNzB4+t4TO5MKnjYALDsm/AEDGTBHR
p1VNaSvJeV9fvHD6TL9D0QHSXtCnaaN9nAfIdxg/KlIhIVBhqI9I5hxG9ZBEw1tt
07TJFe12Fb0rKb1kzvJ3LTizmeI2X/g1oUCtHW//6nG1V4ypp9/DjfxIvKQbTo08
/iJoqs0ujcCrTHhwJfCVnjKzNz92Uly3N4HByMzMp/kX12B0qcOyjZxN/yfe/G4C
Mf25e6kDn5Y6xjrbOL1Pwbt2WAptvtKD9Ibm87Pa6t1nWPUy2LKbZ9DdQlTqvCzL
Y+vQY/am395fMkv0INf4OrvcP0uUj+mEW/VG2j4XODZbmouVehhFJx+lBv5aV2F3
+Rc4K5+nlzMwsDBeDdPJs0sQIgp0+nZGubonGQwhdEVUIqVQQQzQInN1rJy2sa5B
RXqAnXPkmU7pNq2USVIoKsx60T8a/LmT5/0DtQleaJTy4h1gLMaEB6gVbtvn9XwH
PX604Yp+mU4oIDxzzzqZWJer0HPNczU05UeoNDCXmeK8AsGe/msnOg8OgthTagyC
4VABtZGI0gGVJ8CsQ476jPp77NuRxGr2aTw1dPflgiuH2hbumyBwLSkpMoW5mLEa
kd3ZFRRiHu7T17/NGggGlz3JhvIjway1w13o9vlkE4Az1woS3ek=
=+pNY
-----END PGP SIGNATURE-----

--75tqzgfvrtlyo56b--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
