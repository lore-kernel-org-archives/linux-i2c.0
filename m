From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Thu, 21 May 2015 15:01:29 +0800
Message-ID: <1432191689.28646.11.camel@mtksdaap41>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
	 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
	 <20150520085715.GA17078@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520085715.GA17078@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Xudong Chen <xudong.chen@mediatek.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liguo Zhang <liguo.zhang@mediatek.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Please see my reply below (I skip comments that already reply in anothe=
r
mail).

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
Yes, will fix.

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
We move parent_clk div clock-div in mtk_i2c_set_speed function, I think
this is more clear.

> > +	step_div =3D max_step_cnt;
> > +	/* Find the best combination */
> > +	khz =3D i2c->speed_hz / 1000;
> > +	hclk =3D clk_src_in_hz / 1000;
> Why are you dividing here? There shouldn't be an overflow problem and
> you're loosing precision.
OK, will remove div 1000.

>=20
> > +	min_div =3D ((hclk >> 1) + khz - 1) / khz;
> The shift accounts for the fixed divider 2 in
>=20
> 	i2c_bus_freq =3D parent_clk / (clock-div * 2 * sample_cnt * step_cnt
>=20
> ? Maybe better call this opt_div instead of min_div?=20
OK

>=20
> > +	best_mul =3D MAX_SAMPLE_CNT_DIV * max_step_cnt;
> > +
> > +	for (sample_cnt =3D 1; sample_cnt <=3D MAX_SAMPLE_CNT_DIV; sample=
_cnt++) {
> > +		step_cnt =3D (min_div + sample_cnt - 1) / sample_cnt;
> DIV_ROUND_UP
OK

> > +
> > +		if (cnt_mul < best_mul) {
> > +			best_mul =3D cnt_mul;
> > +			sample_div =3D sample_cnt;
> > +			step_div =3D step_cnt;
> I'd call these best_sample_cnt and best_step_cnt instead of sample_di=
v
> and step_div.
OK

>=20
> > +			if (best_mul =3D=3D min_div)
> > +				break;
> > +		}
> > +	}
> > +
> > +	sample_cnt =3D sample_div;
> > +	step_cnt =3D step_div;
> > +	sclk =3D hclk / (2 * sample_cnt * step_cnt);
> > +	if (sclk > khz) {
> Can this happen? A better name for "sclk" would be "bus_freq"?
Yes, if i2c->speed_hz is too small, not able to get target_speed using
hardware div.=20

>=20
> > +		dev_dbg(i2c->dev, "%s mode: unsupported speed (%ldkhz)\n",
> > +			(i2c->speed_hz > MAX_HS_MODE_SPEED) ? "HS" : "ST/FT",
> What is ST/FR? I would have expected FS here.
Please skip it.The debug message is too lousy.

>=20
> > +			(long int)khz);
> > +		return -EINVAL;
> > +	}
> > +
> > +	step_cnt--;
> > +	sample_cnt--;
> > +
> > +	if (i2c->speed_hz > MAX_FS_MODE_SPEED) {
> > +		/* Set the hign speed mode register */
> > +		i2c->timing_reg =3D I2C_FS_TIME_INIT_VALUE;
> > +		i2c->high_speed_reg =3D I2C_TIME_DEFAULT_VALUE |
> > +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 12 |
> > +			(step_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8;
> > +	} else {
> > +		i2c->timing_reg =3D
> > +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8 |
> > +			(step_cnt & I2C_TIMING_STEP_DIV_MASK) << 0;
> > +		/* Disable the high speed transaction */
> > +		i2c->high_speed_reg =3D I2C_TIME_CLR_VALUE;
> > +	}
> Would it be sensible to write these values directly into hardware her=
e?
No.In some error cases, we want to reinitialize hardware, keep these
values to avoid calculate again.

Eddie
