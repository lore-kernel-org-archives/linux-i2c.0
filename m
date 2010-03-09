From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] at24: Fall back to byte or word reads if needed
Date: Tue, 9 Mar 2010 15:17:52 +0100
Message-ID: <20100309141752.GE4664@pengutronix.de>
References: <20100308161838.19668ae9@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100308161838.19668ae9-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2010 at 04:18:38PM +0100, Jean Delvare wrote:
> Increase the portability of the at24 driver by letting it read from
> EEPROM chips connected to cheap SMBus controllers that support neither
> raw I2C messages nor even I2C block reads. All SMBus controllers
> should support either word reads or byte reads, so read support
> becomes universal, much like with the legacy "eeprom" driver.
>=20
> Obviously, this only works with EEPROM chips up to AT24C16, that use
> 8-bit offset addressing. 16-bit offset addressing is almost impossible
> to support on SMBus controllers.
>=20
> I did not add universal support for writes, as I had no immediate need
> for this, but it could be added later if needed (with the same
> performance issue as byte and word reads have, of course.)
>=20
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

This one also

Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuWWJAACgkQD27XaX1/VRuSUACdFA/G+fJ53gtoWqdGhWwKIkkF
uU4AoJDji1M3pVsDM5CIdcyCG6qu4KSr
=QgY/
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
