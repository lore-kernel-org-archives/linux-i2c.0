From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Writing to AT24C64C EEPROM fails on RHEL based kernels
Date: Mon, 7 Mar 2011 20:48:19 +0100
Message-ID: <20110307194819.GA17883@pengutronix.de>
References: <4D753233.8060208@riverbed.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D753233.8060208-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Munir Bandukwala <munirb-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> While looking for patches, I came accross
> https://bugzilla.redhat.com/show_bug.cgi?id=3D182687 and adding an extra =
delay
> in the piix4_transaction function fixes the problem for me as well.

So, this is not a problem anymore if I understand you correctly?

> I think the problems are related, but any pointers would be appreciated. =
I am
> pasting information about my machine, please let me know if you guys needs
> any more information

This seems normal to me. The eeprom needs time to write the data. Any reaso=
ns
for not using the in-kernel eeprom driver (drivers/misc/eeprom/at24.c)? It
deals with all of that (and probably more).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk11NoMACgkQD27XaX1/VRvZxgCgo+aHFh+l6ZkPKXfiHp5udJTv
Q4AAoMBfz3XuFluHNQKRubQW+x2cZeT1
=uucj
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
