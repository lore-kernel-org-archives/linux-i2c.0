From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Mon, 18 May 2015 20:43:00 +0200
Message-ID: <20150518184300.GB28888@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431967209-5261-3-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> From: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>=20
> The mediatek SoCs have I2C controller that handle I2C transfer.
> This patch include common I2C bus driver.
> This driver is compatible with I2C controller on mt65xx/mt81xx.
>=20
> Signed-off-by: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig      |   9 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-mt65xx.c | 675 ++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 685 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2255af2..14c7266 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -620,6 +620,15 @@ config I2C_MPC
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mpc.
> =20
> +config I2C_MT65XX
> +	tristate "MediaTek I2C adapter"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  This selects the MediaTek(R) Integrated Inter Circuit bus driver
> +	  for MT65xx and MT81xx.
> +	  If you want to use MediaTek(R) I2C interface, say Y or M here.
> +	  If unsure, say N.
> +
>  config I2C_MV64XXX
>  	tristate "Marvell mv64xxx I2C Controller"
>  	depends on MV64X60 || PLAT_ORION || ARCH_SUNXI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index cdf941d..abbf422 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_I2C_JZ4780)	+=3D i2c-jz4780.o
>  obj-$(CONFIG_I2C_KEMPLD)	+=3D i2c-kempld.o
>  obj-$(CONFIG_I2C_MESON)		+=3D i2c-meson.o
>  obj-$(CONFIG_I2C_MPC)		+=3D i2c-mpc.o
> +obj-$(CONFIG_I2C_MT65XX)	+=3D i2c-mt65xx.o
>  obj-$(CONFIG_I2C_MV64XXX)	+=3D i2c-mv64xxx.o
>  obj-$(CONFIG_I2C_MXS)		+=3D i2c-mxs.o
>  obj-$(CONFIG_I2C_NOMADIK)	+=3D i2c-nomadik.o
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c=
-mt65xx.c
> new file mode 100644
> index 0000000..7462f05
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -0,0 +1,675 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Xudong.chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
s/Xudong.chen/Xudong Chen/

> +#define I2C_DRV_NAME		"mt-i2c"
i2c-mt65xx ?

> +}
> +
> +/* calculate i2c port speed */
It would be nice to summarize the clock frequency settings here.
Something like:

	/*
	 * The input clock is divided by the value specified in the
	 * device tree as clock-div. The actual bus speed is then
	 * derived from this frequency by the following formula:
	 *  ....

This would make it possible to verify your calculations below.

> +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_s=
rc_in_hz)
> +{
> +	unsigned int khz;
> +	unsigned int step_cnt;
> +	unsigned int sample_cnt;
> +	unsigned int sclk;
> +	unsigned int hclk;
> +	unsigned int max_step_cnt;
> +	unsigned int sample_div =3D MAX_SAMPLE_CNT_DIV;
> +	unsigned int step_div;
> +	unsigned int min_div;
> +	unsigned int best_mul;
> +	unsigned int cnt_mul;
> +
> +	if (i2c->speed_hz > MAX_HS_MODE_SPEED)
> +		return -EINVAL;
> +	else if (i2c->speed_hz > MAX_FS_MODE_SPEED)
> +		max_step_cnt =3D MAX_HS_STEP_CNT_DIV;
> +	else
> +		max_step_cnt =3D MAX_STEP_CNT_DIV;
> +
> +	step_div =3D max_step_cnt;
> +	/* Find the best combination */
> +	khz =3D i2c->speed_hz / 1000;
> +	hclk =3D clk_src_in_hz / 1000;
> +	min_div =3D ((hclk >> 1) + khz - 1) / khz;
This is DIV_ROUND_UP(hclk >> 1, khz).

> +	best_mul =3D MAX_SAMPLE_CNT_DIV * max_step_cnt;
> +
> +	for (sample_cnt =3D 1; sample_cnt <=3D MAX_SAMPLE_CNT_DIV; sample_c=
nt++) {
> +		step_cnt =3D (min_div + sample_cnt - 1) / sample_cnt;
> +		cnt_mul =3D step_cnt * sample_cnt;
> +		if (step_cnt > max_step_cnt)
> +			continue;
> +
> +		if (cnt_mul < best_mul) {
> +			best_mul =3D cnt_mul;
> +			sample_div =3D sample_cnt;
> +			step_div =3D step_cnt;
> +			if (best_mul =3D=3D min_div)
> +				break;
> +		}
> +	}
> +
> +	sample_cnt =3D sample_div;
> +	step_cnt =3D step_div;
> +	sclk =3D hclk / (2 * sample_cnt * step_cnt);
> +	if (sclk > khz) {
> +		dev_dbg(i2c->dev, "%s mode: unsupported speed (%ldkhz)\n",
> +			(i2c->speed_hz > MAX_HS_MODE_SPEED) ? "HS" : "ST/FT",
> +			(long int)khz);
> +		return -EINVAL;
> +	}
> +
> +	step_cnt--;
> +	sample_cnt--;
> +
> +	if (i2c->speed_hz > MAX_FS_MODE_SPEED) {
> +		/* Set the hign speed mode register */
> +		i2c->timing_reg =3D I2C_FS_TIME_INIT_VALUE;
> +		i2c->high_speed_reg =3D I2C_TIME_DEFAULT_VALUE |
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 12 |
> +			(step_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8;
> +	} else {
> +		i2c->timing_reg =3D
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8 |
> +			(step_cnt & I2C_TIMING_STEP_DIV_MASK) << 0;
> +		/* Disable the high speed transaction */
> +		i2c->high_speed_reg =3D I2C_TIME_CLR_VALUE;
Can it happen that sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK !=3D
sample_cnt? If yes, what is the influence on correctness? Same question
for step_cnt.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
