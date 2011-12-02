From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
Date: Fri, 2 Dec 2011 20:42:02 +0100
Message-ID: <201112022042.03160.marek.vasut@gmail.com>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org> <20111125011519.GA18403@S2100-06.ap.freescale.net> <20111125090806.GA2535@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111125090806.GA2535-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> On Fri, Nov 25, 2011 at 09:15:20AM +0800, Shawn Guo wrote:
> > On Thu, Nov 24, 2011 at 09:37:47AM +0100, Wolfram Sang wrote:
> > > On Thu, Nov 24, 2011 at 09:29:03AM +0100, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > Hello Shawn,
> > > >=20
> > > > On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
> > > > >   CC      drivers/i2c/busses/i2c-mxs.o
> > > > >=20
> > > > > drivers/i2c/busses/i2c-mxs.c: In function =E2=80=98mxs_i2c_xf=
er=E2=80=99:
> > > > > drivers/i2c/busses/i2c-mxs.c:196:6: warning: =E2=80=98data=E2=
=80=99 may be used
> > > > > uninitialized in this function
> > > > >=20
> > > > > Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > > ---
> > > > >=20
> > > > >  drivers/i2c/busses/i2c-mxs.c |    2 +-
> > > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/i2c/busses/i2c-mxs.c
> > > > > b/drivers/i2c/busses/i2c-mxs.c index 7e78f7c..00f098f 100644
> > > > > --- a/drivers/i2c/busses/i2c-mxs.c
> > > > > +++ b/drivers/i2c/busses/i2c-mxs.c
> > > > > @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct
> > > > > mxs_i2c_dev *i2c)
> > > > >=20
> > > > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *=
buf,
> > > > >  int len) {
> > > > >=20
> > > > > -	u32 data;
> > > > > +	u32 data =3D 0;
> > > > >=20
> > > > >  	int i;
> > > > >  =09
> > > > >  	for (i =3D 0; i < len; i++) {
> > > >=20
> > > > Looks like a stupid compiler. Then better use
> > > >=20
> > > > 	u32 uninitialized_var(data);
> > >=20
> > > Leave it as it is and fix the compiler? Will do another test late=
r to
> > > make sure.
> >=20
> > Ben, do you have an opinion on this, leave it there or fix it?
>=20
> Sorry, forgot the tests yesterday. I don't like random annotations
> because of faulty compilers. Please fix that one. NACK from me.

Hi,

I hit this with emdebian gcc 4.6.1 ... I'd be for merging this u32 data=
 =3D 0;=20
stuff, so on my side it's ACK.

M
