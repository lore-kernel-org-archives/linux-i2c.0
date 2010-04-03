From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: remove_clientdata_to_null-branch
Date: Sat, 3 Apr 2010 19:36:46 +0200
Message-ID: <20100403173646.GB2190@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

just wanted to announce that I put up a branch for removing the
i2c_set_clientdata(..., NULL)-calls, so you can see what the current status=
 is.
It will be rebased, so don't work on it (why would you? :)).

http://git.pengutronix.de/?p=3Dwsa/linux-2.6.git;a=3Dshortlog;h=3Drefs/head=
s/remove_clientdata_to_null

The main cleaning patch is a single patch scheduled for 2.6.35 as discuesse=
d.
I'd like to add another round of review before sending out a patch to this
list, probably around -rc4. (Altough I still wonder if we shouldn't wait for
2.6.35-rc1, then we could also catch the calls sitting now in linux-next).

Jean, have you noticed this one for 2.6.34?

http://article.gmane.org/gmane.linux.drivers.i2c/5784

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku3fK4ACgkQD27XaX1/VRvUMACbBg5W45ImyVppFkd4LN78pcaZ
EycAoMclSF4RHyO3F4iDCzXfzuTgFhea
=rv0y
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
