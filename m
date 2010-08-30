From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C driver modification for BH1710FVC Ambient Light Sensor
Date: Mon, 30 Aug 2010 17:58:36 +0200
Message-ID: <20100830175836.65260450@hyperion.delvare>
References: <AANLkTinzBkHsLO3TqwoPFb3AjVQ5xziSg_F7wFtB0c0R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinzBkHsLO3TqwoPFb3AjVQ5xziSg_F7wFtB0c0R-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?Um9nw6lyaW8=?= de Souza Moraes <rogerio.souza-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rog=C3=A9rio,

On Mon, 30 Aug 2010 12:33:26 -0300, Rog=C3=A9rio de Souza Moraes wrote:
> Hi folks,
>=20
> I am developing a driver for the Ambient Light Sensor BH1710FVC that
> communicates by i2c bus. My problem is that the type of message that
> this chip accept is this:
>=20
> S Addr Rd [A] [DataHigh] A [DataLow] NA P
>=20
> I searched in the file "Documentation/i2c/smbus-protocol" for one
> function that communicate like this, but I did not find. I tried to
> use the function i2c_smbus_read_byte twice (reading data high first
> and so the data low), but the chip do not accept communicate this way=
=2E
>=20
> So I've based in the function i2c_smbus_read_byte to build the
> function that implements the protocol like I need.
>=20
> I modified the file i2c-core.c in the function i2c_smbus_xfer_emulate=
d
> creating an I2C_SMBUS_WORD.
> In first switch I add:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2C_SMBUS_WORD:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (read_write =3D=3D I2C_SMBUS_READ) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
sg[0].len =3D 2;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
sg[0].flags =3D I2C_M_RD | flags;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
um =3D 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>=20
> and for the second switch I added the following case:
>=20
>                         case I2C_SMBUS_WORD:
>                                 data->word =3D msgbuf0[0] | (msgbuf0[=
1] << 8);
>                                 break;
>=20
> After this modification my Ambient Light Sensor driver is working jus=
t fine.
>=20
> So I want to know if there is a better way to implement this without
> need to modify the i2c driver.

As the transaction format you need isn't part of SMBus, I assume that
your controller is an I2C master and you should simply use
i2c_master_recv() in your device driver.

--=20
Jean Delvare
