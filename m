From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Wed, 3 Jul 2013 15:20:53 +0200
Message-ID: <201307031520.53637.marex@denx.de>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com> <20130702181115.GR27010@pengutronix.de> <51D31FD1.4080002@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51D31FD1.4080002-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Fabio Estevam,

> Hi Uwe,
>=20
> On 07/02/2013 03:11 PM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 02, 2013 at 01:01:00PM -0300, Fabio Estevam wrote:
> >> According to mx23 erratum 2727:
> >>=20
> >> "2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK =
set.
> >>=20
> >> Description:
> >>=20
> >> When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not gener=
ated.
> >> However, the SDA line is read at the proper timing interval. If
> >> RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
> >> Also, the HW_I2C_VERSION register incorrectly states the version i=
s 1.2.
> >> It should be 1.3.
> >>=20
> >> Workaround:
> >> HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to=
 1 to
> >> enable the fix for this issue."
> >>=20
> >> It has also been noticed that mx28 needs to implement this fix in =
order
> >> to have SMBus to work properly.
> >>=20
> >> Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
> >> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >=20
> > Did you see this making the driver handle some situations that caus=
ed
> > failure before?
>=20
> No, I haven't. I saw the report from Christoph in the linux-arm-kerne=
l
> mailing list:
> http://marc.info/?l=3Dlinux-arm-kernel&m=3D137277422127826&w=3D2
>=20
> And thought it could be nice if we could get it fixed for mx23 and mx=
28.

How/when does this error manifest on the scope/LA?

Best regards,
Marek Vasut
