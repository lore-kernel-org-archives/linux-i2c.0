From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 20 May 2015 15:59:35 +0800
Message-ID: <1432108775.12796.11.camel@mtksdaap41>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
	 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
	 <20150518184300.GB28888@pengutronix.de>
	 <1432089611.13819.9.camel@mtksdaap41>
	 <20150520071152.GP24769@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150520071152.GP24769-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On Wed, 2015-05-20 at 09:11 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Eddie,
>=20
> On Wed, May 20, 2015 at 10:40:11AM +0800, Eddie Huang wrote:
> > On Mon, 2015-05-18 at 20:43 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > > > +/* calculate i2c port speed */
> > > It would be nice to summarize the clock frequency settings here.
> > > Something like:
> > >=20
> > > 	/*
> > > 	 * The input clock is divided by the value specified in the
> > > 	 * device tree as clock-div. The actual bus speed is then
> > > 	 * derived from this frequency by the following formula:
> > > 	 *  ....
> > >=20
> > > This would make it possible to verify your calculations below.
> >=20
> > The comment will be:
> > /*
> >  * khz: I2C bus clock
> >  * hclk: The input clock is divided by the value specified in the=20
> >  *       device tree as clock-div
> and which one of the two clocks you're writing about is hclk now? I
> assume the divided one.
> >  * div =3D (sample_cnt + 1) * (step_cnt + 1)
> >  * khz =3D (hclk / 2) / div
> khz for the 2nd time.
>=20
> >  *
> >  * The calculation is to get div value that let result of=20
> >  * ((hclk / 2) / div) most approach and less than khz
> >  */
> I imagined something more hardware related. A list of register (or
> register bit fields) that influence the frequency and a formula

> 	i2c_freq =3D parent_clk / clock-div * (...)
>=20
> (It seems to be a bit more complicated here as there are two register=
s
> involved that are set differently depending on the target frequency.)

Yes, hardware is a little complicated. I rewrite the comment:

/*
 * Calculate i2c port speed
 *
 * Hardware design:
 * i2c_bus_freq =3D parent_clk / (clock-div * 2 * (sample_cnt) *
(step_cnt))
 * clock-div: fixed in hardware, but may be various in different SoCs
 *
 * The calculation want to pick the highest bus frequency that is still=
=20
 * less than or equal to i2c->speed_hz. and the calculation try to get=20
 * sample_cnt and step_cnt to fill in hardware register.
 */

>=20
> > > > +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int=
 clk_src_in_hz)
> clk_src_in_hz is the module's input rate already divided by clock-div=
=2E
> This clock-div value is fixed in hardware and unchangeable, right?
Yes

> Maybe give that divided clock a nice name?
I don't know, after new comment, maybe this name is ok.

> The target frequency is i2c->speed_hz, so among the possible frequenc=
ies
> we want to pick the highest one that is still less than or equal
> i2c->speed_hz, right?
Right.

>=20
> > > > +		/* Set the hign speed mode register */
> I just notice s/hign/high/ here.
>=20
Thanks, will fix it.

Eddie
