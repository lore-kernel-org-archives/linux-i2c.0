From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: i2c/busses/i2c-highlander.c: using char variable in bit
	operation
Date: Mon, 1 Feb 2010 11:15:09 +0100
Message-ID: <20100201101509.GB3288@pengutronix.de>
References: <BLU108-W10538CE8A7EF6373FB36AE9C580@phx.gbl> <20100201110721.461fd142@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100201110721.461fd142-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: d binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2010 at 11:07:21AM +0100, Jean Delvare wrote:
> On Mon, 1 Feb 2010 09:51:42 +0000, d binderman wrote:
> >=20
> >=20
> > Hello there,
> >=20
> > I just ran the sourceforge tool cppcheck over the source code of the
> > new Linux kernel 2.6.33-rc6
> >=20
> > It said
> >=20
> > [./i2c/busses/i2c-highlander.c:284]: (style) Warning - using char varia=
ble in bit operation
> >=20
> > The source code is
> >=20
> > static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned short flags, char read_write,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 command, int size,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 union i2c_smbus_data *data)
> > {
> > =A0=A0=A0=A0=A0=A0=A0 struct highlander_i2c_dev *dev =3D i2c_get_adapda=
ta(adap);
> > =A0=A0=A0=A0=A0=A0=A0 int read =3D read_write & I2C_SMBUS_READ;
> >=20
> > In C, chars can be signed or unsigned, so the value written into
> > local variable read by sign extension is not certain.
> >=20
> > Suggest new code
> >=20
> > static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned short flags, char read_write,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 command, int size,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 union i2c_smbus_data *data)
> > {
> > =A0=A0=A0=A0=A0=A0=A0 struct highlander_i2c_dev *dev =3D i2c_get_adapda=
ta(adap);
> > =A0=A0=A0=A0=A0=A0=A0 int read =3D ((unsigned char) read_write) & I2C_S=
MBUS_READ;
>=20
> read_write can only have value 0 or 1, so we don't care if chars are
> signed or not. That being said, the code above looks odd, the value of
> read_write can be used in the code directly without using an
> intermediate variable:
>=20
> 	iowrite16((addr << 1) | read_write, dev->base + SMSMADR);
>=20
> This would solve your warning issue and make the code more simple too.

Don't forget to convert the 'if (read)' below, too.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktmqa0ACgkQD27XaX1/VRt8KgCgiJOeOpodpww1mHjRLBP2VbOv
Rv4AniX5n0Xsqtk5JgE4gWP6YEd6x1+N
=+001
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
