From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RESEND] i2c: add sc18is600 driver
Date: Sun, 18 Jun 2017 16:02:28 +0200
Message-ID: <20170618140228.lmrvlgmp5vwnbblv@earth>
References: <20170613154748.7018-1-sre@kernel.org>
 <CAHp75VexRjTZ+kbrPvD=RWy+_OBSnKAYj1-TX8aO5QgyOsn7nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgpwq6l365pphdml"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752102AbdFROCb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Jun 2017 10:02:31 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VexRjTZ+kbrPvD=RWy+_OBSnKAYj1-TX8aO5QgyOsn7nA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--wgpwq6l365pphdml
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks for your feedback.

On Sat, Jun 17, 2017 at 09:13:32PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 13, 2017 at 6:47 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > This adds an I=B2C master driver for SPI -> I=B2C bus bridge chips.
> > It currently supports NXP's SC18IS600 and SC18IS601, as well as
> > Silicon Labs' CP2120. The driver was only tested on SC18IS600.
>=20
> > +static void sc18is600_setup_clock_frequency(struct sc18is600dev *dev)
> > +{
> > +       int reg =3D DIV_ROUND_UP(dev->clock_base, dev->i2c_clock_freque=
ncy);
> > +
>=20
> > +       if (reg < 5)
> > +               reg =3D 5;
> > +       if (reg > 255)
> > +               reg =3D 255;
>=20
> clamp_t()

I will use clamp_val()

> [...]
> lot's of suggestions for improvements.
> [...]

Ack.

> ...and better to use s600dev or alike to avoid confusion.
>=20
> > +               return -ENOMEM;
>=20
> > +       snprintf(dev->adapter.name, sizeof(dev->adapter.name),
>=20
> > +                "SC18IS600 at SPI %02d device %02d",
>=20
> Isn't too much for adapter name?
> I don't remember if it's part of ABI, in that case it's even worse.

Well, it's displayed by "i2cdetect -l". Here are the names from some
other drivers, which I used as reference:

i2c-tiny-usb at bus %03d device %03d
i2c-diolan-u2c at bus %03d device %03d
OSIF at bus %03d device %03d
SMBus Via Pro adapter at %04x
SMBus SIS5595 adapter at %04x

> [...]
> lot's of suggestions for improvements.
> [...]

Ack.

-- Sebastian

--wgpwq6l365pphdml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllGh/EACgkQ2O7X88g7
+prJgRAAnZF4WwDKXjplHgqm3ybfq78f2XOe7EOpvuK4196YIfpjdClGZTdmwHcM
Cr8g9rgNgAc9SX8P74IAEcXfs7EGGSkbN1rU88stjUaz6ZfWOU69HAn3Wbgvx0X5
qc+MKfB58L95DZJgKiZ+3ChcwILHuIjRonTjfyfynySrPhfAk+Y54tXLEa0auk3F
vZdhBV7FS2XPnZ+YDPd0D8XmxqAMb0k59YCyFVwjEqUy4HIUHMUP/YA28KVj6wrP
y1YloOeCFL+iJvneRb68Nq0tt0qVpfXmxtH4bFzlVjhNKE8JCSFoKZXx144IGHGY
v12PJu6+F7Jol7lP7J7vGA9X2KhHHk/h/IKxPTvoLFGW5Z6v7lA5GGTLDRXPp2ZN
uyqO+b4b8f0PIk3UzQ3k9NyJIpqNaAG3s1QxaM/8AXnyZfCxFot/ncOIaCATxcrg
8ZS0O+bxWftL8uA9e9JTF64226bh5L4g/QG/vfbUWZdaFGnMx2YfMAjs5l77wwel
GISRbsnJ64QiTC/PnMBkAH1CzpcyZFxhWLZnYqsOdYv51UtPgoa2kuFVwcEPFDJB
gPDWAvtUS4W2fLObBUmNmKhpTIoaHOAFWRhr3LFAwbGtGMTA3fIXjRWZVr6Aw1Pa
vQ/c+BMNUDX3/Qwzolp8G9LR8eQO3pXtr9k8eRnYc21pzlfvA1g=
=8/PG
-----END PGP SIGNATURE-----

--wgpwq6l365pphdml--
