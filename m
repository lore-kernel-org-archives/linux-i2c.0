From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon, 14 Mar 2016 10:39:04 +0100
Message-ID: <20160314093904.GC27975@ulmo>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160314091819.GA27975@ulmo>
 <20160314092809.GC1383@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37478 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbcCNJjI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 05:39:08 -0400
Content-Disposition: inline
In-Reply-To: <20160314092809.GC1383@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, gregkh@linuxfoundation.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2016 at 10:28:10AM +0100, Wolfram Sang wrote:
>=20
> > This doesn't work. I see a number of these WARN_ON()s trigger and I
> > think the reason is that i2c_init() always fails now. The cause seems to
> > be that i2c_init() calls i2c_add_driver(&dummy_driver), which will now
> > always fail, because is_register is set to true *after* that call. There
> > is no way I see I2C working at all after this patch.
>=20
> Same conclusion here. Too much trust applied to the original patch, mea
> culpa and sorry! Will send the fixup (tested!) in a minute.

No worries. There's nothing like good old runtime testing for making
sure things really do work. =3D)

Thierry

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW5oa2AAoJEN0jrNd/PrOh9mwQAJfDU7j2LaFegGcwHK49H47b
I0rOApM4zJd6bDwBseMFEHmb54EEvp2LY9XD2PsRka2nzFLQGLPDCvsmrhmyz9Ix
UnL1A+JVgCeyYh+szeRZ/ooG1y1ONheJjvlxvu0e0hpXgeX5oxyTYyYnpmvs2Vp/
H5Dv3oeRGM2BYwuJjVbt++1ae9hgTcViiV//aSXiheMlpd6WtwYsLLPZ3UblWd0H
bAo4TKR3ZhfpyjfylkVssNFzoYRivM/C510eKdcBFLH6ygcEdva5rEJAMkMbWRIs
c7fM0CLO60mhfxD1XQoevKD9TOM/TTH9lACyu6zJ+W6/tmwD8Iq6qv1dPjbgdBT2
nB7E2aohe+6DgleBwQ8QUpWKbldtLH8Hq8tKhb3+7s/MqEd77E+NxBl0DqiT1HLp
VQB8PgWPsaqhzsv1vxW4GtcXPYJd3wYwntUIUinGrnm06b8mjfGyXYWdJBGdvuDO
K7V1lw/RlpFO+p4Uh1jiiLJ34zEEiZrE7/Q4Hp4WfqtwYd/vGM+ES7vj+tHYMMz2
9h+jyNbsBRRncgLF8fNp/OqXFKHQCcl4JVcBLPZGIhHfY/I6ydRJA6tRyYpxdmtl
0vSk2xS2uPqKktWiystKIpCNligsB/1gaVOXPLy9eQvkzdBt0qXDzzEA7/LzQNNf
uKS9PoUNZeDQgxVfI5BR
=XO1N
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
