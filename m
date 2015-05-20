From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 20 May 2015 10:33:35 +0200
Message-ID: <20150520083335.GQ24769@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150518184300.GB28888@pengutronix.de>
 <1432089611.13819.9.camel@mtksdaap41>
 <20150520071152.GP24769@pengutronix.de>
 <1432108775.12796.11.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432108775.12796.11.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Xudong Chen <xudong.chen@mediatek.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Liguo Zhang <liguo.zhang@mediatek.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello Eddie,

On Wed, May 20, 2015 at 03:59:35PM +0800, Eddie Huang wrote:
> On Wed, 2015-05-20 at 09:11 +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, May 20, 2015 at 10:40:11AM +0800, Eddie Huang wrote:
> > > On Mon, 2015-05-18 at 20:43 +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > > > > +/* calculate i2c port speed */
> > > > It would be nice to summarize the clock frequency settings here=
=2E
> > > > Something like:
> > > >=20
> > > > 	/*
> > > > 	 * The input clock is divided by the value specified in the
> > > > 	 * device tree as clock-div. The actual bus speed is then
> > > > 	 * derived from this frequency by the following formula:
> > > > 	 *  ....
> > > >=20
> > > > This would make it possible to verify your calculations below.
> > >=20
> > > The comment will be:
> > > /*
> > >  * khz: I2C bus clock
> > >  * hclk: The input clock is divided by the value specified in the=
=20
> > >  *       device tree as clock-div
> > and which one of the two clocks you're writing about is hclk now? I
> > assume the divided one.
> > >  * div =3D (sample_cnt + 1) * (step_cnt + 1)
> > >  * khz =3D (hclk / 2) / div
> > khz for the 2nd time.
> >=20
> > >  *
> > >  * The calculation is to get div value that let result of=20
> > >  * ((hclk / 2) / div) most approach and less than khz
> > >  */
> > I imagined something more hardware related. A list of register (or
> > register bit fields) that influence the frequency and a formula
>=20
> > 	i2c_freq =3D parent_clk / clock-div * (...)
> >=20
> > (It seems to be a bit more complicated here as there are two regist=
ers
> > involved that are set differently depending on the target frequency=
=2E)
>=20
> Yes, hardware is a little complicated. I rewrite the comment:
>=20
> /*
>  * Calculate i2c port speed
>  *
>  * Hardware design:
>  * i2c_bus_freq =3D parent_clk / (clock-div * 2 * (sample_cnt) *
> (step_cnt))
>  * clock-div: fixed in hardware, but may be various in different SoCs
=2E.. fixed in hardware, but different on different SoCs.

>  *
>  * The calculation want to pick the highest bus frequency that is sti=
ll=20
>  * less than or equal to i2c->speed_hz. and the calculation try to ge=
t=20
>  * sample_cnt and step_cnt to fill in hardware register.
"The calculation picks the highest bus frequency that is still less tha=
n
or equal to i2c->speed_hz." and I'd drop the last sentence.

With that in mind I'll reply once more to the original patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
