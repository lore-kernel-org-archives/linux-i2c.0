From: Dong Aisheng-B29396 <B29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
Date: Thu, 24 Nov 2011 09:09:15 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77233A509@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
 <20111124082903.GV19986@pengutronix.de>
 <20111124083747.GE8439@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F77233A4E4@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111124090653.GX19986@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111124090653.GX19986-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org]
> Sent: Thursday, November 24, 2011 5:07 PM
> To: Dong Aisheng-B29396
> Cc: Wolfram Sang; Shawn Guo; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Be=
n
> Dooks; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
>=20
> Hello,
>=20
> On Thu, Nov 24, 2011 at 09:02:21AM +0000, Dong Aisheng-B29396 wrote:
> > > > > diff --git a/drivers/i2c/busses/i2c-mxs.c
> > > > > b/drivers/i2c/busses/i2c-mxs.c index 7e78f7c..00f098f 100644
> > > > > --- a/drivers/i2c/busses/i2c-mxs.c
> > > > > +++ b/drivers/i2c/busses/i2c-mxs.c
> > > > > @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct
> > > > > mxs_i2c_dev *i2c)
> > > > >
> > > > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8
> > > > > *buf, int len)  {
> > > > > -	u32 data;
> > > > > +	u32 data =3D 0;
> > > > >  	int i;
> > > > >
> > > > >  	for (i =3D 0; i < len; i++) {
> > > > Looks like a stupid compiler. Then better use
> > > >
> > > > 	u32 uninitialized_var(data);
> > >
> > > Leave it as it is and fix the compiler? Will do another test late=
r
> > > to make sure.
> > >
> >
> > Compiler is wrong?
> > Just from the code that it seems to be right the 'data' might be us=
ed
> > uninitialized.
> >
> > Something I missed?
> >
> > static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, in=
t
> > len) {
> >         u32 data;
> >         int i;
> >
> >         for (i =3D 0; i < len; i++) {
> >                 if ((i & 3) =3D=3D 0) {
> >                         if (mxs_i2c_wait_for_data(i2c))
> >                                 return -ETIMEDOUT;
> >                         data =3D readl(i2c->regs + MXS_I2C_QUEUEDAT=
A);
> >                 }
> >                 buf[i] =3D data & 0xff;
> >                 data >>=3D 8;
> >         }
> When data is used the first time, i is 0, so it went through the body=
 of
> the if above before which assigned data. So no, data is initialized w=
hen
> used to assign buf[i].
>=20
Ok, Thanks for the info.
So the compiler should do intelligent checking.

Regards
Dong Aisheng
