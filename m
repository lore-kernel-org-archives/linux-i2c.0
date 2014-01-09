From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: viperboard: remove superfluous assignment
Date: Thu, 9 Jan 2014 22:18:57 +0100
Message-ID: <20140109211857.GA3866@katana>
References: <1388870493-6523-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388870493-6523-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2014 at 10:21:33PM +0100, Wolfram Sang wrote:
> cppcheck rightfully says:
>=20
> drivers/i2c/busses/i2c-viperboard.c:169: style: Variable 'bytes_xfer' is =
assigned a value that is never used.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzxJAAAoJEBQN5MwUoCm2s7UQALZPN3j6yQUdqvfKRqvWrogH
BBnUN+HiTKpG+jBCfzRlvJnxzSCaoNEJuH7hbe4Dp7KXKysVPLYaLhK0tXgYaeJp
3Vq1fCE8A/vMoG3bhRXh4PeKg5Q6xYYQXO6UdaHc6hGf5CkfktRd8ATaAJZa6imY
yDC5aU52JqFOi+3KwvKJFu8xMs3UWmC4LLSlRCRye9gApewV84XZFS08Ez7jhQdj
fIHM5OiHMRQgFo0WMmZBdIObsW0rQ8Nxz+RsfKv/WN0YRwh73fCHqKzOKidKA/H+
PEMNipQaM6PToBsANfDDma6MNbPNs3sW4UYr7r7aUW0MHDPIkTRfTKTp/aLMsgHu
XHELjQ6CYYFvu2178D0SF02Zvwk/iU8wXa47Wf0So+5QUdAhObijEeR6axrfLWQx
Qepo2K6//0dzIQuXL4UU2fRl+vuB04wyen5snO3Yq44UiKRljzS/By7lnv1hBHNR
CS0AkkXzTnfL8WJtTo0jPtQqfOD5lQWoS5vpNKbVHGg4CDXi7wffb9zjnkvvoL+l
d3Ur8rN/GnFzX7Aq4+SOX9pL6AcFJWQC5NMFCXwZ/MbBBdcM2FOoz1i9DUSlWiOt
0G2k24mA1qTejPHbmjARGspVk6M/Pu0JOvBwoOh1GgMdz3bS4GYlJcLrsREmYXrT
vX90AWma7HocKxTROUwI
=Ef3u
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
