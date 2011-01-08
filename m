From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [i2c-tools][PATCH] honor CROSS_COMPILE
Date: Sat, 8 Jan 2011 22:01:30 +0100
Message-ID: <20110108210130.GC4045@pengutronix.de>
References: <1294426874-24973-1-git-send-email-nm@ti.com>
 <20110108192345.GB4045@pengutronix.de>
 <4D28C9D5.8050401@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D28C9D5.8050401-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 08, 2011 at 02:32:21PM -0600, Nishanth Menon wrote:
> Wolfram Sang wrote, on 01/08/2011 01:23 PM:
> >Then again, the vast majority of userspace-projects do not use CROSS_COM=
PILE.
> >Build systems like ptxdist and buildroot have done fine with overriding =
CC so
> >far. I don't see much gain in that addition.
> >
> The same is true for CROSS_COMPILE as well.. since the patch does
> still allow CC to be over-ridden (as was the previous behavior), why
> not add CROSS_COMPILE as well considering folks who could be cross
> compiling just i2ctools without using buildroot and the likes?

You can override CC even without a build-system :) I would sum it up like t=
his:
On the positive side you could call it "more flexible", on the negative side
you could call it "redundant". I wouldn't pick it up, but I surely have no
strong feelings about it. It is up to Jean, after all.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0o0KoACgkQD27XaX1/VRsSDwCgv3s7KgJG70nZZAUoIZOEpCLF
bkAAn2sIcYkDw3GjyNqSi47wubqGB1g6
=wORv
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
