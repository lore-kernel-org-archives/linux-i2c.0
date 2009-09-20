From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] max6875: Discard obsolete detect method
Date: Sun, 20 Sep 2009 13:35:31 +0200
Message-ID: <20090920113531.GA12195@pengutronix.de>
References: <20090920120746.5bc4e1f0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090920120746.5bc4e1f0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2009 at 12:07:46PM +0200, Jean Delvare wrote:
> There is no point in implementing a detect callback for the MAX6875, as
> this device can't be detected. It was there solely to handle "force"
> module parameters to instantiate devices, but now we have a better sysfs
> interface that can do the same.
>=20
> So we can get rid of the ugly module parameters and the detect callback.
> This basically divides the binary module size by 2.
>=20
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Nice!

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq2E4MACgkQD27XaX1/VRs76QCePnzhtQvZEUonBXWFHHeZmbzu
5BwAoLC3ApqCL4i37PoYppDTB8YBQKfl
=qCKR
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
