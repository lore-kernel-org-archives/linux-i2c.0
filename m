From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 5/6] i2c: at91: print hardware version
Date: Wed, 10 Jun 2015 21:15:20 +0900
Message-ID: <20150610121519.GB1592@katana>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
 <d1fbf4bce3b470409ef3198f551cfc3f8f22ac78.1433866582.git.cyrille.pitchen@atmel.com>
 <5577428C.3090206@cogentembedded.com>
 <20150610080553.GO25800@odux.rfo.atmel.com>
 <55782935.30608@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55782935.30608@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >>>-	dev_info(dev->dev, "AT91 i2c bus driver.\n");
> >>>+	dev_info(dev->dev, "AT91 i2c bus driver (version: %#x).\n",
>=20
> >>    It looks as if you rather print the driver's version. :-)
>=20
> > From my point of view, having a version number for a Linux driver would
> >be strange
>=20
>    Not everybody shares your opinion.

I tend to agree with Sergei but let's keep things simple: I'll make it
"hw version" before applying.


--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeCpXAAoJEBQN5MwUoCm2akUP/2pFV/nPqlCYBhEkJpbm0pu/
kppaAg8UXYFoW3zAmw5JnDZYU6H3W0gmhOziEZ7KJEOtXvAGInEdosZsGAyfjNhv
hROqnIHTJfnA8I/jAFq8ji5/687XhbNYLneMDd+yaUNnYR4Jn3/4matbSH/RXfkE
7X7g/VnMSAgem9cQmGxuz2PMFGzzfwF5bEWNb4kMi4Ov3PzT9sZX7oiYz8mgAySv
U/hJUDx05MPJL+zOT6sWXOOlA/mUWHYWGjLFvbYuzNRI4Qr9eQU06D19ruwXkrEK
rb4WyvLqAHCa/5fUzsmmG0Rr08bGh3rWsesgFvCONLZQH6RjT54gSGXymtMKrI3y
9Y58w10Z2B2/OS8P8hgGdLgHylA1amDaxLBP3K+VoiuL9Spug8WMkxioeaGPhwH6
kiR7L04oEymR+1//tCd13AWcmA/uLpXpR9oErt1I2CrhEYK4IJN0Yg86pjFOf0s7
+dxh1+2r/O3TzEC9CzLcxou3EfmB8RiSaO75k8YnRkTayy8pGLsjISEbWxbgJZVm
7DAw0toV2cEXCoHMCLzSvMXs5sseHplUK+26NC9g1sBUPzpF11GuGjIbA2l0Oe+t
eBeICBfKRWlGExQw82/yaQGtvQ2IF147NZmGYAjRpHJaIGq2xieox8rFo6I/tUYP
cKv8Ongu0dtHj3Lflrxk
=waUi
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
