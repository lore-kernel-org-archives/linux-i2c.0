From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Tue, 20 Aug 2013 20:52:27 +0200
Message-ID: <20130820185227.GO30496@pengutronix.de>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com>
 <20130815100809.GE2987@katana>
 <52120D35.707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52120D35.707-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Mon, Aug 19, 2013 at 09:19:01AM -0300, Fabio Estevam wrote:
> On 08/15/2013 07:08 AM, Wolfram Sang wrote:
> >On Tue, Jul 02, 2013 at 01:01:00PM -0300, Fabio Estevam wrote:
> >>According to mx23 erratum 2727:
> >>
> >>"2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK s=
et.
> >>
> >>Description:
> >>
> >>When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not genera=
ted.
> >>However, the SDA line is read at the proper timing interval. If
> >>RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
> >>Also, the HW_I2C_VERSION register incorrectly states the version is=
 1.2.
> >>It should be 1.3.
> >>
> >>Workaround:
> >>HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to =
1 to
> >>enable the fix for this issue."
> >>
> >>It has also been noticed that mx28 needs to implement this fix in o=
rder to have
> >>SMBus to work properly.
> >>
> >>Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
> >>Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >
> >What's with this one? Bogus? Needed? Still needed after PIO rework?
>=20
> According to the mx23 erratum 2727 this patch is needed.
Last time I worked with i2c stuff on mxs my impression was the mx23
erratum 2727 is non-sense. Having HW_I2C_CTRL1[ACK_MODE] set or not
didn't made any difference in my tests.

I suspect that the description isn't complete. So the driver does
already use RETAIN_CLOCK (for the select phase) which up to know didn't
made any problems on mx23 even without having ACK_MODE=3D1.

The statement about the HW_I2C_VERSION register appears just misplaced
there.

So I'd vote for not taking this patch until there is a better
understanding of the eventual problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
