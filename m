From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Wed, 21 Aug 2013 05:18:56 +0200
Message-ID: <201308210518.56575.marex@denx.de>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com> <52120D35.707@freescale.com> <20130820185227.GO30496@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130820185227.GO30496-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Uwe Kleine-K=F6nig,

> Hello,
>=20
> On Mon, Aug 19, 2013 at 09:19:01AM -0300, Fabio Estevam wrote:
> > On 08/15/2013 07:08 AM, Wolfram Sang wrote:
> > >On Tue, Jul 02, 2013 at 01:01:00PM -0300, Fabio Estevam wrote:
> > >>According to mx23 erratum 2727:
> > >>
> > >>"2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK=
 set.
> > >>
> > >>Description:
> > >>
> > >>When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not gene=
rated.
> > >>However, the SDA line is read at the proper timing interval. If
> > >>RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
> > >>Also, the HW_I2C_VERSION register incorrectly states the version =
is
> > >>1.2. It should be 1.3.
> > >>
> > >>Workaround:
> > >>HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set t=
o 1 to
> > >>enable the fix for this issue."
> > >>
> > >>It has also been noticed that mx28 needs to implement this fix in=
 order
> > >>to have SMBus to work properly.
> > >>
> > >>Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
> > >>Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > >
> > >What's with this one? Bogus? Needed? Still needed after PIO rework=
?
> >=20
> > According to the mx23 erratum 2727 this patch is needed.
>=20
> Last time I worked with i2c stuff on mxs my impression was the mx23
> erratum 2727 is non-sense. Having HW_I2C_CTRL1[ACK_MODE] set or not
> didn't made any difference in my tests.

Yeah, I can confirm this one.

> I suspect that the description isn't complete. So the driver does
> already use RETAIN_CLOCK (for the select phase) which up to know didn=
't
> made any problems on mx23 even without having ACK_MODE=3D1.
>=20
> The statement about the HW_I2C_VERSION register appears just misplace=
d
> there.
>=20
> So I'd vote for not taking this patch until there is a better
> understanding of the eventual problem.

I was doing some pretty thorough test when doing the PIO rework and wat=
ched the=20
bus with LA, but didn't notice any difference whether the bit was or wa=
snt set.=20
So either way WFM. On MX28 though, the bit is set after the I2C block i=
s reset,=20
on MX23 it is unset, that's the only thing I observed.

Best regards,
Marek Vasut
