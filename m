From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 20 May 2015 10:57:16 +0200
Message-ID: <20150520085715.GA17078@pengutronix.de>
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
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

now that I understood the formula some more comments to the calculation=
=2E

On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> +#define I2C_DEFAUT_SPEED		100000	/* hz */
DEFAULT?

> +#define MAX_FS_MODE_SPEED		400000
> +#define MAX_HS_MODE_SPEED		3400000
> +#define MAX_SAMPLE_CNT_DIV		8
> +#define MAX_STEP_CNT_DIV		64
> +#define MAX_HS_STEP_CNT_DIV		8
> [...]
> +/* calculate i2c port speed */
> +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_s=
rc_in_hz)
> +{
add a comment here, that clk_src_in_hz is the parent clock already
divided by clock-div.

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
According to the plan to tune for the highest possible rate <=3D
i2c->speed_hz, you should handle the case (i2c->speed_hz >
MAX_HS_MODE_SPEED) like i2c->speed_hz =3D=3D MAX_HS_MODE_SPEED.
Well, you might want to prevent an overflow in the calculation below
however.

> +	else if (i2c->speed_hz > MAX_FS_MODE_SPEED)
> +		max_step_cnt =3D MAX_HS_STEP_CNT_DIV;
> +	else
> +		max_step_cnt =3D MAX_STEP_CNT_DIV;
So I assume this is the hardware limit on the step_cnt value. For
=46S_MODE and below you have 6 bits and writing X corresponds to
step_cnt =3D X + 1. For HS_MODE there are only 3 bits. right?

> +	step_div =3D max_step_cnt;
> +	/* Find the best combination */
> +	khz =3D i2c->speed_hz / 1000;
> +	hclk =3D clk_src_in_hz / 1000;
Why are you dividing here? There shouldn't be an overflow problem and
you're loosing precision.

> +	min_div =3D ((hclk >> 1) + khz - 1) / khz;
The shift accounts for the fixed divider 2 in

	i2c_bus_freq =3D parent_clk / (clock-div * 2 * sample_cnt * step_cnt

? Maybe better call this opt_div instead of min_div? So now we're
searching for the best pair (sample_cnt, step_cnt) with:

	* 0 < sample_cnt < MAX_SAMPLE_CNT_DIV
	* 0 < step_cnt < max_step_cnt
	* sample_cnt * step_cnt >=3D min_div
	* optimizing for sample_cnt * step_cnt being minimal

Right?

> +	best_mul =3D MAX_SAMPLE_CNT_DIV * max_step_cnt;
> +
> +	for (sample_cnt =3D 1; sample_cnt <=3D MAX_SAMPLE_CNT_DIV; sample_c=
nt++) {
> +		step_cnt =3D (min_div + sample_cnt - 1) / sample_cnt;
DIV_ROUND_UP

> +		cnt_mul =3D step_cnt * sample_cnt;
> +		if (step_cnt > max_step_cnt)
> +			continue;
I think it can happen that you have step_cnt > max_step_cnt here, but
that (sample_cnt, max_step_cnt) still is a good pair to consider. So:

	step_cnt =3D DIV_ROUND_UP(min_div, sample_cnt);
	if (step_cnt > max_step_cnt)
		step_cnt =3D max_step_cnt;

	cnt_mul =3D step_cnt * sample_cnt;

> +
> +		if (cnt_mul < best_mul) {
> +			best_mul =3D cnt_mul;
> +			sample_div =3D sample_cnt;
> +			step_div =3D step_cnt;
I'd call these best_sample_cnt and best_step_cnt instead of sample_div
and step_div.

> +			if (best_mul =3D=3D min_div)
> +				break;
> +		}
> +	}
> +
> +	sample_cnt =3D sample_div;
> +	step_cnt =3D step_div;
> +	sclk =3D hclk / (2 * sample_cnt * step_cnt);
> +	if (sclk > khz) {
Can this happen? A better name for "sclk" would be "bus_freq"?

> +		dev_dbg(i2c->dev, "%s mode: unsupported speed (%ldkhz)\n",
> +			(i2c->speed_hz > MAX_HS_MODE_SPEED) ? "HS" : "ST/FT",
What is ST/FR? I would have expected FS here.

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
> +	}
Would it be sensible to write these values directly into hardware here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
