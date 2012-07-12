From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c i.MX: Fix divider table
Date: Thu, 12 Jul 2012 08:45:22 +0800
Message-ID: <20120712004522.GA21635@b20223-02.ap.freescale.net>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
 <20120705145236.GA2735@richard-laptop>
 <20120705160153.GT30009@pengutronix.de>
 <20120706005249.GA26888@b20223-02.ap.freescale.net>
 <20120706062852.GZ30009@pengutronix.de>
 <20120711060121.GB30055@b20223-02.ap.freescale.net>
 <20120711183838.GM30009@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120711183838.GM30009-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, b35325-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 11, 2012 at 08:38:38PM +0200, Sascha Hauer wrote:
> Hi Richard,
>=20
> On Wed, Jul 11, 2012 at 02:01:21PM +0800, Richard Zhao wrote:
> >=20
> > IC guys confirmed that the spec is right:
> >=20
> > This an adaptive feature of our I2C module may apply to all IMX chi=
ps.
> > No mistake in the table of RMs.
> >=20
> > The divider is designed to guarantee SCL high level and low level l=
ast
> > time. Divider will hold when SCL transition from 1 to 0 or 0 to 1, =
if
> > the transition time is longer than 1 internal pre-divided clock cyc=
le.
> > The pre-divided clock is divided from I2C module clock, used for
> > generating SCL. So you will see SCL clock cycle is some way longer =
than
> > calculated value using IFDR.
> >=20
> > Transition time will different from rising or falling edge, differe=
nt
> > pull-up resistors, and different SCL loading.
> >=20
> > This feature make sure transition time won=E2=80=99t eat both level=
 time of SCL.
>=20
> Thanks for clarification. Does this mean that this feature is used to
> synchronize between the bus clock and and bitclock?
Per my understanding,
Not exactly. Divided clock is only used for count time of SCL level
hold. This means, even if the i2c bus loading is high (long level
setup time), the i2c may still work.

Thanks
Richard
>=20
> I'll send a documentation patch for this next week to make this clear=
=2E
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
