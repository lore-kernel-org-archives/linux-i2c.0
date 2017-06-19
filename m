From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
Date: Mon, 19 Jun 2017 21:31:30 +0200
Message-ID: <20170619193130.velebm7p3r5ggaos@ninjato>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5focjtu4cgg6vom"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54478 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752748AbdFSTbc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 15:31:32 -0400
Content-Disposition: inline
In-Reply-To: <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Baoyou Xie <baoyou.xie@linaro.org>


--o5focjtu4cgg6vom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Sun, May 28, 2017 at 12:59:36PM +0800, Shawn Guo wrote:
> From: Baoyou Xie <baoyou.xie@linaro.org>
>=20
> This patch adds i2c controller driver for ZTE's zx2967 family.
>=20
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

What about this patch from the old series updating the MAINTAINERS entry?
I think it is a good idea?

http://patchwork.ozlabs.org/patch/731006/

> ---
>  drivers/i2c/busses/Kconfig      |   9 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-zx2967.c | 610 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 620 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-zx2967.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 144cbadc7c72..f9f0ed61df2e 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1258,4 +1258,13 @@ config I2C_OPAL
>  	  This driver can also be built as a module. If so, the module will be
>  	  called as i2c-opal.
> =20
> +config I2C_ZX2967
> +	tristate "ZTE ZX2967 I2C support"
> +	depends on ARCH_ZX

|| COMPILE_TEST?

> +	default y
> +	help
> +	  Selecting this option will add ZX2967 I2C driver.
> +	  This driver can also be built as a module. If so, the module will be
> +	  called i2c-zx2967.
> +
>  endmenu

=2E..

> +static int zx2967_i2c_reset_hardware(struct zx2967_i2c_info *zx_i2c)
> +{
> +	u32 val;
> +	u32 clk_div;
> +	u32 status;
> +
> +	val =3D I2C_MASTER | I2C_IRQ_MSK_ENABLE;
> +	zx2967_i2c_writel(zx_i2c, val, REG_CMD);
> +
> +	clk_div =3D clk_get_rate(zx_i2c->clk) / zx_i2c->clk_freq - 1;
> +	zx2967_i2c_writel(zx_i2c, clk_div, REG_CLK_DIV_FS);
> +	zx2967_i2c_writel(zx_i2c, clk_div, REG_CLK_DIV_HS);
> +
> +	zx2967_i2c_writel(zx_i2c, I2C_FIFO_MAX - 1, REG_WRCONF);
> +	zx2967_i2c_writel(zx_i2c, I2C_FIFO_MAX - 1, REG_RDCONF);
> +	zx2967_i2c_writel(zx_i2c, 1, REG_RDCONF);
> +
> +	zx2967_i2c_flush_fifos(zx_i2c);
> +
> +	status =3D zx2967_i2c_readl(zx_i2c, REG_STAT);
> +	if (status & I2C_SR_BUSY)
> +		return -EBUSY;
> +	if (status & (I2C_SR_EDEVICE | I2C_SR_EDATA))
> +		return -EIO;

Is this the error handling (NACK, etc)? Then, it got lost now since we
don't reset the hardware anymore after timeouts. But that would have
meant that errors are only detected after the timeout was reached
instead of instantly? If so, no good design. But maybe I misunderstand.

> +
> +	enable_irq(zx_i2c->irq);
> +
> +	return 0;
> +}
> +
> +static void zx2967_i2c_isr_clr(struct zx2967_i2c_info *zx_i2c)
> +{
> +	u32 status;
> +
> +	status =3D zx2967_i2c_readl(zx_i2c, REG_STAT);
> +	status |=3D I2C_IRQ_ACK_CLEAR;
> +	zx2967_i2c_writel(zx_i2c, status, REG_STAT);
> +}
> +
> +static irqreturn_t zx2967_i2c_isr(int irq, void *dev_id)
> +{
> +	u32 status;
> +	struct zx2967_i2c_info *zx_i2c =3D (struct zx2967_i2c_info *)dev_id;
> +
> +	status =3D zx2967_i2c_readl(zx_i2c, REG_STAT) & I2C_INT_MASK;
> +	zx2967_i2c_isr_clr(zx_i2c);
> +
> +	if (status & I2C_ERROR_MASK)
> +		return IRQ_HANDLED;

I would have expected the error handling here.

> +
> +	if (status & I2C_TRANS_DONE)
> +		complete(&zx_i2c->complete);
> +
> +	return IRQ_HANDLED;
> +}

=2E..

> +static int zx2967_smbus_xfer_read(struct zx2967_i2c_info *zx_i2c, int si=
ze,
> +				  union i2c_smbus_data *data)
> +{
> +	unsigned long time_left;
> +	u8 buf[2];
> +	u32 val;
> +
> +	reinit_completion(&zx_i2c->complete);
> +
> +	val =3D zx2967_i2c_readl(zx_i2c, REG_CMD);
> +	val |=3D I2C_CMB_RW_EN;
> +	zx2967_i2c_writel(zx_i2c, val, REG_CMD);
> +
> +	val =3D zx2967_i2c_readl(zx_i2c, REG_CMD);
> +	val |=3D I2C_START;
> +	zx2967_i2c_writel(zx_i2c, val, REG_CMD);
> +
> +	time_left =3D wait_for_completion_timeout(&zx_i2c->complete,
> +						I2C_TIMEOUT);
> +	if (time_left =3D=3D 0)
> +		return -ETIMEDOUT;
> +
> +	switch (size) {
> +	case I2C_SMBUS_BYTE:
> +	case I2C_SMBUS_BYTE_DATA:
> +		val =3D zx2967_i2c_readl(zx_i2c, REG_DATA);
> +		data->byte =3D val;
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +	case I2C_SMBUS_PROC_CALL:
> +		buf[0] =3D zx2967_i2c_readl(zx_i2c, REG_DATA);
> +		buf[1] =3D zx2967_i2c_readl(zx_i2c, REG_DATA);
> +		data->word =3D (buf[0] << 8) | buf[1];
> +		break;
> +	default:
> +		dev_warn(DEV(zx_i2c), "Unsupported transaction %d\n", size);

I wouldn't print something here. If an unsupported SMBus transfer is
used, your driver will fall back to emulate them via I2C. No need to
print a warning then.

> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +#define ZX2967_I2C_FUNCS (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |	\
> +		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |	\
> +		I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL |	\
> +		I2C_FUNC_I2C | I2C_FUNC_SMBUS_I2C_BLOCK)
> +
> +static u32 zx2967_i2c_func(struct i2c_adapter *adap)
> +{
> +	return ZX2967_I2C_FUNCS;
> +}

No strong opinion but I think we can return that value directly without
a define.

=2E..

> +	ret =3D i2c_add_numbered_adapter(&zx_i2c->adap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add zx2967 i2c adapter\n");

Drop the message, the core will do the reporting.

> +		goto err_clk_unprepare;
> +	}

How was this driver tested BTW?

Regards,

   Wolfram


--o5focjtu4cgg6vom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllIJo0ACgkQFA3kzBSg
KbZp1hAAhBYl/l/N/Mt8+GIyHZwjeULbuUVW6lwd/cMeIWBiCoJSy6/asO9IKGgV
lN4D02NT5f1CUv7c91cw7X8d4kgSoDJmXnlAeCXs9z0Ova+ouG6oqBbPvg8O0m+S
Wn+GvxRuyUls/hBN9QP/7mbq8r70ziWMn0BFeol49JvuW9NtWfLpcet67nMPde9b
9aV1AViYEoROWbRQ/7faW2p3KKS9N/3HhQAYe9cVrvGVBPFSoV7RbVeqxKDoBhwq
ids8JCnM9DG/i9je/6OBAgNPQXYS1ZR8CJKfHIF1Y17auEr+SoEI4T4ZWr1JT+3t
mlywa+OBZK6zBQzQsQux4cYQzDOwVNrdH3DSqohZkn5luuibHQXrna1lafYH40bu
RG3Ea2wS4ZrRaVXlPY6U723eVFNUCFebzNeEyMcAMrAHonJ+MBdKb/evI2U0NFLj
38goBjFB+cx3EA0EBHT8uDT+L1n5x7GmIOKkjUnNRZpxbUQ0lJF7qsVnURhyGGiO
pwiiPdcKCZcLG2Qor5UYlq3z1M3gtbaz3CTe7aWUZTYjQGKPDZciZ+R/OWSkqYYR
UASa1RcMbswvXTG7et1Lf3Zn2QhYaRSXKRx1+3o0nY6qIfmxz6vj8l/BqzFMVhZX
ksH/Shp/aLtE5lkJra0QoaRxGL+dhrA3m1aDVIInjWNykrJ7taQ=
=4iUv
-----END PGP SIGNATURE-----

--o5focjtu4cgg6vom--
