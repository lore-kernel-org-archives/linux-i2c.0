From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c i.MX: Fix divider table
Date: Wed, 11 Jul 2012 21:44:53 +0200
Message-ID: <20120711194453.GS30009@pengutronix.de>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
 <20120705145236.GA2735@richard-laptop>
 <20120705160153.GT30009@pengutronix.de>
 <20120706005249.GA26888@b20223-02.ap.freescale.net>
 <20120706062852.GZ30009@pengutronix.de>
 <20120711060121.GB30055@b20223-02.ap.freescale.net>
 <20120711183838.GM30009@pengutronix.de>
 <4FFDCFDB.7020402@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FFDCFDB.7020402-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, b35325-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 11, 2012 at 12:11:23PM -0700, Troy Kisky wrote:
> On 7/11/2012 11:38 AM, Sascha Hauer wrote:
> >Hi Richard,
> >
> >On Wed, Jul 11, 2012 at 02:01:21PM +0800, Richard Zhao wrote:
> >>IC guys confirmed that the spec is right:
> >>
> >>This an adaptive feature of our I2C module may apply to all IMX chi=
ps.
> >>No mistake in the table of RMs.
> >>
> >>The divider is designed to guarantee SCL high level and low level l=
ast
> >>time. Divider will hold when SCL transition from 1 to 0 or 0 to 1, =
if
> >>the transition time is longer than 1 internal pre-divided clock cyc=
le.
> >>The pre-divided clock is divided from I2C module clock, used for
> >>generating SCL. So you will see SCL clock cycle is some way longer =
than
> >>calculated value using IFDR.
> >>
> >>Transition time will different from rising or falling edge, differe=
nt
> >>pull-up resistors, and different SCL loading.
> >>
> >>This feature make sure transition time won=E2=80=99t eat both level=
 time of SCL.
> >Thanks for clarification. Does this mean that this feature is used t=
o
> >synchronize between the bus clock and and bitclock?
> >
> >I'll send a documentation patch for this next week to make this clea=
r.
> >
> >Sascha
> >
> How does this explain why column 2 matched your measurements, but 1,
> 3, and 4 didn't.
> And you tested on 2 different boards.
> Something doesn't smell right.

This reminds me that one divider value on i.MX53 crashed the whole I2C
module (it was unusable until reset). The same value worked on i.MX1.
Some divider values produced a terrible jitter on the clock output. So
it really seems that there is something more going on than just a simpl=
e
divider.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
