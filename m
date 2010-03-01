From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: add i2c tree for embedded platforms
Date: Mon, 1 Mar 2010 11:38:40 +0100
Message-ID: <20100301113840.4d6b4e7d@hyperion.delvare>
References: <20100224110044.GB15181@pengutronix.de>
	<1267009306-17227-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100228155754.GC16745@n2100.arm.linux.org.uk>
	<20100301090714.GB29952@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100301090714.GB29952-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 1 Mar 2010 10:07:14 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Feb 28, 2010 at 03:57:54PM +0000, Russell King - ARM Linux wr=
ote:
> > On Wed, Feb 24, 2010 at 12:01:46PM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
=2Ede>
> > > Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > ---
> > >  MAINTAINERS |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 2533fc4..a3c936c 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2626,6 +2626,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-li=
nux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > >  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >  W:	http://i2c.wiki.kernel.org/
> > >  T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/j=
delvare-i2c/
> > > +T:	git git://git.fluff.org/bjdooks/linux.git
> >=20
> > This is wrong.  This is the same tree which I pull ARM stuff from, =
so it
> > needs qualifying with a branch name.
> $(git ls-remote git://git.fluff.org/bjdooks/linux.git) suggests two
> candidates:
>=20
> 	for-linus/i2c
> 	next-i2c
>=20
> And I think for now this is only parsed by humans and everbody should=
 be
> able to notice that e.g. "next-s3c" doesn't contain i2c patches in th=
e
> presence of the two above branches.
>=20
> So unless there is a syntax to specify more than one branch I suggest=
 to
> keep it as is.  Or should we only list next-i2c?  Ben, what do you
> think?

I presume that for-linus/i2c is a temporary subset of next-i2c for
Linus' consumption. So we can ignore for-linus/i2c and only list
next-i2c.

> (Maybe we can just make it:
>=20
> 	T: git git://git.fluff.org/bjdooks/linux.git for-linus/i2c
> 	T: git git://git.fluff.org/bjdooks/linux.git next-i2c
>=20
> but this is a bit too much IMHO.  (Who volunteers to list all branche=
s
> of tip in MAINTAINERS? ;-))
>=20
> Best regards
> Uwe
>=20


--=20
Jean Delvare
