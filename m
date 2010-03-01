From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: add i2c tree for embedded platforms
Date: Mon, 1 Mar 2010 10:07:14 +0100
Message-ID: <20100301090714.GB29952@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de> <1267009306-17227-3-git-send-email-u.kleine-koenig@pengutronix.de> <20100228155754.GC16745@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100228155754.GC16745-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 28, 2010 at 03:57:54PM +0000, Russell King - ARM Linux wrot=
e:
> On Wed, Feb 24, 2010 at 12:01:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> >  MAINTAINERS |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2533fc4..a3c936c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2626,6 +2626,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linu=
x@fluff.org>
> >  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >  W:	http://i2c.wiki.kernel.org/
> >  T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jde=
lvare-i2c/
> > +T:	git git://git.fluff.org/bjdooks/linux.git
>=20
> This is wrong.  This is the same tree which I pull ARM stuff from, so=
 it
> needs qualifying with a branch name.
$(git ls-remote git://git.fluff.org/bjdooks/linux.git) suggests two
candidates:

	for-linus/i2c
	next-i2c

And I think for now this is only parsed by humans and everbody should b=
e
able to notice that e.g. "next-s3c" doesn't contain i2c patches in the
presence of the two above branches.

So unless there is a syntax to specify more than one branch I suggest t=
o
keep it as is.  Or should we only list next-i2c?  Ben, what do you
think?

(Maybe we can just make it:

	T: git git://git.fluff.org/bjdooks/linux.git for-linus/i2c
	T: git git://git.fluff.org/bjdooks/linux.git next-i2c

but this is a bit too much IMHO.  (Who volunteers to list all branches
of tip in MAINTAINERS? ;-))

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
