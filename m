From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 5/6] i2c: Replace I2C_CROS_EC_TUNNEL dependency
Date: Mon, 24 Aug 2015 14:18:45 +0200
Message-ID: <20150824121845.GC3608@katana>
References: <1439983198-4696-1-git-send-email-javier@osg.samsung.com>
 <1439983198-4696-6-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439983198-4696-6-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2015 at 01:19:57PM +0200, Javier Martinez Canillas wrote:
> The ChromeOS EC tunnel I2C bus driver depend on CROS_EC_PROTO but
> MFD_CROS_EC select CROS_EC_PROTO instead. Mixing select and depends
> on is bad practice as it may lead to circular Kconfig dependencies.
>=20
> Since the platform device that is matched with the I2C bus driver
> is registered by the ChromeOS EC mfd driver, I2C_CROS_EC_TUNNEL
> really depends on MFD_CROS_EC. And because this config option
> selects CROS_EC_PROTO, that dependency is met as well. So make the
> driver to depend on MFD_CROS_EC instead of CROS_EC_PROTO.
>=20
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
>=20

Applied to for-next, thanks!


--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV2wulAAoJEBQN5MwUoCm2XVgP/AqQ/TcRZhyyTcxvl03HBpIW
HvBIU+MlBo5JzzcvedpGI10Z8oy5bsRUs1dT0cDbEJLtbqji/xXdqclIp/0QPOI/
chhGFY8lHGAvNfiAuyh35nG27iS/OFmPLISsZNow6/8RdigJytPxmU6+bjqDtkf0
njQc/y4W2Y3srX9t5G4rjxKBEsAlZ6Td3U8hVmilQi6TcvKXRj8DQjiUj4wLM40D
VZYTT/4dfYx8X2KKiIiX9d5NvsI14fzZn+HZXoa5UXGK3b+0iuAE1IFDcCD5F0K+
fJ+m4PnyGKSWvxNnQu7TOgXH2TWnOWAsDr3xsfwWBFxMFzjYWUOKMh9gH97dZMbD
WeTNBWZWL+AK+hJgAXCvvMq99Aj268roT6Xtk34ZNodNBeqmF8Ai3nIRS2G73Be1
4sh/qVDuCYSIUZSRSKY2D4tk+AUkg0tJgg/4jtE18UdKXY+stNGf5/dnJkOA9QJS
26/vYI1TqNx6eKZdSEWB9Jz7g2ndPTyRgYY7zTEzSKrWr876PoRyABHgvROTtWQQ
zZMtHTBdPheZvh0HbBBxQ3dTe5yOLbfRjvXHEv3Dbvu5UijhlYMQMGYQPXI7e7LD
E0zwPc6wncVzvG0cOx8AW4zBeBF1Goaro2vOkBwnXwiVil/rk6lcoEiVS/FXj+e2
FuvY/vTKTXDzVGr+rqcI
=8bNo
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
