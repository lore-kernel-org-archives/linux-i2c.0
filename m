From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 20 May 2015 21:03:40 +0800
Message-ID: <1432127020.20394.15.camel@mtksdaap41>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
	 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
	 <20150520085715.GA17078@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150520085715.GA17078-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi Uwe,

On Wed, 2015-05-20 at 10:57 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> now that I understood the formula some more comments to the calculati=
on.
>=20
> On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > +#define I2C_DEFAUT_SPEED		100000	/* hz */
> DEFAULT?
>=20
> > +#define MAX_FS_MODE_SPEED		400000
> > +#define MAX_HS_MODE_SPEED		3400000
> > +#define MAX_SAMPLE_CNT_DIV		8
> > +#define MAX_STEP_CNT_DIV		64
> > +#define MAX_HS_STEP_CNT_DIV		8
> > [...]
> > +/* calculate i2c port speed */
> > +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk=
_src_in_hz)
> > +{
> add a comment here, that clk_src_in_hz is the parent clock already
> divided by clock-div.
>=20
> > +	unsigned int khz;
> > +	unsigned int step_cnt;
> > +	unsigned int sample_cnt;
> > +	unsigned int sclk;
> > +	unsigned int hclk;
> > +	unsigned int max_step_cnt;
> > +	unsigned int sample_div =3D MAX_SAMPLE_CNT_DIV;
> > +	unsigned int step_div;
> > +	unsigned int min_div;
> > +	unsigned int best_mul;
> > +	unsigned int cnt_mul;
> > +
> > +	if (i2c->speed_hz > MAX_HS_MODE_SPEED)
> > +		return -EINVAL;
> According to the plan to tune for the highest possible rate <=3D
> i2c->speed_hz, you should handle the case (i2c->speed_hz >
> MAX_HS_MODE_SPEED) like i2c->speed_hz =3D=3D MAX_HS_MODE_SPEED.
> Well, you might want to prevent an overflow in the calculation below
> however.

The check here means we don't support speed > MAX_HS_MODE_SPEED. This i=
s
different then slightly slower bus speed due to rounding error.

> > +	else if (i2c->speed_hz > MAX_FS_MODE_SPEED)
> > +		max_step_cnt =3D MAX_HS_STEP_CNT_DIV;
> > +	else
> > +		max_step_cnt =3D MAX_STEP_CNT_DIV;
> So I assume this is the hardware limit on the step_cnt value. For
> FS_MODE and below you have 6 bits and writing X corresponds to
> step_cnt =3D X + 1. For HS_MODE there are only 3 bits. right?

Yes, correct.

> > +	step_div =3D max_step_cnt;
> > +	/* Find the best combination */
> > +	khz =3D i2c->speed_hz / 1000;
> > +	hclk =3D clk_src_in_hz / 1000;
> Why are you dividing here? There shouldn't be an overflow problem and
> you're loosing precision.

Agreed, they should be removed.

> > +	min_div =3D ((hclk >> 1) + khz - 1) / khz;
> The shift accounts for the fixed divider 2 in
>=20
> 	i2c_bus_freq =3D parent_clk / (clock-div * 2 * sample_cnt * step_cnt
>=20
> ? Maybe better call this opt_div instead of min_div? So now we're
> searching for the best pair (sample_cnt, step_cnt) with:
>=20
> 	* 0 < sample_cnt < MAX_SAMPLE_CNT_DIV
> 	* 0 < step_cnt < max_step_cnt
> 	* sample_cnt * step_cnt >=3D min_div
> 	* optimizing for sample_cnt * step_cnt being minimal
>=20
> Right?

Yes.

> > +	best_mul =3D MAX_SAMPLE_CNT_DIV * max_step_cnt;
> > +
> > +	for (sample_cnt =3D 1; sample_cnt <=3D MAX_SAMPLE_CNT_DIV; sample=
_cnt++) {
> > +		step_cnt =3D (min_div + sample_cnt - 1) / sample_cnt;
> DIV_ROUND_UP
>=20
> > +		cnt_mul =3D step_cnt * sample_cnt;
> > +		if (step_cnt > max_step_cnt)
> > +			continue;
> I think it can happen that you have step_cnt > max_step_cnt here, but
> that (sample_cnt, max_step_cnt) still is a good pair to consider. So:


If step_cnt > max_step_cnt, then sample_cnt * max_step_cnt < min_div.
This means (sample_cnt, max_step_cnt) is not a valid.

Joe.C
