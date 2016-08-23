From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 3/8] i2c: thunderx: Add i2c driver for ThunderX SOC
Date: Tue, 23 Aug 2016 22:39:41 +0200
Message-ID: <20160823203941.GC20872@katana>
References: <cover.1465997603.git.jglauber@cavium.com>
 <1ead8831e4dd879d452e8bc1a2a33ccba3a74b3d.1465997604.git.jglauber@cavium.com>
 <20160823203628.GB20872@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37088 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbcHWUjr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 Aug 2016 16:39:47 -0400
Content-Disposition: inline
In-Reply-To: <20160823203628.GB20872@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2016 at 10:36:29PM +0200, Wolfram Sang wrote:
>=20
> >  i2c-octeon-objs :=3D i2c-cavium.o i2c-octeon-core.o
> >  obj-$(CONFIG_I2C_OCTEON)	+=3D i2c-octeon.o
> > +i2c-thunderx-objs :=3D i2c-cavium.o i2c-thunderx-core.o
> > +obj-$(CONFIG_I2C_THUNDERX)	+=3D i2c-thunderx.o
>=20
> Shouldn't that rather be "i2c-cavium-core.o",

Thinking of it again, it should probably even be "i2c-octeon-core.o" to
avoid confusion because all the functions start with octeon_*

> "i2c-octeon-platdrv.o",  and "i2c-thunderx-pcidrv.o" for the -objs?

Those names still make sense :)


--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvLSNAAoJEBQN5MwUoCm2hvoP/2Gd1mNGRjzi4fivRGpWmhCH
L05wjQVFqU1o2jTljH6DyvAodmeWzgq8mPG/KOWdmi4ulAxAyKbXs6wrPxqxJ0cU
1XopEp0w1e7bkx+b2wOZQGm0sHZ+B/q5ooYLpMKpCFxFpqG8rC20BstRYcVGqyGM
iTkXI4pT+Nbjsd5DAAdeUfI6Z5gKdEMWF+qq20GkWrNLCksb8tyWCiXQTfPdu9pD
vmCYDqWRGsOYn7+2kq0/PDR/7rRHs31NN65YMH7mqLms8LbXhkNdxo+TMeJsX/Sa
mxE9CgL9tAGMQl2ODFNyIq+R9EcRYWCLXXqNUJ/Ku6M3FMSyn5r83Pda/BOMK3jk
PL3GfYdU3or3KDfhzAn4F1/a0jVyI8JYZZkAv4qqL+s9Rf4zZ/7UV5ZPqjJhC3yA
xdLywC/L0Eg+zG3fblbQIOPf2PrL4h1lh2E4fAUyVu/IhP7bDW34lNTZKdQv9pdC
hsIF6RJM7GooN/FuaZyKzcTThR80F0q3SM4c+Le5wmIkmSyVp/Y35ZS2lLFzmScv
VlgmYRwJt7mbbrr9xhJ3T+2KrMY4+jzEtdVZfn2+l5st9jnBnd369vLYOLXUtESO
TYuAncpxliP7FCMx1JJ8xhspX83kAfZGN38Z6BIi62xVMAYI70DydmHePlxV47Qn
maCVqWq4W2+qDLcZw04G
=NKh1
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
