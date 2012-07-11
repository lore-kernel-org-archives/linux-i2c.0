From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c i.MX: Fix divider table
Date: Wed, 11 Jul 2012 14:01:21 +0800
Message-ID: <20120711060121.GB30055@b20223-02.ap.freescale.net>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
 <20120705145236.GA2735@richard-laptop>
 <20120705160153.GT30009@pengutronix.de>
 <20120706005249.GA26888@b20223-02.ap.freescale.net>
 <20120706062852.GZ30009@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120706062852.GZ30009-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, b35325-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 06, 2012 at 08:28:52AM +0200, Sascha Hauer wrote:
> On Fri, Jul 06, 2012 at 08:52:50AM +0800, Richard Zhao wrote:
> > On Thu, Jul 05, 2012 at 06:01:53PM +0200, Sascha Hauer wrote:
> > > On Thu, Jul 05, 2012 at 10:52:39PM +0800, Richard Zhao wrote:
> > > > On Thu, Jul 05, 2012 at 03:10:26PM +0200, Sascha Hauer wrote:
> > > > > Measurements on i.MX1 and i.MX53 have shown that the divider =
values
> > > > > in the datasheets are wrong. the values from first, third and=
 fourth
> > > > > column were all measured to be 8 higher than in the datasheet=
=2E It
> > > > > should be safe to assume that the SoCs between i.MX1 and i.MX=
53 behave
> > > > > the same as the i2c unit is unchanged since the i.MX1.
> > > > We may need to check with IC guys? Or you've done?
> > >=20
> > > I don't have contact to the IC guys. Could you do this? I'd be
> > > interested in the results.
> > Sure, but it may be slow, as you know, many people are in summer br=
eak.
>=20
> Thanks. It can take longer, the resulting frequencies are all too low=
,
> so we are on the safe side.
Sascha,

IC guys confirmed that the spec is right:

This an adaptive feature of our I2C module may apply to all IMX chips.
No mistake in the table of RMs.

The divider is designed to guarantee SCL high level and low level last
time. Divider will hold when SCL transition from 1 to 0 or 0 to 1, if
the transition time is longer than 1 internal pre-divided clock cycle.
The pre-divided clock is divided from I2C module clock, used for
generating SCL. So you will see SCL clock cycle is some way longer than
calculated value using IFDR.

Transition time will different from rising or falling edge, different
pull-up resistors, and different SCL loading.

This feature make sure transition time won=E2=80=99t eat both level tim=
e of SCL.

Thanks
Richard
>=20
> Sascha
>=20
> --=20
> Pengutronix e.K.                           |                         =
    |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5=
555 |
>=20
