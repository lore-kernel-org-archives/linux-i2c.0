From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c/busses/i2c-highlander.c: using char variable in bit
 operation
Date: Mon, 1 Feb 2010 11:07:21 +0100
Message-ID: <20100201110721.461fd142@hyperion.delvare>
References: <BLU108-W10538CE8A7EF6373FB36AE9C580@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BLU108-W10538CE8A7EF6373FB36AE9C580-MsuGFMq8XAE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: d binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 1 Feb 2010 09:51:42 +0000, d binderman wrote:
>=20
>=20
> Hello there,
>=20
> I just ran the sourceforge tool cppcheck over the source code of the
> new Linux kernel 2.6.33-rc6
>=20
> It said
>=20
> [./i2c/busses/i2c-highlander.c:284]: (style) Warning - using char var=
iable in bit operation
>=20
> The source code is
>=20
> static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 ad=
dr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned shor=
t flags, char read_write,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 command, i=
nt size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union i2c_smb=
us_data *data)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct highlander_i2c_dev =
*dev =3D i2c_get_adapdata(adap);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int read =3D read_write & =
I2C_SMBUS_READ;
>=20
> In C, chars can be signed or unsigned, so the value written into
> local variable read by sign extension is not certain.
>=20
> Suggest new code
>=20
> static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 ad=
dr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned shor=
t flags, char read_write,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 command, i=
nt size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union i2c_smb=
us_data *data)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct highlander_i2c_dev =
*dev =3D i2c_get_adapdata(adap);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int read =3D ((unsigned ch=
ar) read_write) & I2C_SMBUS_READ;

read_write can only have value 0 or 1, so we don't care if chars are
signed or not. That being said, the code above looks odd, the value of
read_write can be used in the code directly without using an
intermediate variable:

	iowrite16((addr << 1) | read_write, dev->base + SMSMADR);

This would solve your warning issue and make the code more simple too.

--=20
Jean Delvare
