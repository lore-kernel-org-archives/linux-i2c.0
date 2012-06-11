From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/8] i2c: i2c-bfin-twi: Tighten condition when failing
 I2C transfer if MEN bit is reset unexpectedly.
Date: Mon, 11 Jun 2012 18:33:57 +0200
Message-ID: <20120611163357.GE3887@pengutronix.de>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
 <1337152826-9850-4-git-send-email-sonic.zhang@analog.com>
 <CAM=Q2cta_a2XcOLoOnnUUjZOpj1phUH99xfgZnh4nhxG8QX3-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cta_a2XcOLoOnnUUjZOpj1phUH99xfgZnh4nhxG8QX3-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2012 at 05:00:40PM +0530, Shubhrajyoti Datta wrote:
> On Wed, May 16, 2012 at 12:50 PM,  <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrote:
> > From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >
> > Correct I2C transfer may fail because interrupt status bits XMTSERV and
> > RCVSERV are not checked when MCOMP interrupt is handled.
> >
> Could you expand MCOMP?

I agree. It is nice to understand patch descriptions without needing to
know all the datasheet terminology, so please rework the description a
little.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/WHfUACgkQD27XaX1/VRsfigCeJXnlD8bakgy760zwhwD61sfF
ogEAnjHsnD/rk8bddZWImg4K4vn+sk61
=noP8
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
